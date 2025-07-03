//
//  MacroView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2025/01/08.
//

import SwiftUI
import Combine

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}


struct MacroView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State private var searchText: String = ""
    
    private var filteredAndSortedMacros: [Macro] {
        let filtered = searchText.isEmpty
        ? viewModel.configuration.macroCollection.collection
        : viewModel.configuration.macroCollection.collection.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
        return filtered
    }
    
    private var keyMetrics_15: KeyMetrics {
        KeyMetrics(unitSize: 1.2, baseSizeX: 50)
    }
    private var keyMetrics_1u: KeyMetrics{ viewModel.keyMetrics }
    private var keyboardMonitor: KeyboardMonitor {
        viewModel.keyboardMonitor
    }
    var body: some View {
        HStack {
            UserMacrosListView().padding()
            Spacer()
            Group {
                if viewModel.configuration.isMacroSelected {
                    SelectedMacro_ToDetail_macrosView(keySize: 50)
                } else {
                    VStack {
                        Text("Macro is Key Seaquence that can be apply to Remap and Combo.")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Group {
                            Text("You can type seaquence of key with one stroke if you apply macro to Remap or Combo.")
                            Text("Select or Add Macro from left List.")
                        }
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding()
            Spacer()
        }
        .frame(maxHeight: 400)
    }
}

struct OnHoverButtonView: View {
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
                .frame(width: size.width * 0.6, height: size.height * 0.6) // アイコンの適切なサイズ
                .foregroundColor(onHover ? .white :.secondary)
                .opacity(onHover ? 1.0 : 0.5)
                .padding(size.width * 0.2) // 内側の余白
                .background(Circle().fill(onHover ? hoverColor.opacity(1.0) : Color.gray.opacity(0.1))) // 背景を丸く
                .scaleEffect(onHover ? 1.1 : 1) // ホバー時に拡大
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
    }
}

struct OnHoverButtonView_replace: View {
    let nonHoverSymbolName: String
    let hoverSymbolName: String
    let hoverColor: Color
    let size: CGSize
    @State private var onHover: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: onHover ? hoverSymbolName : nonHoverSymbolName)
                .resizable() // サイズ変更可能に
                .scaledToFit() // 縦横比を維持
                .frame(width: size.width * 0.6, height: size.height * 0.6) // アイコンの適切なサイズ
                .foregroundColor(onHover ? .white :.secondary)
                .opacity(onHover ? 1.0 : 0.5)
                .padding(size.width * 0.2) // 内側の余白
                .background(Circle().fill(onHover ? hoverColor.opacity(1.0) : Color.clear)) // 背景を丸く
                .scaleEffect(onHover ? 1.1 : 1) // ホバー時に拡大
                .contentTransition(.symbolEffect(.replace))
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
    }
}



struct ToDetail_macroView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var toDetail: ToDetail_macro
    
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: 50)
    }
    private var keyboardMonitor: KeyboardMonitor {
        viewModel.keyboardMonitor
    }
    
    @Binding var nextIndicator: Bool
    @State var showPopover: Bool = false

    var body: some View {
        Button(action: {
            withAnimation {
                viewModel.configuration.selections.toDetail_macro = toDetail
            }
        }) {
            KeyTopView(isSelected: viewModel.configuration.selections.toDetail_macro == toDetail, displaySize: keyMetrics.baseSizeX)
                .overlay {
                    HStack(spacing: 0) {
                        ModifierContentView(withModifier: toDetail.withModifier, keyMetrics: keyMetrics, color: .white)
                        SFSymbolOrTextView(
                            symbolName: toDetail.outputAndDisplay.display,
                            isSFSymbol: toDetail.outputAndDisplay.isSFSymbol,
                            size: keyMetrics.fontSize_tap,
                            color: .white
                        )
                    }
                    RecordingIndicatorView(indicator: toDetail.indicator, keyMetrics: keyMetrics, keyShape: .square)
                }
                .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
                .onTapGesture(count: 2, perform: {
                    print("double clicked")
                    viewModel.configuration.selections.toDetail_macro = toDetail
                    
                    keyboardMonitor.startMonitoring_ToDetail_Macro_Next(
                        toDetail: $toDetail,
                        macro: $viewModel.configuration.selections.macro,
                        configuration: $viewModel.configuration,
                        nextIndicator: $nextIndicator
                    )
                })
                .modifier(SelectedOnHover(isSelected: viewModel.configuration.selections.toDetail_macro == toDetail, showPopover: $showPopover))
                .popover(isPresented: $showPopover, content: {
                    ModifierToggleView(withModifier: $toDetail.withModifier)
                        .padding()
                })
                .dropDestination(for: DragClass.self) { items, location in
                    guard let item = items.first else { return false }
                    if let custom = item.customizeKey {
//                        print("customizeKey dropped!")
                        toDetail.applyCustom(from: custom)
                        return true
                    } else if let _ = item.macro {
//                        print("macro dropped!")
                        return false
                    }
                    
                    return true
                }
       }
        .buttonStyle(.plain)
        .frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)

    }
}
struct SelectedMacro_ToDetail_macrosView: View {
    @EnvironmentObject private var viewModel: ViewModel
    let keySize: CGFloat
    
    private var keyMetrics_1u: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: keySize)
    }
    private var keyMetrics_15: KeyMetrics {
        KeyMetrics(unitSize: 1.5, baseSizeX: keySize)
    }
    
    @State var nextIndicator: Bool = false

    var body: some View {
        List {
            if viewModel.configuration.selections.macro.toDetailCollection.collection.isEmpty {
                VStack {
                    HStack {
                        Spacer()
                        OnHoverButtonView(
                            symbolName: "plus",
                            hoverColor: Color.accentColor,
                            size: CGSize(width: keyMetrics_15.frameWidth / 3, height: keyMetrics_15.frameHeight / 3)
                        ) {
                            let newToDetail = [
                                ToDetail_macro(output: .letter_keys(.h)),
                                ToDetail_macro(output: .letter_keys(.e)),
                                ToDetail_macro(output: .letter_keys(.l)),
                                ToDetail_macro(output: .letter_keys(.l)),
                                ToDetail_macro(output: .letter_keys(.o)),
                                ToDetail_macro(output: .shift_symbols(.exclamation)),
                            ]
                            viewModel.configuration.selections.macro.toDetailCollection.collection.append(contentsOf: newToDetail)
                        }
                        .dropDestination(for: DragClass.self) { items, location in
                            guard let item = items.first else { return false }
                            if let custom = item.customizeKey {
                                let newToDetail = ToDetail_macro(output: custom.output)
                                viewModel.configuration.selections.macro.toDetailCollection.collection.insert(newToDetail, at: 0)
                                return true
                            }
                            return true
                        }
                        .frame(height: keyMetrics_1u.frameHeight)
                        Spacer()
                    }
                    Text("Click the plus button to add a keycode, or drag and drop a key onto the button.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                
            } else {
                ForEach(viewModel.configuration.selections.macro.toDetailCollection.collection.chunked(into: 10), id: \.self) { chunk in
                    ZStack {
                        HStack(spacing: 0) {
                            ForEach(chunk, id: \.self) { detail in
                                if let elementIndex = viewModel.configuration.selections.macro.toDetailCollection.collection.firstIndex(of: detail) {
                                    ToDetail_macroView(
                                        toDetail: $viewModel.configuration.selections.macro.toDetailCollection.collection[elementIndex],
                                        nextIndicator: $nextIndicator
                                    )
                                    .overlay {
                                        OnHoverButtonView(
                                            symbolName: "trash",
                                            hoverColor: .red,
                                            size: CGSize(width: keyMetrics_15.frameWidth / 4, height: keyMetrics_15.frameHeight / 4)
                                        ) {
                                            withAnimation {
                                                print("elementIndex: \(elementIndex)")
                                                viewModel.configuration.selections.macro.toDetailCollection.collection.remove(at: elementIndex)
                                            }
                                        }
                                        .frame(
                                            width: keyMetrics_1u.frameWidth + keyMetrics_1u.padding_body * 2,
                                            height: keyMetrics_1u.frameHeight + keyMetrics_1u.padding_body * 2,
                                            alignment: .topLeading
                                        )
                                        .offset(x: -3, y: -2)
                                    }
                                    .frame(width: keyMetrics_15.frameWidth)
                                    .padding([.top, .bottom], 10)
                                } else {
                                    EmptyView()
                                }
                            }
                        }
                        HStack(spacing: 0) {
                            if chunk.first == viewModel.configuration.selections.macro.toDetailCollection.collection.first {
                                OnHoverButtonView(
                                    symbolName: "plus",
                                    hoverColor: Color.accentColor,
                                    size: CGSize(width: keyMetrics_15.frameWidth / 3, height: keyMetrics_15.frameHeight / 3)
                                ) {
                                    let newToDetail = ToDetail_macro(output: .letter_keys(.a), display: "a")
                                    if let firstElement = chunk.first,
                                       let sectionStartIndex = viewModel.configuration.selections.macro.toDetailCollection.collection.firstIndex(of: firstElement) {
                                        print("sectionStartIndex: \(sectionStartIndex)")
                                        viewModel.configuration.selections.macro.toDetailCollection.collection.insert(newToDetail, at: sectionStartIndex)
                                    }
                                }
                                .dropDestination(for: DragClass.self) { items, location in
                                    guard let item = items.first else { return false }
                                    if let firstElement = chunk.first,
                                       let sectionStartIndex = viewModel.configuration.selections.macro.toDetailCollection.collection.firstIndex(of: firstElement) {
                                        if let custom = item.customizeKey {
                                            let newToDetail = ToDetail_macro(output: custom.output)
                                            viewModel.configuration.selections.macro.toDetailCollection.collection.insert(newToDetail, at: sectionStartIndex)
                                            return true
                                        }
                                    }
                                    return true
                                }
                                .frame(height: keyMetrics_1u.frameHeight)
                            } else {
                                Spacer()
                                    .frame(
                                        width: keyMetrics_15.frameWidth / 3,
                                        height: keyMetrics_1u.frameHeight
                                    )
                            }
                            
                            
                            ForEach(chunk, id: \.self) { detail in
                                Spacer()
                                    .frame(
                                        width: keyMetrics_15.frameWidth - keyMetrics_15.frameWidth / 3,
                                        height: keyMetrics_15.frameHeight - keyMetrics_15.frameHeight / 3
                                    )
                                if detail == viewModel.configuration.selections.macro.toDetailCollection.collection.last {
                                    OnHoverButtonView(
                                        symbolName: "plus",
                                        hoverColor: Color.accentColor,
                                        size: CGSize(width: keyMetrics_15.frameWidth / 3, height: keyMetrics_15.frameHeight / 3)
                                    ) {
                                        let newToDetail = ToDetail_macro(output: .letter_keys(.a), display: "a")
                                        viewModel.configuration.selections.macro.toDetailCollection.collection.append(newToDetail)
                                    }
                                    .dropDestination(for: DragClass.self) { items, location in
                                        guard let item = items.first else { return false }
                                        if let elementIndex = viewModel.configuration.selections.macro.toDetailCollection.collection.firstIndex(of: detail) {
                                            if let custom = item.customizeKey {
                                                let newToDetail = ToDetail_macro(output: custom.output)
                                                viewModel.configuration.selections.macro.toDetailCollection.collection.append(newToDetail)
                                            }
                                        }
                                        return true
                                    }
                                    .frame(height: keyMetrics_1u.frameHeight)
                                    .overlay {
                                        RecordingIndicatorView(indicator: nextIndicator, keyMetrics: keyMetrics_1u, keyShape: .square)
                                            .offset(x: keyMetrics_1u.padding_keytop * 3, y: keyMetrics_1u.padding_keytop * 3)
                                    }
                                } else {
                                    OnHoverButtonView_replace(
                                        nonHoverSymbolName: "arrow.right",
                                        hoverSymbolName: "plus",
                                        hoverColor: Color.accentColor,
                                        size: CGSize(width: keyMetrics_15.frameWidth / 3, height: keyMetrics_15.frameHeight / 3)
                                    ) {
                                        let newToDetail = ToDetail_macro(output: .letter_keys(.a), display: "a")
                                        if let elementIndex = viewModel.configuration.selections.macro.toDetailCollection.collection.firstIndex(of: detail) {
                                            print("elementIndex: \(elementIndex)")
                                            viewModel.configuration.selections.macro.toDetailCollection.collection.insert(newToDetail, at: elementIndex + 1)
                                        }
                                    }
                                    .dropDestination(for: DragClass.self) { items, location in
                                        guard let item = items.first else { return false }
                                        if let elementIndex = viewModel.configuration.selections.macro.toDetailCollection.collection.firstIndex(of: detail) {
                                            if let custom = item.customizeKey {
                                                let newToDetail = ToDetail_macro(output: custom.output)
                                                viewModel.configuration.selections.macro.toDetailCollection.collection.insert(newToDetail, at: elementIndex + 1)
                                                return true
                                            }
                                        }
                                        return true
                                    }
                                    .frame(height: keyMetrics_1u.frameHeight)
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .cornerRadius(5)
        .shadow(radius: 2)
    }
}

struct UserMacrosListView: View {
    @EnvironmentObject private var viewModel: ViewModel

    
    @State var searchText: String = ""
    
    private var filteredMacros: [Macro] {
        let filtered = searchText.isEmpty
        ? viewModel.configuration.macroCollection.collection
        : viewModel.configuration.macroCollection.collection.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
        return filtered
    }
    
    var body: some View {
        List(selection: $viewModel.configuration.selections.macro) {
            Section {
                ForEach(filteredMacros, id: \.self) { macro in
                    Group {
                        if macro == viewModel.configuration.selections.macro {
                            TextField(
                                "macro name",
                                text: Binding(
                                    get: { macro.name },
                                    set: { newValue in
                                        macro.name = newValue
                                    }
                                )
                            )
                        } else {
                            Text(macro.name)
                        }
                    }
                    .tag(macro)
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            if let indexInOriginal = viewModel.configuration.macroCollection.collection.firstIndex(of: macro) {
                                withAnimation {
                                    viewModel.configuration.selections.macro = .initialMacro
                                    viewModel.configuration.macroCollection.collection.remove(at: indexInOriginal)
                                }
                            }
                        }
                    }
                }
                // searchTextが空の時のみonMoveを有効にする
                .if(searchText.isEmpty) { view in
                    view.onMove { indexSet, offset in
                        viewModel.configuration.macroCollection.collection.move(fromOffsets: indexSet, toOffset: offset)
                    }
                }
            } header: {
                HStack {
                    // 検索フィールド→ テキストフィールドに入力した文字でフィルター
                    TextField(text: $searchText) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search Macro")
                        }
                    }.textFieldStyle(.plain)
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray.opacity(0.7))
                        }
                        .accessibilityLabel("clear search text")
                        .buttonStyle(.plain)
                    }
                    // 追加ボタン↓
                    Button("Add") {
                        withAnimation {
                            let newMacro = Macro(name: "Macro\(viewModel.configuration.macroCollection.collection.count + 1)")
                            viewModel.configuration.macroCollection.collection.insert(newMacro, at: 0)
                        }
                    }
                }
            }
        }
        .frame(minWidth: 150, maxWidth: 150)
        .cornerRadius(5)
        .shadow(radius: 2)
    }
}
