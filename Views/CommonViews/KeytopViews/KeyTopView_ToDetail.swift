//
//  KeyTopView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

/// ToDetailを受けとり、その内容に応じたキートップを描画するビュー
/// ComboとkeyboardKeyのサイドバー、ポップオーバーに使えるはず
struct KeyTopView_ToDetail: View {
    @EnvironmentObject private var viewModel: ViewModel

    @Binding var toDetail: ToDetail
    let keyShape: KeyShape
    let keyMetrics: KeyMetrics
    let tapOrHold: TapOrHold
    
    @State var indicator: Bool = false
    
    private var withModifier: WithModifier {
        switch tapOrHold {
        case .tap:
            toDetail.withModifier_tap
        case .hold:
            toDetail.withModifier_hold
        }
    }
    private var isCustomized: Bool {
        switch tapOrHold {
        case .tap:
            toDetail.isCustomized_tap
        case .hold:
            toDetail.isCustomized_hold
        }
    }
    private var oad: OutputAndDisplay {
        switch tapOrHold {
        case .tap:
            toDetail.outputAndDisplay_tap
        case .hold:
            toDetail.outputAndDisplay_hold
        }
    }
    private var isMacro: Bool {
        switch tapOrHold {
        case .tap:
            toDetail.isMacro_tap
        case .hold:
            toDetail.isMacro_hold
        }
    }
    private var macro_id: String {
        switch tapOrHold {
        case .tap:
            toDetail.macro_id_tap
        case .hold:
            toDetail.macro_id_hold
        }
    }
    private var labelColor: Color {
        switch tapOrHold {
        case .tap:
            toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? viewModel.configuration.selections.layer.accentColor
        case .hold:
            toDetail.outputAndDisplay_hold.layerKey.layerKeyColor ?? viewModel.configuration.selections.layer.accentColor
        }
    }

    var body: some View {
        KeyTopView(
            isSelected: true,
            hilightColor: viewModel.configuration.selections.layer.accentColor,
            keyShape: keyShape,
            unitSize: keyMetrics.unitSize
        )
            .overlay {
                if isCustomized {
                    HStack {
                        if isMacro {
                            MacroTextView(macro_id: macro_id)
                        } else {
                            if oad.layerKey == .layer0 {
                                ModifierContentView(
                                    withModifier: withModifier,
                                    keyMetrics: keyMetrics,
                                    color: labelColor
                                )
                            }
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
                RecordingIndicatorView(indicator: indicator, keyMetrics: keyMetrics, keyShape: keyShape)
                CautionView(
                    caution: toDetail.isTapHoldEnabled && toDetail.isCustomized_tap != toDetail.isCustomized_hold,
                    keyMetrics: keyMetrics,
                    keyShape: keyShape,
                    color: .yellow,
                    helpText: "Tap-Hold is enabled, but only one side is customized. When exporting to JSON, the customized settings will be applied to both sides."
                )
            }
            .dropDestination(for: DragClass.self) { items, location in
                withAnimation {
                    guard let item = items.first else { return false }
                    if let custom = item.customizeKey {
                        switch tapOrHold {
                        case .tap:
                            toDetail.applyCustom_tap(custom: custom)
                            print("customizeKey dropped!")
                            return true
                        case .hold:
                            toDetail.applyCustom_hold(custom: custom)
                            print("customizeKey dropped!")
                            return true
                        }
                        
                    } else if let macro = item.macro {
                        switch tapOrHold {
                        case .tap:
                            toDetail.applyMacro_tap(macro: macro)
                            print("macro dropped!")
                            return true
                        case .hold:
                            toDetail.applyMacro_hold(macro: macro)
                            print("macro dropped!")
                            return true
                        }
                    }
                    return true
                }
            }
            .onTapGesture(
                count: 2,
                perform: {
                    print("double clicked")
                    indicator = true
                    viewModel.keyboardMonitor.startMonitoring_ToDetail(
                        $toDetail, type: tapOrHold,
                        indicator: $indicator)
                }
            )
            .contextMenu {
                Button("Reset Custom") {
                    withAnimation {
                        toDetail.resetCustom(tapOrHold)
                    }
                }
            }
            .frame(width: keyShape.frameSize(keyMetrics).width, height: keyShape.frameSize(keyMetrics).height)
    }
}
