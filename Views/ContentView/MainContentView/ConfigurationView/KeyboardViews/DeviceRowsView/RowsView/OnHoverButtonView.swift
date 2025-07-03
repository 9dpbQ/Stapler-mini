//
//  OnHoverButtonView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/10.
//
import SwiftUI

struct OnHoverButtonView_appear: View {
    let symbolName: String
    let hoverColor: Color
    let size: CGSize
    @State private var onHover: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: symbolName)
                .resizable() // サイズ変更可能に
                .scaledToFit() // 縦横比を維持
                .frame(width: size.width * 0.7, height: size.height * 0.7) // アイコンの適切なサイズ
                .foregroundColor(.white) // アイコンの色を白に
                .opacity(onHover ? 1.0 : 0)
                .padding(size.width * 0.2) // 内側の余白
                .background(Circle().fill(onHover ? hoverColor.opacity(1.0) : Color.clear)) // 背景を丸く
//                .symbolEffect(.appear, isActive: onHover)
                .transition(.symbolEffect(.appear))

        }
        .buttonStyle(.plain)
        .onHover { hovering in
            if hovering {
                withAnimation {
                    onHover = true
                }
            } else {
                withAnimation {
                    onHover = false
                }
            }
        }
        .frame(width: size.width, height: size.height)
        .scaleEffect(onHover ? 3 : 1) // ホバー時に拡大

    }
}
