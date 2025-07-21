//
//  PopoverView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI


struct PopoverView_combo: View {
//    @EnvironmentObject private var viewModel: ViewModel
    @Binding var combo: Combo
    @State var layer: Layer
    
    @Binding var isHovered: Bool
    @Binding var showPopover: Bool
    
    @State var keyboardMonitor: KeyboardMonitor
    
    @State var indicator_tap: Bool = false
    @State var indicator_hold: Bool = false
    
    let macroCollection: MacroCollection
    let keyMetrics: KeyMetrics
    
    private var toDetail: ToDetail {
        combo.toDetail
    }
    
    var body: some View {
        VStack {
            PopoverToDetail(toDetail: combo.toDetail, keyShape: .square, keyMetrics: keyMetrics)
        }
        .background(Color.clear)
        .padding()
        .onHover { hovering in
            if hovering {
                isHovered = true
            } else {
                // ホバーが解除されたら遅延後に表示をリセット
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isHovered = false
                    showPopover = false
                }
            }
        }
    }
    
    private var popover_keymap: some View {
        Group {
            if !toDetail.isTapHoldEnabled {
                //tap
                VStack {
                    Text("Tap")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    ZStack {
                        tapKeyView_Keymap
                        RecordingIndicatorView(indicator: indicator_tap, keyMetrics: keyMetrics, keyShape: .square)
                    }
                    toggleTapHold_Keymap
                    ModifierToggleView(
                        withModifier:
                            Binding(
                                get: { toDetail.withModifier_tap },
                                set: { newValue in
                                    toDetail.withModifier_tap = newValue
                                }
                            )
                    )
                }
                
            } else {
                //tap hold
                VStack {
                    HStack {
                        VStack {
                            Text("Tap")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            ZStack {
                                tapKeyView_Keymap
                                RecordingIndicatorView(indicator: indicator_tap, keyMetrics: keyMetrics, keyShape: .square)
                            }
                        }
                        VStack {
                            Text("Hold")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            ZStack {
                                holdKeyView_Keymap
                                RecordingIndicatorView(indicator: indicator_hold, keyMetrics: keyMetrics, keyShape: .square)
                            }
                        }
                        
                    }
                    toggleTapHold_Keymap
                    HStack {
                        ModifierToggleView(
                            withModifier:
                                Binding(
                                    get: { toDetail.withModifier_tap },
                                    set: { newValue in
                                        toDetail.withModifier_tap = newValue
                                    }
                                )
                        )
                        ModifierToggleView(
                            withModifier:
                                Binding(
                                    get: { toDetail.withModifier_hold },
                                    set: { newValue in
                                        toDetail.withModifier_hold = newValue
                                    }
                                )
                        )
                    }
                }
            }
        }
    }
    private var tapKeyView_Keymap: some View {
        KeyTopView(isSelected: true, displaySize: keyMetrics.baseSizeX)
            .overlay {
                if toDetail.isCustomized_tap {
                    HStack {
                        if toDetail.isMacro_tap {
                            MacroTextView(macro_id: toDetail.macro_id_tap)
                        } else {
                            ModifierContentView(withModifier: toDetail.withModifier_tap, keyMetrics: keyMetrics)
                            SFSymbolOrTextView(
                                symbolName: toDetail.outputAndDisplay_tap.display,
                                isSFSymbol: toDetail.outputAndDisplay_tap.isSFSymbol,
                                size: keyMetrics.fontSize_tap
                            )
                        }
                    }
                } else {
                    Text("Drop here")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
        .foregroundStyle(toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? layer.accentColor)
        .frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
        .dropDestination(for: DragClass.self) { items, location in
            guard let item = items.first else { return false }
            if let custom = item.customizeKey {
                toDetail.applyCustom_tap(custom: custom)
                print("customizeKey dropped!")
                return true
            } else if let macro = item.macro {
                toDetail.applyMacro_tap(macro: macro)
                print("macro dropped!")
                return true
            }
            
            return true
        }
        .onTapGesture(count: 2, perform: {
            print("double clicked")
            indicator_tap = true
            keyboardMonitor.startMonitoring_ToDetail($combo.toDetail, type: .tap, indicator: $indicator_tap)
        })
    }
    private var holdKeyView_Keymap: some View {
        KeyTopView(isSelected: true, displaySize: keyMetrics.baseSizeX)
            .overlay {
                if toDetail.isCustomized_hold {
                    if toDetail.isMacro_hold {
                        MacroTextView(macro_id: toDetail.macro_id_hold)
                    } else {
                        HStack {
                            ModifierContentView(withModifier: toDetail.withModifier_hold, keyMetrics: keyMetrics)
                            SFSymbolOrTextView(
                                symbolName: toDetail.outputAndDisplay_hold.display,
                                isSFSymbol: toDetail.outputAndDisplay_hold.isSFSymbol,
                                size: keyMetrics.fontSize_hold
                            )
                        }
                    }
                } else {
                    Text("Drop here")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
        .foregroundStyle(toDetail.outputAndDisplay_hold.layerKey.layerKeyColor ?? layer.accentColor)
        .frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
        .dropDestination(for: DragClass.self) { items, location in
            guard let item = items.first else { return false }
            if let custom = item.customizeKey {
                toDetail.applyCustom_hold(custom: custom)
                print("customizeKey dropped!")
                return true
            } else if let macro = item.macro {
                toDetail.applyMacro_hold(macro: macro)
                print("macro dropped!")
                return true
            }
            
            return true
        }
        .onTapGesture(count: 2, perform: {
            print("double clicked")
            indicator_hold = true
            keyboardMonitor.startMonitoring_ToDetail($combo.toDetail, type: .hold, indicator: $indicator_hold)
        })
    }
    private var toggleTapHold_Keymap: some View {
        Toggle(isOn:
                Binding(
                    get: { toDetail.isTapHoldEnabled },
                    set: { newValue in
                        toDetail.isTapHoldEnabled = newValue
                    }
                )
        ) {
            Text("Tap Hold")
        }
        .toggleStyle(.switch)
    }
}
