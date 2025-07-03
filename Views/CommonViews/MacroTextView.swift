//
//  MacroTextView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

struct MacroTextView: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var macroCollection: MacroCollection {
        viewModel.configuration.macroCollection
    }
    private var keyMetrics: KeyMetrics { viewModel.keyMetrics }
    var layer: Layer
    let macro_id: String
    let fontSize: CGFloat?
    
    init(macro_id: String, layer: Layer = .layer0, fontSize: CGFloat? = nil) {
        self.macro_id = macro_id
        self.fontSize = fontSize
        self.layer = layer
    }
    var body: some View {
        Text(macroCollection.getMacro_includeStoredMacros(macro_id)?.name ?? "Missing Macro")
            .foregroundColor(macroCollection.getMacro_includeStoredMacros(macro_id) == nil ? .red : layer.accentColor)
            .font(.system(size: fontSize ?? keyMetrics.fontSize_tap))
    }
}
