//
//  ModifierToggleView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

/// WithModifierをバインディングで受け取り、そのトグルをするビュー
struct ModifierToggleView: View {
    @Binding var withModifier: WithModifier
    var body: some View {
        VStack {
            Toggle(isOn: $withModifier.isWithModifier) {
                Text("Modifier")
            }
            .toggleStyle(.button)
            HStack {
                Toggle(isOn: $withModifier.isWithShift) {
                    Image(systemName: "shift")
                }
                .toggleStyle(.button)
                .disabled(!withModifier.isWithModifier)
                Toggle(isOn:$withModifier.isWithControl) {
                    Image(systemName: "control")
                }
                .toggleStyle(.button)
                .disabled(!withModifier.isWithModifier)
            }
            HStack {
                Toggle(isOn: $withModifier.isWithCommand) {
                    Image(systemName: "command")
                }
                .toggleStyle(.button)
                .disabled(!withModifier.isWithModifier)
                Toggle(isOn: $withModifier.isWithOption) {
                    Image(systemName: "option")
                }
                .toggleStyle(.button)
                .disabled(!withModifier.isWithModifier)
            }
            Toggle(isOn: $withModifier.isWithFunction) {
                Image(systemName: "globe")
            }
            .toggleStyle(.button)
            .disabled(!withModifier.isWithModifier)
        }
    }
}
