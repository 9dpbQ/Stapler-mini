//
//  LayerAndModifierKeys.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct LayerAndModifierKeys_to: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }

    var body: some View {
        List {
            
            Section("Momentary Layer") {
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.layer_keys(.layer1), layerKey: .layer1)
                    CustomizeKeyView_to(.layer_keys(.layer2), layerKey: .layer2)
                    CustomizeKeyView_to(.layer_keys(.layer3), layerKey: .layer3)
                    CustomizeKeyView_to(.layer_keys(.layer4), layerKey: .layer4)
                    CustomizeKeyView_to(.layer_keys(.layer5), layerKey: .layer5)
                    CustomizeKeyView_to(.layer_keys(.layer6), layerKey: .layer6)
                    CustomizeKeyView_to(.layer_keys(.layer7), layerKey: .layer7)
                    CustomizeKeyView_to(.layer_keys(.layer8), layerKey: .layer8)
                }
            }
            Section("Toggle Layer ON") {
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.layer_keys(.layer1_on), layerKey: .layer1)
                    CustomizeKeyView_to(.layer_keys(.layer2_on), layerKey: .layer2)
                    CustomizeKeyView_to(.layer_keys(.layer3_on), layerKey: .layer3)
                    CustomizeKeyView_to(.layer_keys(.layer4_on), layerKey: .layer4)
                    CustomizeKeyView_to(.layer_keys(.layer5_on), layerKey: .layer5)
                    CustomizeKeyView_to(.layer_keys(.layer6_on), layerKey: .layer6)
                    CustomizeKeyView_to(.layer_keys(.layer7_on), layerKey: .layer7)
                    CustomizeKeyView_to(.layer_keys(.layer8_on), layerKey: .layer8)
                }
            }
            Section("Toggle Layer OFF") {
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.layer_keys(.layer1_off), layerKey: .layer1)
                    CustomizeKeyView_to(.layer_keys(.layer2_off), layerKey: .layer2)
                    CustomizeKeyView_to(.layer_keys(.layer3_off), layerKey: .layer3)
                    CustomizeKeyView_to(.layer_keys(.layer4_off), layerKey: .layer4)
                    CustomizeKeyView_to(.layer_keys(.layer5_off), layerKey: .layer5)
                    CustomizeKeyView_to(.layer_keys(.layer6_off), layerKey: .layer6)
                    CustomizeKeyView_to(.layer_keys(.layer7_off), layerKey: .layer7)
                    CustomizeKeyView_to(.layer_keys(.layer8_off), layerKey: .layer8)
                }
            }
            
            Section("Modifiers") {
                HStack(spacing: 0) {
                    CustomizeKeyView_to(.modifier_keys(.left_shift))
                    CustomizeKeyView_to(.modifier_keys(.right_shift))
                    CustomizeKeyView_to(.modifier_keys(.left_control))
                    CustomizeKeyView_to(.modifier_keys(.right_control))
                    CustomizeKeyView_to(.modifier_keys(.left_command))
                    CustomizeKeyView_to(.modifier_keys(.right_command))
                    CustomizeKeyView_to(.modifier_keys(.left_option))
                    CustomizeKeyView_to(.modifier_keys(.right_option))
                    CustomizeKeyView_to(.modifier_keys(.keyboard_fn))
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
