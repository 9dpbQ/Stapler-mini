//
//  CustomizeKeyView_To.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/01/19.
//

import SwiftUI



///引数にはToKeycode,キーのサイズ
///を入れるだけで良いカスキービュー
struct CustomizeKeyView_to: View {
    @EnvironmentObject private var viewModel: ViewModel

    let customizeKey_to: CustomizeKey_to
    
    private var backgroundColor: Color {
        customizeKey_to.layerKeyNumber?.accentColor ?? .black
    }
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: customizeKey_to.unitSize, baseSizeX: displayKeySize)
    }
    let drag: DragClass
    let displayKeySize: CGFloat
    
    @State private var isHovered = false
    
    init(
        _ toKeycode: ToKeycode,
        customString: String? = nil,
        isSFSymbol: Bool? = nil,
        unitSize: CGFloat = 1.0,
        keyShape: KeyShape = .square,
        layerKey: Layer? = nil,
        displayKeySize: CGFloat = 65
    ) {
        self.customizeKey_to = CustomizeKey_to(output: toKeycode, display: customString, isUsingSFSymbol: isSFSymbol, unitSize: unitSize, keyShape: keyShape, layerKeyNumber: layerKey)
        self.drag = DragClass(customizeKey: customizeKey_to)
        self.displayKeySize = displayKeySize
    }
    var body: some View {
        Button(action: {
            clicked()
        }) {
            customizeKey_to.keyShape.keytopShape(keyMetrics)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 150/255, green: 150/255, blue: 150/255).opacity(0.5),
                            Color(red: 80/255, green: 80/255, blue: 80/255).opacity(0.5)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(
                    width: customizeKey_to.keyShape.keytopSize(keyMetrics).width,
                    height: customizeKey_to.keyShape.keytopSize(keyMetrics).height
                )            // Display (アイコンまたはテキスト)
                .overlay {
                    textOrSymbol(keyMetrics.fontSize_tap)
                }
                .modifier(KeyTopShapeFrame(customizeKey_to.keyShape, keyMetrics: keyMetrics))//当たり判定
                .frame(
                    width: customizeKey_to.keyShape.hilightFrameSize(keyMetrics).width,
                    height: customizeKey_to.keyShape.hilightFrameSize(keyMetrics).height,
                    alignment: .center
                )
                .modifier(OnLongPressModifier_CustomizeKey_To(customizeKey: customizeKey_to))
                .draggable(drag) { draggingView }
                .help(customizeKey_to.helpText ?? "keycode: \(customizeKey_to.output.keycodeInfo(viewModel.configuration.keymap.keycodeRegion)?.keyCodeString ?? "error")")// kokonaosu!
            
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        .scaleEffect(isHovered ? 1.1 : 1.0)
        .frame(
            width: customizeKey_to.keyShape.frameSize(keyMetrics).width,
            height: customizeKey_to.keyShape.frameSize(keyMetrics).height,
            alignment: customizeKey_to.keyShape.alignment()
        )
    }
    private func clicked() {
        withAnimation {
            switch viewModel.configuration.selections.tab {
            case .deviceEdit:
                print("wtf")
            case .macro:
                if viewModel.configuration.isMacroSelected && viewModel.configuration.isToDetail_macroSelected {
                    let macro = viewModel.configuration.selectedMacro
                    let toDetail_macro = viewModel.configuration.selectedToDetail_macro
                    print("clicked in macro tab")
                    toDetail_macro.wrappedValue.applyCustom(from: customizeKey_to)
                    if let currentIndex = macro.wrappedValue.toDetailCollection.collection.firstIndex(where: { $0.id == toDetail_macro.id }) {
                        if macro.wrappedValue.toDetailCollection.collection[currentIndex] === macro.wrappedValue.toDetailCollection.collection.last {
                            //最後のToDetail_Macroの場合、新しくToDetail_macroを追加、選択も移行
                            let newToDetail = ToDetail_macro(output: .shift_symbols(.question))
                            macro.wrappedValue.toDetailCollection.collection.append(newToDetail)
                            viewModel.configuration.selections.toDetail_macro = newToDetail
                        } else {
                            //次のToDetailがある場合, 次を選択状態にする
                            viewModel.configuration.selections.toDetail_macro = macro.toDetailCollection.collection[currentIndex + 1].wrappedValue
                        }
                    }
                }
            case .remap:
                if viewModel.configuration.selections.keyboardKey != .initialKey {
                    viewModel.configuration.selections.keyboardKey.applyCustom_tap(
                        from: customizeKey_to,
                        condition: viewModel.configuration.selections.condition,
                        layer: viewModel.configuration.selections.layer
                    )
                    if let nextKey: KeyboardKey = viewModel.configuration.keymap.getNextKeyboardKey(by: viewModel.configuration.selections.keyboardKey.id) {
                        viewModel.configuration.selections.keyboardKey = nextKey
                    }
                }
            case .combo:
                if viewModel.configuration.isComboSelected {
                    let combo = viewModel.configuration.selectedCombo.wrappedValue
                    print("ontapped")
                    combo.applyCustom_tap(from: customizeKey_to)
                    let currentComboArray = viewModel.configuration.comboCollection.getComboArray(
                        condition: viewModel.configuration.selections.condition,
                        layer: viewModel.configuration.selections.layer
                    ).array.sorted(
                        by: { $0.simultaneouses.count > $1.simultaneouses.count }
                    )
                    if let currentIndex = currentComboArray.firstIndex(of: combo) {
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
    private func textOrSymbol(_ fontSize: CGFloat) -> some View {
        Group {
            if customizeKey_to.isUsingSFSymbol {
                Image(systemName: customizeKey_to.display)
            } else {
                Text(customizeKey_to.display)
            }
        }
        .foregroundStyle(customizeKey_to.layerKeyNumber?.accentColor ?? .white)
        .font(.system(size: fontSize))
    }
    private var draggingView: some View {
        ZStack {
            let keyboardKeyMetrics = KeyMetrics(unitSize: 1.0, baseSizeX: viewModel.configuration.displayKeySize)
            //キートップ
            customizeKey_to.keyShape.keytopShape(keyboardKeyMetrics)
                .fill(Color.gray.opacity(0.5))
                .frame(
                    width: customizeKey_to.keyShape.keytopSize(keyboardKeyMetrics).width,
                    height: customizeKey_to.keyShape.keytopSize(keyboardKeyMetrics).height
                )
            textOrSymbol(keyboardKeyMetrics.fontSize_tap)
        }
    }
}

struct OnLongPressModifier_CustomizeKey_To: ViewModifier {
    @EnvironmentObject private var viewModel: ViewModel
    let customizeKey: CustomizeKey_to
    
    func body(content: Content) -> some View {
        switch viewModel.configuration.selections.tab {
        case .remap:
            content
                .onLongPressGesture(perform: {
                    if viewModel.configuration.selections.keyboardKey != .initialKey {
                        print("long pressed")
                        viewModel.configuration.selections.keyboardKey.applyCustom_hold(
                            from: customizeKey,
                            condition: viewModel.configuration.selections.condition,
                            layer: viewModel.configuration.selections.layer
                        )
                    }
                    
                })
        case .macro:
            content
        case .combo:
            content
                .onLongPressGesture(perform: {
                    if viewModel.configuration.isComboSelected {
                        let combo = viewModel.configuration.selectedCombo.wrappedValue
                        print("long pressed")
                        combo.applyCustom_hold(from: customizeKey)
                    }
                })
        case .deviceEdit:
            content
        }
    }
}

// MARK: - QWERTY tab 良く使うようなキーを集約



// MARK: - Layer and Modifiers
/// レイヤーと修飾キーをここに集約
///



// MARK: - Controls
/// ここにはReturnからArrows,Application Launchまでコントロール系のキーを集約
///




// MARK: - Mouse
/// ここにはReturnからArrows,Application Launchまでコントロール系のキーを集約
///





// MARK: - Symbols
/// 記号をそのカテゴリ分けをしつつ集約
///


