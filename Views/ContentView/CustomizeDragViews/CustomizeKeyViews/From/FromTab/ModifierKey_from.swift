//
//  ModifierKeys 2.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/03/19.
//


//
//  LayerAndModifierKeys.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/03/19.
//


//
//  LayerAndModifierKeys.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct ModifierKeys_from: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }

    var body: some View {
        List {
            Section("Modifiers") {
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.modifier_keys(.left_shift))
                    CustomizeKeyView_from(.modifier_keys(.right_shift))
                    
                    CustomizeKeyView_from(.modifier_keys(.left_control))
                    CustomizeKeyView_from(.modifier_keys(.right_control))
                    
                    CustomizeKeyView_from(.modifier_keys(.left_command))
                    CustomizeKeyView_from(.modifier_keys(.right_command))
                    
                    CustomizeKeyView_from(.modifier_keys(.left_option))
                    CustomizeKeyView_from(.modifier_keys(.right_option))
                    
                    CustomizeKeyView_from(.modifier_keys(.keyboard_fn))
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
