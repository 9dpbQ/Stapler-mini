//
//  ComboDetailView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct ComboDetailView: View {
    
    @Binding var combo: Combo
    @EnvironmentObject private var viewModel: ViewModel
    
    @Binding var nextIndicator: Bool
    
    private var macroCollection: MacroCollection { viewModel.configuration.macroCollection }
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: 65)
    }
    private var selectedLayer: Layer { viewModel.configuration.selections.layer }
    private var selectedCondition: SpecificCondition { viewModel.configuration.selections.condition }
    @State private var isHovered: Bool = false
    @State private var showPopover: Bool = false
    @State private var hoverTimer: Timer? = nil
    private var indicator: Bool { combo.indicator }
    
    private var isComboSelected: Bool {
        combo == viewModel.configuration.selections.combo
    }
    
    init(
        combo: Binding<Combo>,
        nextIndicator: Binding<Bool>
    ) {
        self._combo = combo
        self._nextIndicator = nextIndicator
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                viewModel.configuration.selections.combo = combo
            }
        }) {
            KeyTopView_combo(isSelected: isComboSelected, hilightColor: viewModel.configuration.selections.layer.accentColor)
                .background(
                    ZStack {
                        ForEach(combo.simultaneouses.indices.reversed(), id: \.self) { index in
                            KeyTopView_combo(isSelected: isComboSelected, hilightColor: viewModel.configuration.selections.layer.accentColor)
                                .opacity(exp(-0.5 * Double(index))) // 透明度の減り方を緩やかに
                                .rotationEffect(.degrees(Double(index * 10)))
                                .scaleEffect(1.0 - (0.01 * Double(index)))
                        }
                    }
                )
                .overlay {
                    holdKeyView
                    tapKeyView
                    RecordingIndicatorView(indicator: combo.indicator, keyMetrics: keyMetrics, keyShape: .square)
                    CautionView(
                        caution: combo.toDetail.error,
                        keyMetrics: keyMetrics, keyShape: .square,
                        helpText: "An error occurred with this Combo during the last export."
                    )
                }
                .modifier(KeyTopShapeFrame(.square, keyMetrics: keyMetrics))
                .onTapGesture(count: 2, perform: {
                    print("double clicked")
                    viewModel.keyboardMonitor.startMonitoring_combo_Next(
                        //                    combo: $combo,
                        configuration: $viewModel.configuration,
                        nextIndicator: $nextIndicator
                    )
                })
                .dropDestination(for: DragClass.self) { items, location in
                    guard let item = items.first else { return false }
                    if let custom = item.customizeKey {
                        print("customizeKey dropped!")
                        combo.applyCustom_tap(from: custom)
                        return true
                    } else if let macro = item.macro {
                        print("macro dropped!")
                        combo.applyMacro_tap(from: macro)
                        return true
                    }
                    return true
                }
                .onHover { hovering in
                    handleHoverChange(isHovering: hovering)
                }
                .popover(isPresented: $showPopover, arrowEdge: .trailing) {
                    PopoverView_combo(
                        combo: $combo,
                        layer: viewModel.configuration.selections.layer,
                        isHovered: $isHovered,
                        showPopover: $showPopover,
                        keyboardMonitor: viewModel.keyboardMonitor,
                        macroCollection: macroCollection,
                        keyMetrics: keyMetrics
                    )
                }
                .frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
        }
        .buttonStyle(.plain)
    }
    // ホバー状態の変化を処理
    private func handleHoverChange(isHovering: Bool) {
        if combo == viewModel.configuration.selections.combo {
            if isHovering {
                // 既存のタイマーを無効化
                hoverTimer?.invalidate()
                hoverTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    isHovered = true
                    showPopover = true
                }
            } else {
                hoverTimer?.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if !isHovered {
                        showPopover = false
                    }
                }
            }
        }
    }
    
    private var holdKeyView: some View {
        Group {
            if (combo.toDetail.isTapHoldEnabled && combo.toDetail.isCustomized_hold) {
                if combo.toDetail.isMacro_hold {
                    MacroTextView(macro_id: combo.toDetail.macro_id_hold, layer: selectedLayer)
                } else {
                    SFSymbolOrTextView(
                        symbolName: combo.toDetail.outputAndDisplay_hold.display,
                        isSFSymbol: combo.toDetail.outputAndDisplay_hold.isSFSymbol,
                        size: keyMetrics.fontSize_hold,
                        color: combo.toDetail.outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor
                    )
                }
            } else {
                EmptyView()
            }
            
        }
        .opacity(0.5)
    }
    private var tapKeyView: some View {
        Group {
            if combo.toDetail.isCustomized_tap {
                customizedContent
            } else {
                Text("drop here")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
        }
    }
    private var customizedContent: some View {
        Group {
            HStack(spacing: 0) {
                if combo.toDetail.isMacro_tap {
                    MacroTextView(macro_id: combo.toDetail.macro_id_tap)
                } else {
                    ModifierContentView(withModifier: combo.toDetail.withModifier_tap, keyMetrics: keyMetrics, color: combo.toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
                    SFSymbolOrTextView(
                        symbolName: combo.toDetail.outputAndDisplay_tap.display,
                        isSFSymbol: combo.toDetail.outputAndDisplay_tap.isSFSymbol,
                        size: keyMetrics.fontSize_tap,
                        color: combo.toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor
                    )
                }
            }
            //Tapにレイヤー遷移キーが入っている場合はそのレイヤーのカラー、それ以外の場合は現在のレイヤーの色
            .foregroundColor(combo.toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
        }
    }
    
}

struct KeyTopView_combo: View {
    
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: unitSize, baseSizeX: displayKeySize)
    }
    let isSelected: Bool
    let hilightColor: Color
    let keyShape: KeyShape
    let unitSize: Double
    let displayKeySize: CGFloat

    init(isSelected: Bool = false, hilightColor: Color = .white, keyShape: KeyShape = .square , unitSize: Double = 1, displayKeySize: CGFloat = 65) {
        self.keyShape = keyShape
        self.isSelected = isSelected
        self.hilightColor = hilightColor
        self.unitSize = unitSize
        self.displayKeySize = displayKeySize
    }
    
    var body: some View {
        keyShape.keytopShape(keyMetrics)
            .fill(
                isSelected
                ? LinearGradient(
                    colors: [ Color(red: 80/255, green: 80/255, blue: 70/255), Color(red: 50/255, green: 50/255, blue: 70/255)],
                    startPoint: .top, endPoint: .bottom
                )
                : LinearGradient(
                    colors: [ Color(red: 51/255, green: 49/255, blue: 42/255), Color(red: 18/255, green: 18/255, blue: 38/255)],
                    startPoint: .top, endPoint: .bottom
                )
            )
            .frame(
                width: keyShape.keytopSize(keyMetrics).width,
                height: keyShape.keytopSize(keyMetrics).height
            )
            .shadow(color: isSelected ? hilightColor : hilightColor.opacity(0), radius: isSelected ? keyMetrics.padding_keytop : 0)
//            .animation(.easeInOut, value: keyMetrics.unitSize)
    }
    private var alignmentForKeyShape: Alignment {
        switch keyShape {
        case .arrow_Up:
            return .bottom
        case .arrow_Down:
            return .top
        default:
            return .center
        }
    }
}
