//
//  ModifierContentView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI


// WithModifierを受け取り、トグルされている修飾キーのアイコンを返すビュー
struct ModifierContentView: View {
    let withModifier: WithModifier
    let keyMetrics: KeyMetrics
    let color: Color?
    
    init(withModifier: WithModifier, keyMetrics: KeyMetrics, color: Color? = nil) {
        self.withModifier = withModifier
        self.keyMetrics = keyMetrics
        self.color = color
    }

    var body: some View {
        VStack(spacing: 0) {
            if withModifier.isWithModifier {
                Spacer()
                HStack(spacing: 0) {
                    if withModifier.isWithShift {
                        Image(systemName: "shift")
                    }
                    if withModifier.isWithControl {
                        Image(systemName: "control")
                    }
                }
                HStack(spacing: 0) {
                    if withModifier.isWithCommand {
                        Image(systemName: "command")
                    }
                    if withModifier.isWithOption {
                        Image(systemName: "option")
                    }
                }
                if withModifier.isWithFunction {
                    Image(systemName: "globe")
                }
                Spacer()
            } else {
                EmptyView()
            }
        }
        .foregroundColor(color)
        .font(.system(size: modifierFontSize()))
    }

    private func modifierFontSize() -> CGFloat {
        let activeModifierCount = [
            withModifier.isWithShift,
            withModifier.isWithControl,
            withModifier.isWithCommand,
            withModifier.isWithOption,
            withModifier.isWithFunction
        ].filter { $0 }.count
        
        switch activeModifierCount {
        case 0, 1:
            return keyMetrics.fontSize_tap
        case 2:
            return keyMetrics.fontSize_tap / 2
        default:
            return keyMetrics.fontSize_tap / 3
        }
    }
}

/// モディファイアを横並びに表示するビュー
/// レイヤーのカスタムとマクロのサイドバー表示に使う
struct ModifierContentView_HStacked: View {
    let withModifier: WithModifier
    let fontSize: CGFloat?
    let color: Color?
    
    init(withModifier: WithModifier, fontSize: CGFloat? = nil, color: Color? = nil) {
        self.withModifier = withModifier
        self.fontSize = fontSize
        self.color = color
    }

    var body: some View {
        Group {
            if withModifier.isWithModifier {
                HStack(spacing: 0) {
                    if withModifier.isWithControl { Image(systemName: "control") }
                    if withModifier.isWithShift { Image(systemName: "shift") }
                    if withModifier.isWithOption { Image(systemName: "option") }
                    if withModifier.isWithCommand { Image(systemName: "command") }
                    if withModifier.isWithFunction { Image(systemName: "globe") }
                }
                .applyFontSize(fontSize)
                .foregroundColor(color)
            } else {
                EmptyView()
            }
        }
    }
}

private extension View {
    @ViewBuilder
    func applyFontSize(_ size: CGFloat?) -> some View {
        if let size {
            self.font(.system(size: size))
        } else {
            self // フォント設定なし
        }
    }
}
