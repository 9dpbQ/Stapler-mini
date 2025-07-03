
//
//  ControlKeys.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/03/19.
//

import SwiftUI

struct SymbolKeys_from: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
    }

    var body: some View {
        List {
            Section("Symbols") {
                HStack(spacing: 0) { // symbols
                    CustomizeKeyView_from(.controls_and_symbols(.hyphen))
                    CustomizeKeyView_from(.controls_and_symbols(.equal_sign_or_caret))
                    CustomizeKeyView_from(.controls_and_symbols(.open_square_bracket))
                    CustomizeKeyView_from(.controls_and_symbols(.close_square_bracket))
                    CustomizeKeyView_from(.controls_and_symbols(.commercial_at_jis))
                    CustomizeKeyView_from(.controls_and_symbols(.backslash_or_yen))
                    CustomizeKeyView_from(.controls_and_symbols(.semicolon))
                    CustomizeKeyView_from(.controls_and_symbols(.single_quotation_or_colon))
                    CustomizeKeyView_from(.controls_and_symbols(.grave_accent))
                    CustomizeKeyView_from(.controls_and_symbols(.comma))
                    CustomizeKeyView_from(.controls_and_symbols(.period))
                    CustomizeKeyView_from(.controls_and_symbols(.slash))
                    CustomizeKeyView_from(.controls_and_symbols(.section))
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
