//
//  DisplayTextFieldView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

/// キーのラベルを変えるためのテキストフィールドとSFSymbolのトグル
struct DisplayTextFieldView: View {
    @Binding var string: String
    @Binding var isSFSymbol: Bool
    
    var body: some View {
        HStack {
            Toggle("SF Symbol", isOn: $isSFSymbol)
                .toggleStyle(.checkbox)
                .labelsHidden()
                .help("Using SF Symbol")
            
            TextField(
                isSFSymbol ?
                "Symbol name" :
                    "Display string",
                text: $string
            )
        }
    }
}
