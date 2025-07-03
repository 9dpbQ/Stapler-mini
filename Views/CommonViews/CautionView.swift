//
//  CautionView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct CautionView: View {
    let caution: Bool
    let keyMetrics: KeyMetrics
    let keyShape: KeyShape
    let color: Color
    let helpText: String
    init(caution: Bool, keyMetrics: KeyMetrics, keyShape: KeyShape, color: Color = .red, helpText: String) {
        self.caution = caution
        self.keyMetrics = keyMetrics
        self.keyShape = keyShape
        self.color = color
        self.helpText = helpText
    }

    var body: some View {
        if caution {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: keyMetrics.padding_keytop * 3))
                .foregroundStyle(color)
                .padding(keyMetrics.padding_keytop * 2)
                .frame(
                    width: keyShape.keytopSize(keyMetrics).width,
                    height: keyShape.keytopSize(keyMetrics).height,
                    alignment: .topTrailing
                )
                .help(helpText)
        } else {
            EmptyView()
        }
    }
}
