//
//  RecordingIndicatorView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

/// キーボードの入力監視中を知らせるインジケータービュー
struct RecordingIndicatorView: View {
    let indicator: Bool
    let keyMetrics: KeyMetrics
    let keyShape: KeyShape
    
    var body: some View {
        
        Circle()
            .frame(width: keyMetrics.padding_keytop * 2)
            .foregroundColor(.red)
            .opacity(indicator ? 1 : 0)
            .padding(keyMetrics.padding_keytop)
            .animation(
                indicator
                ? Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)
                : .default,
                value: indicator
            )
            .frame(
                width: keyShape.keytopSize(keyMetrics).width,
                height: keyShape.keytopSize(keyMetrics).height,
                alignment: .topLeading
            )
    }
}
