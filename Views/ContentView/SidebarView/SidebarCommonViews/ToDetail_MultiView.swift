//
//  ToDetail_multiView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/22.
//

import SwiftUI

struct ToDetail_multiView: View {
    @EnvironmentObject private var viewModel: ViewModel

    @Binding var toDetail_multi: ToDetail_multi
    let isTapHoldEnabled: Bool
    
    private var macroCollection: MacroCollection {
        viewModel.configuration.macroCollection
    }
    
    private var keyboardMonitor: KeyboardMonitor {
        viewModel.keyboardMonitor
    }
    
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: viewModel.configuration.displayKeySize)
    }

    

    private var selectedLayer: Layer { viewModel.configuration.selections.layer }
    private var selectedCondition: SpecificCondition { viewModel.configuration.selections.condition }
    
    @State var indicator_tap: Bool = false
    @State var indicator_hold: Bool = false
    @State var keyShape: KeyShape
    
    var body: some View {
        HStack {
            Spacer()
            //Tap
            VStack {
                tapKeyView
                ModifierToggleView(withModifier: $toDetail_multi.withModifier_tap)
            }
            if isTapHoldEnabled {
                //TapHold
                Group {
                    Spacer()
                    VStack {
                        holdKeyView
                        ModifierToggleView(withModifier: $toDetail_multi.withModifier_hold)
                    }
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
            }
            Spacer()
            
        }
    }
    private var tapKeyView: some View {
        
        KeytopView_ToDetail_multi(
            toDetail_multi: toDetail_multi,
            tapOrHold: .tap,
            isSelected: true,
            keyMetrics: keyMetrics,
            keyShape: keyShape,
            labelColor: toDetail_multi.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor,
            hilightColor: selectedLayer.accentColor,
            indicator: indicator_tap
        )
        .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
        .onTapGesture(count: 2, perform: {
            keyboardMonitor.startMonitoring_toDetail_multi(
                $toDetail_multi,
                type: .tap,
                indicator: $indicator_tap
            )
        })
        .dropDestination(for: DragClass.self) { items, location in
            guard let item = items.first else { return false }
            if let custom = item.customizeKey {
                toDetail_multi.applyCustom_tap(from: custom)
                print("customizeKey dropped!")
                return true
            } else if let macro = item.macro {
                toDetail_multi.applyMacro_tap(from: macro)
                print("macro dropped!")
                return true
            }
            
            return true
        }
    }
    private var holdKeyView: some View {
        KeytopView_ToDetail_multi(
            toDetail_multi: toDetail_multi,
            tapOrHold: .hold,
            isSelected: true,
            keyMetrics: keyMetrics,
            keyShape: keyShape,
            labelColor: toDetail_multi.outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor,
            hilightColor: selectedLayer.accentColor,
            indicator: indicator_hold
        )
        .foregroundStyle(toDetail_multi.outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor)
        .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
        .onTapGesture(count: 2, perform: {
            keyboardMonitor.startMonitoring_toDetail_multi(
                $toDetail_multi,
                type: .hold,
                indicator: $indicator_hold
            )
        })
        .dropDestination(for: DragClass.self) { items, location in
            guard let item = items.first else { return false }
            if let custom = item.customizeKey {
                toDetail_multi.applyCustom_hold(from: custom)
                print("customizeKey dropped!")
                return true
            } else if let macro = item.macro {
                toDetail_multi.applyMacro_hold(from: macro)
                print("macro dropped!")
                return true
            }
            return true
        }
    }
}

struct KeytopView_ToDetail_multi: View {
    @State var toDetail_multi: ToDetail_multi
    let tapOrHold: TapOrHold

    let isSelected: Bool
    let keyMetrics: KeyMetrics
    let keyShape: KeyShape
    
    let labelColor: Color
    let hilightColor: Color
    
    let indicator: Bool
    
    private var withModifier: WithModifier {
        switch tapOrHold {
        case .tap:
            toDetail_multi.withModifier_tap
        case .hold:
            toDetail_multi.withModifier_hold
        }
    }
    private var isCustomized: Bool {
        switch tapOrHold {
        case .tap:
            toDetail_multi.isCustomized_tap
        case .hold:
            toDetail_multi.isCustomized_hold
        }
    }
    private var oad: OutputAndDisplay {
        switch tapOrHold {
        case .tap:
            toDetail_multi.outputAndDisplay_tap
        case .hold:
            toDetail_multi.outputAndDisplay_hold
        }
    }
    private var isMacro: Bool {
        switch tapOrHold {
        case .tap:
            toDetail_multi.isMacro_tap
        case .hold:
            toDetail_multi.isMacro_hold
        }
    }
    private var macro_id: String {
        switch tapOrHold {
        case .tap:
            toDetail_multi.macro_id_tap
        case .hold:
            toDetail_multi.macro_id_hold
        }
    }
    
    
    var body: some View {
        KeyTopView(isSelected: isSelected, hilightColor: hilightColor)
            .overlay {
                if isCustomized {
                    HStack {
                        if isMacro {
                            MacroTextView(macro_id: macro_id)
                        } else {
                            ModifierContentView(
                                withModifier: withModifier,
                                keyMetrics: keyMetrics,
                                color: labelColor
                            )
                            SFSymbolOrTextView(
                                symbolName: oad.display,
                                isSFSymbol: oad.isSFSymbol,
                                size: tapOrHold == .tap ? keyMetrics.fontSize_tap : keyMetrics.fontSize_hold,
                                color: labelColor
                            )
                        }
                    }
                } else {
                    Text("Drop here")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                RecordingIndicatorView(
                    indicator: indicator,
                    keyMetrics: keyMetrics,
                    keyShape: keyShape
                )
            }
            .contextMenu {
                Button("Reset Custom") {
                    withAnimation {
                        toDetail_multi.resetCustom(tapOrHold)
                    }
                }
            }
    }
}
