//
//  SFSymbolOrTextView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

/// TextかImageを返すビュー
struct SFSymbolOrTextView: View {
    let symbolName: String
    let isSFSymbol: Bool
    let size: CGFloat
    let color : Color?

    init(symbolName: String, isSFSymbol: Bool, size: CGFloat, color: Color? = nil) {
        self.symbolName = symbolName
        self.isSFSymbol = isSFSymbol
        self.size = size
        self.color = color
    }
    var body: some View {
        Group {
            if isSFSymbol {
                Image(systemName: symbolName)
            } else {
                Text(symbolName)
            }
        }
        .font(.system(size: size))
        .foregroundColor(color)
    }
}
