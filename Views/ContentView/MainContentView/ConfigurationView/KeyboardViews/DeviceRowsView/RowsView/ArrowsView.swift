//
//  ArrowsView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/10.
//
import SwiftUI

struct ArrowsView: View {
    @Binding var left: KeyboardKey
    @Binding var right: KeyboardKey
    @Binding var up: KeyboardKey
    @Binding var down: KeyboardKey
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            KeyboardKeyView(keyboardKey: $left)
            VStack(alignment: .center, spacing: 0) {
                KeyboardKeyView(keyboardKey: $up)
                KeyboardKeyView(keyboardKey: $down)
            }
            KeyboardKeyView(keyboardKey: $right)
        }
        
    }
}
