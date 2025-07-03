//
//  CustomizeKey_to_Qwerty.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/01/17.
//

import SwiftUI

//引数にはFromKeycodeを入れるだけで良いカスキービュー
struct CustomizeKeyView_from: View {
    @EnvironmentObject private var viewModel: ViewModel

    let customizeKey_from: CustomizeKey_from
    let displayKeySize: CGFloat
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: customizeKey_from.unitSize, baseSizeX: displayKeySize)
    }
    let dragClass: DragClass
    
    @State private var isHovered = false
    
    init(
        _ fromKeycode: FromKeycode,
        customString: String? = nil,
        isSFSymbol: Bool? = nil,
        unitSize: CGFloat = 1.0,
        keyShape: KeyShape = .square,
        region: KeycodeRegion? = nil,
        displayKeySize: CGFloat = 65
    ) {
        self.customizeKey_from = CustomizeKey_from(output: fromKeycode, display: customString, isUsingSFSymbol: isSFSymbol, unitSize: unitSize, keyShape: keyShape, region: region)
        self.dragClass = DragClass(customizeKey_from: CustomizeKey_from(output: fromKeycode, display: customString, isUsingSFSymbol: isSFSymbol, unitSize: unitSize, keyShape: keyShape, region: region))
        self.displayKeySize = displayKeySize
    }
    var body: some View {
        Button(action: {
            withAnimation {
                if viewModel.configuration.selections.keyboardKey != .initialKey {
                    print("ontapped")
                    viewModel.configuration.selections.keyboardKey.applyCustom_from(from: customizeKey_from)
                    if let nextKey: KeyboardKey = viewModel.configuration.keymap.getNextKeyboardKey(by: viewModel.configuration.selections.keyboardKey.id) {
                        withAnimation {
                            viewModel.configuration.selections.keyboardKey = nextKey
                        }
                    }
                }
            }
        }) {
            customizeKey_from.keyShape.keytopShape(keyMetrics)
                .fill(Color.gray.opacity(0.5))
                .frame(
                    width: customizeKey_from.keyShape.keytopSize(keyMetrics).width,
                    height: customizeKey_from.keyShape.keytopSize(keyMetrics).height
                )
                .overlay {
                    textOrSymbol(keyMetrics.fontSize_tap)
                }
                .frame( // Hilightフレームに対して中央に
                    width: customizeKey_from.keyShape.hilightFrameSize(keyMetrics).width,
                    height: customizeKey_from.keyShape.hilightFrameSize(keyMetrics).height,
                    alignment: .center
                )
                .help(customizeKey_from.helpText ?? "keycode: \(customizeKey_from.output.keycodeInfo(viewModel.configuration.keymap.keycodeRegion).keyCodeString)")
            
                .draggable(dragClass) { draggingView }
        }
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        .scaleEffect(isHovered ? 1.1 : 1.0)
        .buttonStyle(.plain)
        .frame(
            width: customizeKey_from.keyShape.frameSize(keyMetrics).width,
            height: customizeKey_from.keyShape.frameSize(keyMetrics).height,
            alignment: customizeKey_from.keyShape.alignment()
        )
    }
    private func textOrSymbol(_ fontSize: CGFloat) -> some View {
        Group {
            SFSymbolOrTextView(
                symbolName: customizeKey_from.display,
                isSFSymbol: customizeKey_from.isUsingSFSymbol,
                size: fontSize,
                color: .white
            )
        }
    }
    private var draggingView: some View {
        Group {
            let keyboardKeyMetrics = KeyMetrics(unitSize: customizeKey_from.unitSize, baseSizeX: viewModel.configuration.displayKeySize)
            customizeKey_from.keyShape.keytopShape(keyboardKeyMetrics)
                .fill(Color.gray.opacity(0.5))
                .frame(
                    width: customizeKey_from.keyShape.keytopSize(keyboardKeyMetrics).width,
                    height: customizeKey_from.keyShape.keytopSize(keyboardKeyMetrics).height
                )
                .overlay {
                    textOrSymbol(keyboardKeyMetrics.fontSize_tap)
                }
        }
    }
}


