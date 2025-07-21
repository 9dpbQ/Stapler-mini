//
//  PopoverView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

struct PopoverFromDetail: View {
    @EnvironmentObject private var viewModel: ViewModel

    @State var keyboardKey: KeyboardKey

    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: keyboardKey.unitSize, baseSizeX: viewModel.configuration.displayKeySize)
    }
    
    var body: some View {
        VStack {
            KeytopView_FromDetail(
                fromDetail: keyboardKey.fromDetail,
                isSelected: true,
                keyMetrics: KeyMetrics(unitSize: keyMetrics.unitSize, baseSizeX: 65),
                keyShape: keyboardKey.keyShape
            )
//            .background(Color.red.opacity(0.5))
            
            List {
                Section {
                    Stepper {
                        Text(keyboardKey.unitSize.formatUnitSize())
                    } onIncrement: {
                        withAnimation {
                            keyboardKey.unitSize += 0.25
                        }
                    } onDecrement: {
                        if keyboardKey.unitSize > 0.5 {
                            withAnimation {
                                keyboardKey.unitSize -= 0.25
                            }
                        }
                    }
                    .disabled(keyboardKey.keyShape != .square)
                    
                    Toggle("is Spacer", isOn: $keyboardKey.isSpacer)
                        .toggleStyle(.switch)
                    
                    Picker("Shape", selection: $keyboardKey.keyShape) {
                        ForEach(KeyShape.allCases.filter { !$0.isArrows }, id: \.self) { shape in
                            Text(shape.rawValue).tag(shape)
                        }
                    }
                    .disabled(keyboardKey.keyShape.isArrows)
                    .labelsHidden()
                    .onChange(of: keyboardKey.keyShape) { _, newShape in
                        if let unitSize = newShape.handleShapeChanged() {
                            withAnimation {
                                keyboardKey.unitSize = unitSize
                            }
                        }
                    }
                }
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(minWidth: 180, minHeight: 100)
            .animation(.easeInOut, value: keyMetrics.unitSize)
        }
    }
}

struct PopoverToDetail: View {
    @State var toDetail: ToDetail
    @State var keyShape: KeyShape
    @State var keyMetrics: KeyMetrics
    
    @State var isTapHoldExpanded: Bool = false
    
    init(toDetail: ToDetail, keyShape: KeyShape, keyMetrics: KeyMetrics) {
        self.toDetail = toDetail
        self.keyShape = keyShape
        self.keyMetrics = keyMetrics
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                VStack {
                    Text("Tap")
                    KeyTopView_ToDetail(
                        toDetail: $toDetail,
                        keyShape: keyShape,
                        keyMetrics: KeyMetrics(unitSize: keyMetrics.unitSize, baseSizeX: 65),
                        tapOrHold: .tap
                    )
                    ModifierToggleView(withModifier: $toDetail.withModifier_tap)
                }
                if toDetail.isTapHoldEnabled {
                    Spacer()
                    VStack {
                        Text("Hold")
                        KeyTopView_ToDetail(
                            toDetail: $toDetail,
                            keyShape: keyShape,
                            keyMetrics: KeyMetrics(unitSize: keyMetrics.unitSize, baseSizeX: 65),
                            tapOrHold: .hold
                        )   
                        ModifierToggleView(withModifier: $toDetail.withModifier_hold)
                    }
                    .transition(.move(edge: .leading).combined(with: .opacity)) // ➡️ 右からスライドイン＆フェードイン
                }
                Spacer()
                
            }
            .font(.caption)
            .foregroundStyle(.gray)
            
            List {
                Section {
                    DisclosureGroup(isExpanded: $isTapHoldExpanded) {
                        Group {
                            if toDetail.isTapHoldEnabled {
                                Picker("Tap Hold Type", selection: $toDetail.tapHoldType) {
                                    ForEach(TapHoldType.allCases, id: \.self) { type in
                                        Text(type.rawValue.capitalized).tag(type)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.segmented)
                            } else {
                                Text("Tap Hold is not Enabled")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                    } label: {
                        Toggle("Tap Hold", isOn: $toDetail.isTapHoldEnabled)
                            .toggleStyle(.switch)
                            .onChange(of: toDetail.isTapHoldEnabled) { oldValue, newValue in
                                withAnimation {
                                    if newValue && !isTapHoldExpanded {
                                        isTapHoldExpanded = true
                                    } else {
                                        isTapHoldExpanded = false
                                    }
                                }
                            }
                    }
                }
            }
//            .listStyle(.plain)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(minWidth: 180, minHeight: 70)
        }
        .onAppear {
            isTapHoldExpanded = toDetail.isTapHoldEnabled
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: toDetail.isTapHoldEnabled)
    }
}

struct PopoverView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var keyboardKey: KeyboardKey
    @State var selections: Selections
    
    @Binding var showPopover: Bool
    
    @State var keyboardMonitor: KeyboardMonitor
    
    @State var indicator_tap: Bool = false
    @State var indicator_hold: Bool = false
    
    let macroCollection: MacroCollection
    let keyMetrics: KeyMetrics
    
    private var toDetail: ToDetail {
        keyboardKey.getToDetail(
            selections.condition,
            layer: selections.layer
        )
    }
    
    private var fromDetail: FromDetail {
        keyboardKey.fromDetail
    }
    
    var body: some View {
        VStack {
            switch selections.tab {
            case .deviceEdit:
                PopoverFromDetail(keyboardKey: keyboardKey)
            case .remap:
                PopoverToDetail(toDetail: toDetail, keyShape: keyboardKey.keyShape, keyMetrics: keyMetrics)
            default:
                EmptyView()
            }
        }
        .background(Color.clear)
        .padding()
    }
}
