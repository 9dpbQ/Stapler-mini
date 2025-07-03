//
//  CustomizeKeyView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/11.
//


import SwiftUI



enum CustomOrMacroTab: CaseIterable, Codable{
    case macro
    case customizeKey
    func displayString() -> String {
        switch self {
        case .macro:
            "Macro"
        case .customizeKey:
            "Single Keycode"
        }
    }
}
enum FromTab: CaseIterable, Codable {
    case qwertyKeyboard
    case modifiers
    case controls
    case symbols
    case mouse
    case all
    
    func displayString() -> String {
        switch self {
        case .qwertyKeyboard:
            "QWERTY"
        case .modifiers:
            "Modifiers"
        case .controls:
            "Controls"
        case .symbols:
            "Symbols"
        case .mouse:
            "Mouse"
        case .all:
            "All"
        }
    }
}

enum ToTab: String, CaseIterable, Codable {
    case qwertyKeyboard
    case layerAndModifierKeys
    case controls// Mediaなども？
    case symbols // ありとあらゆるシンボルをここに
    case mouse // MouseButtons, MouseKeys
    case all
    
    func displayString() -> String {
        switch self {
        case .qwertyKeyboard:
            "QWERTY"
        case .layerAndModifierKeys:
            "Layer and Modifiers"
        case .controls:
            "Controls"
        case .symbols:
            "Symbols"
        case .mouse:
            "Mouse"
        case .all:
            "All"
        }
    }
}
enum MacroTab: CaseIterable, Codable {
    case userMacro
    case storedMacro
    func displayString() -> String {
        switch self {
        case .userMacro:
            "User Macro"
        case .storedMacro:
            "Stored Macro"
        }
    }
}

struct CustomizeKeyAndMacroKeyView: View {
    @EnvironmentObject private var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                switch viewModel.configuration.selections.tab {
                case .deviceEdit:
                    // fromカスキーのみの表示
                    Picker("From Customize Key", selection: $viewModel.configuration.selections.fromTab) {
                        ForEach(FromTab.allCases, id: \.self) { type in
                            Text(type.displayString()).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.horizontal, 50)
                    
                case .macro:
                    // Toカスきーのみの表示
                    Picker("To Customize tab", selection: $viewModel.configuration.selections.toTab) {
                        ForEach(ToTab.allCases, id: \.self) { type in
                            Text(type.displayString()).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.horizontal, 50)
                    
                default:
                    // マクロとToカスキーの表示
                    Picker("display custom type", selection: $viewModel.configuration.selections.customOrMacroTab) {
                        ForEach(CustomOrMacroTab.allCases, id: \.self) { type in
                            Text(type.displayString()).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .padding(.leading, 50)
                    switch viewModel.configuration.selections.customOrMacroTab {
                    case .macro:
                        Picker("Macro Tab", selection: $viewModel.configuration.selections.macroTab) {
                            ForEach(MacroTab.allCases, id: \.self) { type in
                                Text(type.displayString()).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                        .padding(.trailing, 50)
                    case .customizeKey:
                        Picker("To Customize tab", selection: $viewModel.configuration.selections.toTab) {
                            ForEach(ToTab.allCases, id: \.self) { type in
                                Text(type.displayString()).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                        .padding(.trailing, 50)
                    }
                }
            }
            
            Group {
                switch viewModel.configuration.selections.tab {
                    
                case .deviceEdit: // FromKeycode
                    switch viewModel.configuration.selections.fromTab {
                    case .qwertyKeyboard:
                        Qwerty_CustomizeKey_From()
                    case .modifiers:
                        ModifierKeys_from()
                    case .controls:
                        ControlKeys_from()
                    case .symbols:
                        SymbolKeys_from()
                    case .mouse:
                        MouseKeys_from()
                    case .all:
                        AllKeysView_From()
                    }
                case .macro:
                    switch viewModel.configuration.selections.toTab {
                    case .qwertyKeyboard:
                        Qwerty_CustomizeKey_to()
                    case .layerAndModifierKeys:
                        LayerAndModifierKeys_to()
                    case .controls:
                        ControlKeysTab_to()
                    case .symbols:
                        SymbolsTab_to()
                    case .mouse:
                        MouseKeysTab_to()
                    case .all:
                        AllKeysView_To()
                    }
                default:
                    switch viewModel.configuration.selections.customOrMacroTab {
                    case .macro:
                        switch viewModel.configuration.selections.macroTab {
                        case .userMacro:
                            UserMacroScrollView()
                        case .storedMacro:
                            StoredMacroView_JP_hiragana()
                        }
                    case .customizeKey:
                        switch viewModel.configuration.selections.toTab {
                        case .qwertyKeyboard:
                            Qwerty_CustomizeKey_to()
                        case .layerAndModifierKeys:
                            LayerAndModifierKeys_to()
                        case .controls:
                            ControlKeysTab_to()
                        case .symbols:
                            SymbolsTab_to()
                        case .mouse:
                            MouseKeysTab_to()
                        case .all:
                            AllKeysView_To()
                        }
                    }
                }
            }
            .frame(maxHeight: 300)
        }
    }
}



//struct CustomizeKeyView_to: View {
//    @EnvironmentObject private var viewModel: ViewModel
//
//    let customizeKey: CustomizeKey_to
//    
//    private var backgroundColor: Color {
//        customizeKey.layerKeyNumber?.accentColor ?? .black
//    }
//    private var keyMetrics: KeyMetrics {
//        KeyMetrics(unitSize: 1, baseSizeX: viewModel.configuration.displayKeySize)
//    }
//    let drag: DragClass
//    
//    init(
//        customizeKey: CustomizeKey_to
//    ) {
//        self.customizeKey = customizeKey
//        self.drag = DragClass(customizeKey: customizeKey)
//    }
//    var body: some View {
//        
//        ZStack {
//            //キートップ
//            RoundedRectangle(cornerRadius: keyMetrics.round_keytop)
//                .fill(
//                    RadialGradient(
//                        gradient: Gradient(colors: [
//                            backgroundColor.opacity(0.1),
//                            backgroundColor.opacity(0.8)
//                        ]),
//                        center: .center,
//                        startRadius: 0,
//                        endRadius: max(keyMetrics.frame_keytop.width, keyMetrics.frame_keytop.height) / 2
//                    )
//                )
//                .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
//            // Display (アイコンまたはテキスト)
//            Group {
//                if customizeKey.isUsingSFSymbol {
//                    Image(systemName: customizeKey.display)
//                } else {
//                    Text(customizeKey.display)
//                }
//            }
//            .foregroundStyle(.white)
//            .font(.system(size: keyMetrics.fontSize_tap))
//        }
//        .onLongPressGesture(perform: {
//            print("long pressed")
//            viewModel.configuration.selections.keyboardKey.applyCustom_hold(
//                from: customizeKey,
//                condition: viewModel.configuration.selections.condition,
//                layer: viewModel.configuration.selections.layer
//            )
//        })
//        .onTapGesture {
//            print("ontapped")
//            viewModel.configuration.selections.keyboardKey.applyCustom_tap(
//                from: customizeKey,
//                condition: viewModel.configuration.selections.condition,
//                layer: viewModel.configuration.selections.layer
//            )
//            if let nextKey: KeyboardKey = viewModel.configuration.keymap.getNextKeyboardKey(by: viewModel.configuration.selections.keyboardKey.id, layout: viewModel.configuration.keyboardLayout) {
//                withAnimation {
//                    viewModel.configuration.selections.keyboardKey = nextKey
//                }
//            }
//        }
//        
//        .draggable(drag)
//        .help(customizeKey.helpText ?? "keycode: \(customizeKey.output)")
//        .padding(keyMetrics.padding_keytop)
//    }
//}



//struct CustomizeKeyAndMacroKey_TabView: View {
//    @Binding var preset: Preset
//    @State private var searchText: String = ""
//    @State private var selectedTab: CustomizationTab = .keyboard
//    @FocusState private var internalSearchFieldFocus: Bool
//
////    // 全カテゴリーのキーをフィルタリング
////    var filteredAllKeys: [CustomizeKey_to] {
////
////        let allKeys = CustomizeKeyCategories.allCategories.flatMap { $0.keys }
////        if searchText.isEmpty {
////            return allKeys
////        } else {
////            return allKeys.filter { key in
////                key.display.localizedCaseInsensitiveContains(searchText)
////            }
////        }
////    }
//
//    let columns = [
//        GridItem(.adaptive(minimum: 65 - 65 * 0.07 + 2.5, maximum: 100))
//    ]
//
//    private var keySize: CGFloat {
//        preset.displayKeySize
//    }
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            // Macroタブ
//            UserMacroScrollView(macroCollection: preset.macroCollection, displayKeySize: keySize)
//                .tabItem {
//                    Text(CustomizationTab.macro.label)
//                }
//                .tag(CustomizationTab.macro)
//
////            // キーボードカテゴリータブ
////            TabView {
////                ForEach(CustomizeKeyCategories.allCategories, id: \.id) { category in
////                    ScrollView(.vertical) {
////                        LazyVGrid(columns: columns, spacing: 5) {
////                            ForEach(category.keys, id: \.id) { key in
////                                CustomizeKeyView(
////                                    customizeKey: key,
////                                    preset: $preset
////                                )
////                            }
////                        }
////                        .padding()
////                    }
////                    .tabItem {
////                        Text(category.name)
////                    }
////                }
////            }
////            .tabItem {
////                Text(CustomizationTab.keyboard.label)
////            }
////            .tag(CustomizationTab.keyboard)
//            // キーボードカテゴリータブ
//            TabView {
////                ForEach(ToKeycode.allCategoies, id: \.id) { category in
////                    ScrollView(.vertical) {
////                        LazyVGrid(columns: columns, spacing: 5) {
////                            ForEach(category.enumType.allCases, id: \.id) { keycode in
////                                CustomizeKeyView(
////                                    customizeKey: keycode,
////                                    preset: $preset
////                                )
////                            }
////                        }
////                        .padding()
////                    }
////                    .tabItem {
////                        Text(category.name)
////                    }
////                }
////                ForEach(LetterKeys.allCases, id: \.id) { output in
////
////                }
//            }
//            .tabItem {
//                Text(CustomizationTab.keyboard.label)
//            }
//            .tag(CustomizationTab.keyboard)
//
////            // 全キータブ
////            VStack {
////                if selectedTab == .all {
////                    HStack {
////                        Spacer()
////                        TextField("Search in All Keys", text: $searchText)
////                            .background().cornerRadius(6)
////                            .frame(width: 150)
////                            .textFieldStyle(RoundedBorderTextFieldStyle())
////                            .padding(.trailing, 10)
////                            .focused($internalSearchFieldFocus)
////                            .onSubmit { internalSearchFieldFocus = false }
////                    }
////                }
////
////                ScrollView(.vertical) {
////                    LazyVGrid(columns: columns, spacing: 5) {
////                        ForEach(filteredAllKeys, id: \.id) { key in
////                            CustomizeKeyView(
////                                customizeKey: key,
////                                preset: $preset
////                            )
////                        }
////                    }
////                    .padding()
////                }
////            }
////            .tabItem {
////                Text(CustomizationTab.all.label)
////            }
////            .tag(CustomizationTab.all)
//        }
//    }
//}
