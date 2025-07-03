//
//  SymbolKeys.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/03/19.
//


import SwiftUI

struct MouseKeys_from: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }

    var body: some View {
        List {
            Section("Mouse buttons") {
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.mouse_buttons(.button1))
                    CustomizeKeyView_from(.mouse_buttons(.button2))
                    CustomizeKeyView_from(.mouse_buttons(.button3))
                    CustomizeKeyView_from(.mouse_buttons(.button4))
                    CustomizeKeyView_from(.mouse_buttons(.button5))
                    CustomizeKeyView_from(.mouse_buttons(.button6))
                    CustomizeKeyView_from(.mouse_buttons(.button7))
                    CustomizeKeyView_from(.mouse_buttons(.button8))
                    CustomizeKeyView_from(.mouse_buttons(.button9))
                    CustomizeKeyView_from(.mouse_buttons(.button10))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.mouse_buttons(.button11))
                    CustomizeKeyView_from(.mouse_buttons(.button12))
                    CustomizeKeyView_from(.mouse_buttons(.button13))
                    CustomizeKeyView_from(.mouse_buttons(.button14))
                    CustomizeKeyView_from(.mouse_buttons(.button15))
                    CustomizeKeyView_from(.mouse_buttons(.button16))
                    CustomizeKeyView_from(.mouse_buttons(.button17))
                    CustomizeKeyView_from(.mouse_buttons(.button18))
                    CustomizeKeyView_from(.mouse_buttons(.button19))
                    CustomizeKeyView_from(.mouse_buttons(.button20))
                }
                HStack(spacing: 0) {
                    CustomizeKeyView_from(.mouse_buttons(.button21))
                    CustomizeKeyView_from(.mouse_buttons(.button22))
                    CustomizeKeyView_from(.mouse_buttons(.button23))
                    CustomizeKeyView_from(.mouse_buttons(.button24))
                    CustomizeKeyView_from(.mouse_buttons(.button25))
                    CustomizeKeyView_from(.mouse_buttons(.button26))
                    CustomizeKeyView_from(.mouse_buttons(.button27))
                    CustomizeKeyView_from(.mouse_buttons(.button28))
                    CustomizeKeyView_from(.mouse_buttons(.button29))
                    CustomizeKeyView_from(.mouse_buttons(.button30))
                    CustomizeKeyView_from(.mouse_buttons(.button31))
                    CustomizeKeyView_from(.mouse_buttons(.button32))
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
