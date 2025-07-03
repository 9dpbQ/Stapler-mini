//
//  MacroKeyView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct MacroKeyView: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    let macro: Macro
    var keyMetrics: KeyMetrics
    let drag: DragClass
    @State private var isHovered = false
    
    init(_ macro_optional: Macro?, sizeX: CGFloat = 65) {
        if let macro = macro_optional {
            self.macro = macro
        } else {
            print("MacroKeyView Detect Optional Value")
            self.macro = .initialMacro
        }
        self.drag = DragClass(macro: macro)
        self.keyMetrics = KeyMetrics(unitSize: 1, baseSizeX: sizeX)
    }
    var body: some View {
        Button(action: {
            clicked()
        }) {
            RoundedRectangle(cornerRadius: keyMetrics.round_keytop)
                .fill(.gray)
                .overlay {
                    Text(macro.name)
                        .font(.system(size: keyMetrics.fontSize_tap))
                        .foregroundStyle(.white)
                }
                .modifier(OnLongPressModifier_MacroView(macro: macro))
                .draggable(drag)
        }
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        .scaleEffect(isHovered ? 1.1 : 1.0)

        .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
        .buttonStyle(.plain)
        .padding(keyMetrics.padding_keytop)
    }
    
    private func clicked() {
        withAnimation {
            switch viewModel.configuration.selections.tab {
            case .deviceEdit:
                print("Macro key clicked in deviceEdit tab")
            case .macro:
                print("Macro key clicked in macro tab")
            case .remap:
                print("Macro key clicked in Remap tab")
                viewModel.configuration.selections.keyboardKey.applyMacro_tap(
                    from: macro,
                    condition: viewModel.configuration.selections.condition,
                    layer: viewModel.configuration.selections.layer
                )
                if let nextKey: KeyboardKey = viewModel.configuration.keymap.getNextKeyboardKey(by: viewModel.configuration.selections.keyboardKey.id) {
                    withAnimation {
                        viewModel.configuration.selections.keyboardKey = nextKey
                    }
                }
            case .combo:
                if viewModel.configuration.isComboSelected {
                    print("Macro key clicked in Combo tab")
                    viewModel.configuration.selectedCombo.wrappedValue.applyMacro_tap(from: macro)
                    let currentComboArray = viewModel.configuration.comboCollection.getComboArray(
                        condition: viewModel.configuration.selections.condition,
                        layer: viewModel.configuration.selections.layer
                    ).array.sorted(
                        by: { $0.simultaneouses.count > $1.simultaneouses.count }
                    )
                    if let currentIndex = currentComboArray.firstIndex(where: { $0.id == viewModel.configuration.selections.combo.id }) {
                        if currentIndex + 1 >= currentComboArray.count {
                            // 配列の最後の場合、新しくコンボを追加して、それを選択状態にする
                            let newCombo = Combo()
                            viewModel.configuration.comboCollection.getComboArray(
                                condition: viewModel.configuration.selections.condition,
                                layer: viewModel.configuration.selections.layer
                            ).array.append(newCombo)
                            viewModel.configuration.selections.combo = newCombo
                        } else {
                            // 最後ではない場合、次のコンボを選択状態にする
                            viewModel.configuration.selections.combo = currentComboArray[currentIndex + 1]
                        }
                    }
                }
            }
        }
    }
    
}

struct OnLongPressModifier_MacroView: ViewModifier {
    @EnvironmentObject private var viewModel: ViewModel
    let macro: Macro
    
    func body(content: Content) -> some View {
        switch viewModel.configuration.selections.tab {
        case .remap:
            content
                .if(viewModel.configuration.isKeyboardKeySelected, transform: { view in
                    view.onLongPressGesture(perform: {
                        withAnimation {
                            print("long pressed")
                            viewModel.configuration.selections.keyboardKey.applyMacro_hold(
                                from: macro,
                                condition: viewModel.configuration.selections.condition,
                                layer: viewModel.configuration.selections.layer
                            )
                        }
                    })
                })
                
        case .combo:
            content
                .if(viewModel.configuration.isComboSelected, transform: { view in
                    view.onLongPressGesture(perform: {
                        withAnimation {
                            viewModel.configuration.selectedCombo.wrappedValue.applyMacro_hold(from: macro)
                        }
                    })
                })
        default :
            content
        }
    }
}
