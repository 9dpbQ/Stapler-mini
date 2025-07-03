//
//  KeyboardKeyView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/08.
//

import AppKit
import SwiftUI
import UniformTypeIdentifiers

struct KeyTopShapeFrame: ViewModifier {
    let keyShape: KeyShape
    let keyMetrics: KeyMetrics
    
    init(_ keyShape: KeyShape, keyMetrics: KeyMetrics) {
        self.keyShape = keyShape
        self.keyMetrics = keyMetrics
    }
    
    func body(content: Content) -> some View {
        content
            .frame(
                width: keyShape.keytopSize(keyMetrics).width,
                height: keyShape.keytopSize(keyMetrics).height,
                alignment: .center
            )
            .contentShape(keyShape.keytopShape(keyMetrics))
    }
}
struct SelectedOnHover: ViewModifier {
    let isSelected: Bool
    @Binding var showPopover: Bool
    func body(content: Content) -> some View {
        Group {
            if isSelected {
                content
                    .onHover { hovering in
                        if hovering {
                            showPopover = true
                        }
                    }
            } else {
                content
            }
        }
    }
}

struct KeyboardKeyView: View {
    @Binding var keyboardKey: KeyboardKey//表示するKeyboardKey
    @EnvironmentObject private var viewModel: ViewModel

    private var selectedKeyboardKey: Binding<KeyboardKey> { viewModel.configuration.selectedKeyboardkey }
    private var selectedCombo: Binding<Combo>? { viewModel.configuration.selectedCombo }
    
    private var selectedLayer: Layer { viewModel.configuration.selections.layer }
    private var selectedCondition: SpecificCondition { viewModel.configuration.selections.condition }
    
    private var macroCollection: MacroCollection { viewModel.configuration.macroCollection }
    
    private var toDetail: ToDetail {keyboardKey.getToDetail(selectedCondition, layer: selectedLayer)}
    private var toDetail_Layer0: ToDetail { keyboardKey.getToDetail(.condition0, layer: .layer0)}
    
    private var keyboardMonitor: KeyboardMonitor {
        viewModel.keyboardMonitor
    }
    
    private var keyMetrics: KeyMetrics {
        KeyMetrics(
            unitSize: keyboardKey.unitSize,
            baseSizeX: viewModel.configuration.displayKeySize
        )
    }
    
    private var dragClass: DragClass {
        DragClass(
            toDetail: toDetail,
            fromDetail: keyboardKey.fromDetail
        )
    }
    
    @State private var isPressed: Bool = false
    @State private var showPopover: Bool = false
    @State private var hoverTask: Task<Void, Never>?
    @State private var isHovered = false

    
    private var isKeyboardkeySelected: Bool {
        selectedKeyboardKey.wrappedValue === keyboardKey
    }

    let deleteAction: () -> Void
    let isArrowKeys: Bool
    
    private var isHilight: Bool {
        switch viewModel.configuration.selections.tab {
        case .combo:
            viewModel.configuration.isComboSelected && viewModel.configuration.selectedCombo.simultaneouses.wrappedValue.contains(CustomUUID(id: keyboardKey.id))
        default: viewModel.configuration.isKeyboardKeySelected && viewModel.configuration.selectedKeyboardkey.wrappedValue == keyboardKey
        }
    }
    
    private var hilightColor: Color {
        switch viewModel.configuration.selections.tab {
        case .deviceEdit:
                .white
        default:
            viewModel.configuration.selections.layer.accentColor
        }
    }
//    private var currentCondition: SpecificCondition {
//        viewModel.configuration.selections.condition
//    }
//    private var currentLayer: Layer {
//        viewModel.configuration.selections.layer
//    }
    
    init(
        keyboardKey: Binding<KeyboardKey>,
        isArrowKeys: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self._keyboardKey = keyboardKey
        self.isArrowKeys = isArrowKeys
        self.deleteAction = action
    }
    var body: some View {
        if keyboardKey.isSpacer && viewModel.configuration.selections.tab != .deviceEdit {
            Spacer()
                .frame(
                    width: keyboardKey.keyShape.frameSize(keyMetrics).width,
                    height: keyboardKey.keyShape.frameSize(keyMetrics).height,
                    alignment: keyboardKey.keyShape.alignment()
                )
        } else {
            Button(action: {
                clicked()
            }) {
                KeyTopView(
                    isSelected: isHilight,
                    hilightColor: hilightColor,
                    keyShape: keyboardKey.keyShape,
                    unitSize: keyboardKey.unitSize
                )
                .overlay {
                    if viewModel.configuration.selections.tab == .deviceEdit {
                        overlayContent_deviceEdit
                    }
                    if viewModel.configuration.selections.tab == .remap {
                        overlayContent_remap
                    }
                    if viewModel.configuration.selections.tab == .combo {
                        overlayContentView_combo
                    }
                }
                .modifier(KeyTopShapeFrame(keyboardKey.keyShape, keyMetrics: keyMetrics))
                .if(viewModel.configuration.selections.tab != .combo, transform: { view in
                    // コンボ以外ではダブルタップと、ポップオーバーの表示を行う
                    view.onTapGesture(count: 2, perform: {
                            doubleClicked()
                        })
                        .modifier(SelectedOnHover(isSelected: isKeyboardkeySelected, showPopover: $showPopover))
                        .popover(isPresented: $showPopover, arrowEdge: .top) {
                            PopoverView(
                                keyboardKey: $keyboardKey,
                                selections: viewModel.configuration.selections,
                                showPopover: $showPopover,
                                keyboardMonitor: keyboardMonitor,
                                macroCollection: macroCollection,
                                keyMetrics: keyMetrics
                            )
                        }
                        .draggable(dragClass)
                        
                })
                .if(viewModel.configuration.selections.tab == .deviceEdit) { view in
                    view.dropDestination(for: DragClass.self) { items, location in
                        guard let item = items.first else { return false }
                        if let custom = item.customizeKey_from {
                            print("customizeKey_from dropped")
                            keyboardKey.applyCustom_from(from: custom)
                        } else if let fromDetail = item.fromDetail {
                            print("fromDetail copy")
                            keyboardKey.applyCustom_from_ByFromDetail(fromDetail)
                        }
                        return true
                    }
                }
                .if(viewModel.configuration.selections.tab == .remap) { view in
                    view.dropDestination(for: DragClass.self) { items, location in
                        guard let item = items.first else { return false }
                        if let custom = item.customizeKey {
                            keyboardKey.applyCustom_tap(from: custom, condition: selectedCondition, layer: selectedLayer)
                            viewModel.configuration.selections.keyboardKey = keyboardKey
                            print("customizeKey dropped")
                            return true
                        } else if let macro = item.macro {
                            keyboardKey.applyMacro_tap(from: macro, condition: selectedCondition, layer: selectedLayer)
                            viewModel.configuration.selections.keyboardKey = keyboardKey
                            print("macro dropped")
                            return true
                        } else if let toDetail = item.toDetail {
                            keyboardKey.copyOtherToDetail(from: toDetail, condition: selectedCondition, layer: selectedLayer)
                            viewModel.configuration.selections.keyboardKey = keyboardKey
                            print("keyboardKey dropped")
                        }

                        return true
                    }
                }
                .frame(
                    width: keyboardKey.keyShape.hilightFrameSize(keyMetrics).width,
                    height: keyboardKey.keyShape.hilightFrameSize(keyMetrics).height,
                    alignment: .center)
            }
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isHovered = hovering
                }
            }
            .scaleEffect(isHovered ? 1.05 : 1.0)
            .buttonStyle(.plain)
            .contextMenu {
                if viewModel.configuration.selections.tab == .remap {
                    Button("Reset custom of current \(selectedLayer.displayName) in \(viewModel.configuration.conditionDetailCollection.getConditionDetail(selectedCondition).name)") {
                        withAnimation {
                            keyboardKey.getBindingToDetail(condition: selectedCondition, layer: selectedLayer).wrappedValue.resetAll()
                        }
                    }
                    Button("Reset all custom of this Key") {
                        withAnimation {
                            keyboardKey.resetAllCustom()
                        }
                    }
                }
                if !isArrowKeys && viewModel.configuration.selections.tab == .deviceEdit {
                    Button("delete") {
                        withAnimation {
                            print("delete!!!")
                            deleteAction()
                        }
                    }
                }
            }
//            .if(!isArrowKeys && viewModel.configuration.selections.tab == .deviceEdit, transform: { view in
//                view.contextMenu {
//                    Button("delete") {
//                        withAnimation {
//                            print("delete!!!")
//                            deleteAction()
//                        }
//                    }
//                }
//            })
            .frame(
                width: keyboardKey.keyShape.frameSize(keyMetrics).width,
                height: keyboardKey.keyShape.frameSize(keyMetrics).height,
                alignment: keyboardKey.keyShape.alignment()
            )
            .opacity(viewModel.configuration.selections.tab == .deviceEdit && keyboardKey.isSpacer ? 0.5 : 1.0)
            .animation(.easeInOut, value: keyboardKey)
        }
    }
    
    private func clicked() {
        switch viewModel.configuration.selections.tab {
        case .combo:
            if viewModel.configuration.isComboSelected {
                let combo = viewModel.configuration.selections.combo
                if let index = combo.simultaneouses.firstIndex(where: { $0.id == keyboardKey.id }) {
                    // UUIDがすでに格納されている場合は削除
                    combo.simultaneouses.remove(at: index)
                } else {
                    // UUIDが格納されていない場合は追加
                    combo.simultaneouses.append(CustomUUID(id: keyboardKey.id))
                }
            }
        default:
            viewModel.configuration.selections.keyboardKey = keyboardKey
        }
    }
    private func doubleClicked() {
        switch viewModel.configuration.selections.tab {
        case .deviceEdit:
            print("double click in Device edit tab")
            keyboardMonitor.startMonitoring_FromDetail(configuration: $viewModel.configuration)
        case .remap:
            print("double click in Remap tab")
            keyboardMonitor.startMonitoring_ToDetail_nextKeyboardKey(
                configuration: $viewModel.configuration
            )
        default:
            print("doubleClicked in combo, macro tab")
        }
    }
    
    private var overlayContentView_combo: some View {
        Group {
            holdKeyView
            tapKeyView
        }
    }
    private var overlayContent_deviceEdit: some View {
        Group{
            SFSymbolOrTextView(
                symbolName: keyboardKey.fromDetail.display,
                isSFSymbol: keyboardKey.fromDetail.isSFSymbol,
                size: keyMetrics.fontSize_tap,
                color: .white
            )
            RecordingIndicatorView(
                indicator: keyboardKey.indicator,
                keyMetrics: keyMetrics,
                keyShape: keyboardKey.keyShape
            )
        }
    }
  
    private var overlayContent_remap: some View {
        Group {
            layer1to8Info
            holdKeyView
            tapKeyView
            
            RecordingIndicatorView(indicator: keyboardKey.indicator, keyMetrics: keyMetrics, keyShape: keyboardKey.keyShape)
            CautionView(
                caution: toDetail.error, keyMetrics: keyMetrics, keyShape: keyboardKey.keyShape,
                helpText: "An error occurred with this keyboard key during the last export."
            )
        }
    }
    
    private var holdKeyView: some View {
        Group {
            if toDetail.isTapHoldEnabled && toDetail.isCustomized_hold {
                if toDetail.isMacro_hold {
                    MacroTextView(macro_id: toDetail.macro_id_hold, layer: selectedLayer)
                } else {
                    // Holdは就職キーは表示しない
                    SFSymbolOrTextView(
                        symbolName: toDetail.outputAndDisplay_hold.display,
                        isSFSymbol: toDetail.outputAndDisplay_hold.isSFSymbol,
                        size: keyMetrics.fontSize_hold,
                        color: toDetail.outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor
                    )
                }
            } else {
                EmptyView()
            }
        }
        .foregroundColor(toDetail.outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor)
        .opacity(0.5)
    }
    private var tapKeyView: some View {
        Group {
            if toDetail.isCustomized_tap {
                customizedContent
            } else if toDetail.isCustomized_hold {
                // Holdのみがカスタマイズされている場合、
                EmptyView()
            } else {
                defaltContent
            }
        }
    }
    private func layerinfo(_ toDetail: ToDetail, layer: Layer, alignment: Alignment) -> some View {
        HStack(spacing: 0) {
            ModifierContentView_HStacked(withModifier: toDetail.withModifier_tap, fontSize: keyMetrics.fontSize_tap / 2, color: layer.accentColor)
            if toDetail.isMacro_tap {
                MacroTextView(
                    macro_id: toDetail.macro_id_tap,
                    layer: layer, fontSize: keyMetrics.fontSize_tap / 2
                )
            } else {
                SFSymbolOrTextView(
                    symbolName: toDetail.isCustomized_tap ? toDetail.outputAndDisplay_tap.display : toDetail.outputAndDisplay_hold.display,
                    isSFSymbol: toDetail.isCustomized_tap ? toDetail.outputAndDisplay_tap.isSFSymbol : toDetail.outputAndDisplay_hold.isSFSymbol,
                    size: keyMetrics.fontSize_tap / 2,
                    color: layer.accentColor
                )
            }
        }
        .padding(keyMetrics.padding_keytop / 2)
        .frame(
            width: keyboardKey.keyShape.keytopSize(keyMetrics).width,
            height: keyboardKey.keyShape.keytopSize(keyMetrics).height,
            alignment: alignment
        )
        
    }
    // Layer0の時だけ表示する他のレイヤーの情報を表示するビュー
    private var layer1to8Info: some View {
        Group {
            if selectedLayer == .layer0 {
                ZStack {
                    // layer1がカスタマイズされている時はその情報を左上に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer1).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer1), layer: .layer1, alignment: .topLeading)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer1).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer1), layer: .layer1, alignment: .topLeading).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                    // layer2がカスタマイズされている時はその情報を右上に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer2).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer2), layer: .layer2, alignment: .topTrailing)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer2).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer2), layer: .layer2, alignment: .topTrailing).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                    // layer3がカスタマイズされている時はその情報を左下に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer3).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer3), layer: .layer3, alignment: .bottomLeading)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer3).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer3), layer: .layer3, alignment: .bottomLeading).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                    // layer4がカスタマイズされている時はその情報を左下に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer4).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer4), layer: .layer4, alignment: .bottomTrailing)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer4).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer4), layer: .layer4, alignment: .bottomTrailing).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                    // layer5がカスタマイズされている時はその情報を上中央に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer5).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer5), layer: .layer5, alignment: .top)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer5).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer5), layer: .layer5, alignment: .top).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                    // layer6がカスタマイズされている時はその情報を左中央に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer6).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer6), layer: .layer6, alignment: .leading)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer6).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer6), layer: .layer6, alignment: .leading).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                    // layer7がカスタマイズされている時はその情報を右中央に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer7).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer7), layer: .layer7, alignment: .trailing)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer7).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer7), layer: .layer7, alignment: .trailing).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                    // layer8がカスタマイズされている時はその情報をした中央に表示
                    if keyboardKey.getToDetail(selectedCondition, layer: .layer8).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(selectedCondition, layer: .layer8), layer: .layer8, alignment: .bottom)
                    } else if keyboardKey.getToDetail(.condition0, layer: .layer8).isTapOrHoldCustomized {
                        layerinfo(keyboardKey.getToDetail(.condition0, layer: .layer8), layer: .layer8, alignment: .bottom).opacity(0.5)
                    } else {
                        EmptyView()
                    }
                    
                }
            } else {
                EmptyView()
            }
        }
    }
    private var defaltContent: some View {
        Group {
            if selectedCondition == .condition0 {
                if selectedLayer == .layer0 {
                    //layer0ならFromのテキスト
                    SFSymbolOrTextView(
                        symbolName: keyboardKey.fromDetail.display,
                        isSFSymbol: keyboardKey.fromDetail.isSFSymbol,
                        size: keyMetrics.fontSize_tap,
                        color: .white
                    )
                } else {
                    EmptyView()
                }
            } else {
                // Condition0以外で、カスタマイズされていない場合、Condition0の状態を表示する
                ZStack {
                    holdKeyView_condition0
                    tapKeyView_condition0
                }
            }
                
        }
    }
    private var customizedContent: some View {
        Group {
            HStack(spacing: 0) {
                if toDetail.isMacro_tap {
                    MacroTextView(macro_id: toDetail.macro_id_tap, layer: selectedLayer)
                } else {
                    if toDetail.outputAndDisplay_tap.layerKey == .layer0 {
                        ModifierContentView(
                            withModifier: toDetail.withModifier_tap,
                            keyMetrics: keyMetrics,
                            color: toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor
                        )
                    }
                    SFSymbolOrTextView(
                        symbolName: toDetail.outputAndDisplay_tap.display,
                        isSFSymbol: toDetail.outputAndDisplay_tap.isSFSymbol,
                        size: keyMetrics.fontSize_tap,
                        color: toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor
                    )
                }
            }
            //Tapにレイヤー遷移キーが入っている場合はそのレイヤーのカラー、それ以外の場合は現在のレイヤーの色
//            .foregroundColor(toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
            .if(selectedLayer == .layer0, transform: { view in
                view.overlay {
                    SFSymbolOrTextView(
                        symbolName: keyboardKey.fromDetail.display,
                        isSFSymbol: keyboardKey.fromDetail.isSFSymbol,
                        size: keyMetrics.fontSize_tap / 2,
                        color: .gray
                    )
                    .frame(
                        width: keyboardKey.keyShape.keytopSize(keyMetrics).width,
                        height: keyboardKey.keyShape.keytopSize(keyMetrics).height,
                        alignment: .bottomTrailing
                    )
                }
            })
        }
    }
    private var tapKeyView_condition0: some View {
        Group {
            if keyboardKey.getToDetail(.condition0, layer: selectedLayer).isCustomized_tap || keyboardKey.getToDetail(.condition0, layer: selectedLayer).isCustomized_hold {
                customizedContent_condition0
            } else {
                defaltContent_condition0
            }
        }
        .opacity(0.5)
    }
    private var holdKeyView_condition0: some View {
        Group {
            let toDetail_defaultCondition: ToDetail = keyboardKey.getToDetail(.condition0, layer: selectedLayer)
            if toDetail_defaultCondition.isTapHoldEnabled && toDetail_defaultCondition.isCustomized_hold {
                if toDetail_defaultCondition.isMacro_hold {
                    MacroTextView(macro_id: toDetail_defaultCondition.macro_id_hold, layer: selectedLayer, fontSize: keyMetrics.fontSize_hold)
                } else {
                    SFSymbolOrTextView(
                        symbolName: keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_hold.display,
                        isSFSymbol: keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_hold.isSFSymbol,
                        size: keyMetrics.fontSize_hold,
                        color: toDetail_defaultCondition.outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor
                    )
                }
            } else {
                EmptyView()
            }
        }
        .opacity(0.25)
    }
    private var defaltContent_condition0: some View {
        Group {
            if selectedLayer == .layer0 {
                SFSymbolOrTextView(
                    symbolName: keyboardKey.fromDetail.display,
                    isSFSymbol: keyboardKey.fromDetail.isSFSymbol,
                    size: keyMetrics.fontSize_tap,
                    color: keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor
                )
            } else {
                EmptyView()
            }
        }
    }
    private var customizedContent_condition0: some View {
        Group {
            let toDetail_defaultCondition: ToDetail = keyboardKey.getToDetail(.condition0, layer: selectedLayer)
            ZStack {
                HStack(spacing: 0) {
                    if toDetail_defaultCondition.isMacro_tap {
                        MacroTextView(macro_id: toDetail_defaultCondition.macro_id_tap, layer: selectedLayer)
                    } else {
                        ModifierContentView(withModifier: toDetail_defaultCondition.withModifier_tap, keyMetrics: keyMetrics, color: toDetail_defaultCondition.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
                        SFSymbolOrTextView(
                            symbolName: toDetail_defaultCondition.outputAndDisplay_tap.display,
                            isSFSymbol: toDetail_defaultCondition.outputAndDisplay_tap.isSFSymbol,
                            size: keyMetrics.fontSize_tap,
                            color: toDetail_defaultCondition.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor
                        )
                    }
                }
                if selectedLayer == .layer0 {
                    SFSymbolOrTextView(
                        symbolName: keyboardKey.fromDetail.display,
                        isSFSymbol: keyboardKey.fromDetail.isSFSymbol,
                        size: keyMetrics.fontSize_tap / 2, color: .gray
                    )
                    .frame(
                        width: keyboardKey.keyShape.keytopSize(keyMetrics).width,
                        height: keyboardKey.keyShape.keytopSize(keyMetrics).height,
                        alignment: .bottomTrailing
                    )
                } else {
                    EmptyView()
                }
            }
        }
    }
}





//DropDestinationの格闘ログ

//            .dropDestination(for: Macro.self) { items, location in
//                selectedKeyboardKey = keyboardKey
//                guard let item = items.first else { return false }
//                keyboardKey.applyMacro_tap(from: item, layer: selectedLayer, app: selectedApp)
//                return true
//            }
            ///
            ///調査報告：
            ///二つのDropDestinationがあると、一つ目のDropDestinationに対してはうまくいく。
            ///しかし二つ目のクラスをドロップすると、一つ目のDrop Destinationが発火されている模様。
            ///ここをスルーできればうまくいきそうな予感はする。Destination内の処理いかんかな〜
            ///
            ///
            ///
//            .onDrop(
//                of: [UTType.customizekey, UTType.uuid],
//                delegate: DropHandler(
//                    keyboardKey: $keyboardKey,
//                    selectedKeyboardKey: $selectedKeyboardKey,
//                    selectedCondition: selectedCondition,
//                    selectedLayer: selectedLayer)
//            )
            

            
//            .dropDestination(for: CustomizeKey.self) { items, location in
//
//                guard let item = items.first else { return false }
//                print("customizeKey Dropped!")
//                selectedKeyboardKey = keyboardKey
//                keyboardKey.applyCustom_tap(from: item, condition: selectedCondition, layer: selectedLayer)
//                return true
//            }



//struct AppKitButton: NSViewRepresentable {
//    let content: NSView
//    var onSingleClick: () -> Void = {}
//    var onDoubleClick: () -> Void = {}
//
//    class CustomButtonView: NSView {
//        var onSingleClick: () -> Void = {}
//        var onDoubleClick: () -> Void = {}
//
//        private var singleClickTimer: Timer?
//        private let doubleClickTimeThreshold: TimeInterval = 0.3
//        private var lastClickTime: Date?
//        private var trackingArea: NSTrackingArea?
//
//        override init(frame frameRect: NSRect) {
//            super.init(frame: frameRect)
//            setupView()
//        }
//
//        required init?(coder: NSCoder) {
//            super.init(coder: coder)
//            setupView()
//        }
//
//        private func setupView() {
//            wantsLayer = true
//            layer?.cornerRadius = 8
//            layer?.backgroundColor = NSColor.clear.cgColor
//
//            setupTrackingArea()
//        }
//
//        private func setupTrackingArea() {
//            if let existingTrackingArea = trackingArea {
//                removeTrackingArea(existingTrackingArea)
//            }
//
//            let options: NSTrackingArea.Options = [
//                .mouseEnteredAndExited,
//                .mouseMoved,
//                .activeInKeyWindow,
//            ]
//
//            trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
//
//            if let trackingArea = trackingArea {
//                addTrackingArea(trackingArea)
//            }
//        }
//
//        override func updateTrackingAreas() {
//            super.updateTrackingAreas()
//            setupTrackingArea()
//        }
//
//        override func viewDidMoveToWindow() {
//            super.viewDidMoveToWindow()
//            setupTrackingArea()
//        }
//
//        override func setFrameSize(_ newSize: NSSize) {
//            super.setFrameSize(newSize)
//            setupTrackingArea()
//        }
//
//        // MARK: - Mouse Events
//        override func mouseDown(with event: NSEvent) {
//            singleClickTimer?.invalidate()
//            singleClickTimer = nil
//
//            applyPressedEffect()
//        }
//
//        override func mouseUp(with event: NSEvent) {
//
//            removePressedEffect()
//
//            let now = Date()
//            if let lastClick = lastClickTime, now.timeIntervalSince(lastClick) < doubleClickTimeThreshold {
//                handleDoubleClick()
//                lastClickTime = nil
//            } else {
//                handleSingleClick()
//                lastClickTime = now
//            }
//        }
//
//        override func mouseEntered(with event: NSEvent) {
//            handleMouseEntered()
//        }
//
//        override func mouseExited(with event: NSEvent) {
//            handleMouseExited()
//        }
//
//        // MARK: - Mouse Event Handlers
//        private func handleMouseEntered() {
//            NSCursor.pointingHand.push()
//        }
//
//        private func handleMouseExited() {
//            NSCursor.pop()
//        }
//
//        // MARK: - Visual Effects
//        private func applyPressedEffect() {
//            guard let layer = self.layer else { return }
//
//            let currentBounds = bounds
//            layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//            layer.position = CGPoint(x: currentBounds.midX, y: currentBounds.midY)
//            layer.setAffineTransform(CGAffineTransform(scaleX: 0.98, y: 0.98))
//        }
//
//        private func removePressedEffect() {
//            guard let layer = self.layer else { return }
//
//            layer.setAffineTransform(CGAffineTransform.identity)
//            let currentBounds = bounds
//            layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//            layer.position = CGPoint(x: currentBounds.midX, y: currentBounds.midY)
//        }
//
//        // MARK: - Event Handlers
//        private func handleSingleClick() {
//            singleClickTimer = Timer.scheduledTimer(withTimeInterval: doubleClickTimeThreshold, repeats: false) { [weak self] _ in
//                self?.onSingleClick()
//                self?.singleClickTimer = nil
//            }
//        }
//
//        private func handleDoubleClick() {
//            singleClickTimer?.invalidate()
//            singleClickTimer = nil
//            onDoubleClick()
//        }
//    }
//
//    func makeNSView(context: Context) -> CustomButtonView {
//        let buttonView = CustomButtonView(frame: .zero)
//        buttonView.onSingleClick = onSingleClick
//        buttonView.onDoubleClick = onDoubleClick
//
//        content.frame = buttonView.bounds
//        content.autoresizingMask = [.width, .height]
//        buttonView.addSubview(content)
//
//        return buttonView
//    }
//
//    func updateNSView(_ nsView: CustomButtonView, context: Context) {
//        nsView.onSingleClick = onSingleClick
//        nsView.onDoubleClick = onDoubleClick
//    }
//}
//// SwiftUIビューをNSViewに変換するヘルパー
//extension View {
//    func toNSView() -> NSView {
//        let view = NSHostingView(rootView: self)
//        view.setFrameSize(view.fittingSize)
//        return view
//    }
//}

//struct KeyboardKeyView: View {
//    @Binding var keyboardKey: KeyboardKey//表示するKeyboardKey
//    @Binding var selectedKeyboardKey: KeyboardKey//選択されているKeyboardKey
//    @Binding var selectedCombo: Combo//選択されているコンボ、この中のUUIDの配列とかをいい感じにやって追加されてるKeyboardKeyをハイライトするようにする？
//    let macroCollection: MacroCollection
//
//    private var isSelected: Bool { keyboardKey === selectedKeyboardKey }//選択されているかどうかのブール
//
//    @EnvironmentObject private var viewModel: ViewModel
//    private var selectedLayer: Layer { selectedLayer }
//    private var selectedCondition: SpecificCondition { selectedCondition }
//
//    private var toDetail: ToDetail {keyboardKey.getToDetail(selectedCondition, layer: selectedLayer)}
//    private var toDetail_Layer0: ToDetail { keyboardKey.getToDetail(.condition0, layer: .layer0)}
//
//    var keyboardMonitor: KeyboardMonitor
//
////    @State private var view_id: UUID = UUID()
//
//    private let keyMetrics: KeyMetrics
//
//    private var dragClass: DragClass {
//        DragClass(
//            toDetail: keyboardKey.getToDetail(selectedCondition, layer: selectedLayer),
//            fromDetail: keyboardKey.fromDetail
//        )
//    }
//
//    @State private var isPressed: Bool = false
//    @State private var indicator: Bool = false
//
//    @State private var isHovered: Bool = false
//    @State private var showPopover: Bool = false
//    @State private var hoverTimer: Timer? = nil
//
//    init(
//        for keyboardKey: Binding<KeyboardKey>,
//        selectedKeyboardKey: Binding<KeyboardKey>,
//        selectedCombo: Binding<Combo>,
//        macroCollection: MacroCollection,
//        size baseSizeX: CGFloat,
//        keyboardMonitor: KeyboardMonitor
//    ) {
//        self._keyboardKey = keyboardKey
//        self._selectedKeyboardKey = selectedKeyboardKey
//        self._selectedCombo = selectedCombo
//        self.macroCollection = macroCollection
//        self.keyMetrics = KeyMetrics(unitSize: keyboardKey.unitSize.wrappedValue, baseSizeX: baseSizeX)
//        self.keyboardMonitor = keyboardMonitor
//    }
//
//    var body: some View {
//        Group {
//            switch selectedTab {
//            case .keymap:
//                keyboardKeyView_keymap
//            case .combo:
//                keyboardKeyView_combo
//            case .presetDetail:
//                keyboardKeyView_keyboard
//            case .macro:
//                EmptyView()
//            case .keyboard:
//                keyboardKeyView_keyboard
//            }
//        }
//    }
//
//
//
//    // MARK: - Combo
//
//    private var keyboardKeyView_combo: some View {
//        ZStack {
//            KeyshapeHilightView(
//                keyMetrics: keyMetrics,
//                selected: selectedCombo.simultaneouses.contains(CustomUUID(id: keyboardKey.id))
//            )
//            ZStack {
//                holdKeyView
//                tapKeyView
//            }
//            .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
//            .background{KeyTopView(keyMetrics: keyMetrics)}
//            .onTapGesture {
//                if let index = selectedCombo.simultaneouses.firstIndex(where: { $0.id == keyboardKey.id }) {
//                    // UUIDがすでに格納されている場合は削除
//                    selectedCombo.simultaneouses.remove(at: index)
//                } else {
//                    // UUIDが格納されていない場合は追加
//                    selectedCombo.simultaneouses.append(CustomUUID(id: keyboardKey.id))
//                }
//            }
//            .padding(keyMetrics.padding)
//        }
//    }
//    // MARK: - Keyboard
//    private var keyboardKeyView_keyboard: some View {
//        ZStack {
//            KeyshapeHilightView(
//                keyMetrics: keyMetrics,
//                selected: selectedKeyboardKey === keyboardKey
//            )
//            fromKeyView
//            RecordingIndicatorView(indicator: indicator, keyMetrics: keyMetrics)
//        }
//        .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
//        .background{KeyTopView(keyMetrics: keyMetrics)}
//        .onTapGesture(count: 2, perform: {
//            print("double clicked")
//            indicator = true
//            keyboardMonitor.isMonitoring = true
//            keyboardMonitor.startMonitoring_FromDetail($keyboardKey.fromDetail, indicator: $indicator)
//        })
//        .onTapGesture {
//            selectedKeyboardKey = keyboardKey
//        }
//        .dropDestination(for: DragClass.self) { items, location in
//            guard let item = items.first else { return false }
//            if let custom = item.customizeKey {
//                print("customizeKey dropped!")
//                keyboardKey.applyCustom_from(from: custom)
//                return true
//            } else if let _ = item.macro {
//                print("macro dropped!")
//                return false
//            }
//
//            return true
//        }
//        .onHover { hovering in
//            handleHoverChange(isHovering: hovering)
//        }
//        .popover(isPresented: $showPopover, arrowEdge: .top) {
//            PopoverView(
//                keyboardKey: $keyboardKey,
//                isHovered: $isHovered,
//                showPopover: $showPopover,
//                keyboardMonitor: keyboardMonitor,
//                macroCollection: macroCollection,
//                keyMetrics: keyMetrics
//            )
//        }
//        .padding(keyMetrics.padding)
//        .frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
//    }
//    private var fromKeyView: some View {
//        SFSymbolOrTextView(content: keyboardKey.fromDetail.outputAndDisplay, size: keyMetrics.fontSize_tap)
//            .foregroundStyle(.white)
//    }
//
//    // MARK: - Keymap
//
//
//    private var keyboardKeyView_keymap: some View {
//        ZStack {
//            ///アウトライン
//            KeyshapeHilightView(keyMetrics: keyMetrics, selected: selectedKeyboardKey === keyboardKey)
//            ZStack {
//
//                holdKeyView
//                tapKeyView
//                RecordingIndicatorView(indicator: indicator, keyMetrics: keyMetrics)
//                CautionView(
//                    caution: (toDetail.error || (toDetail.isTapHoldEnabled && (toDetail.isCustomized_tap != toDetail.isCustomized_hold))),
//                    keyMetrics: keyMetrics
//                )
//
//            }
//            .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
//            .background{KeyTopView(keyMetrics: keyMetrics)}
//            .contextMenu {
//                Button("Clear Properties") {
////                    keyboardKey.clear(layer: selectedLayer, appNumber: selectedApp)
//                }
//            }
//            .dropDestination(for: DragClass.self) { items, location in
//                guard let item = items.first else { return false }
//                if let custom = item.customizeKey {
//                    keyboardKey.applyCustom_tap(from: custom, condition: selectedCondition, layer: selectedLayer)
//                    selectedKeyboardKey = keyboardKey
//                    print("customizeKey dropped")
//                    return true
//                } else if let macro = item.macro {
//                    keyboardKey.applyMacro_tap(from: macro, condition: selectedCondition, layer: selectedLayer)
//                    selectedKeyboardKey = keyboardKey
//                    print("macro dropped")
//                    return true
//                } else if let toDetail = item.toDetail {
//                    keyboardKey.copyOtherToDetail(from: toDetail, condition: selectedCondition, layer: selectedLayer)
//                    selectedKeyboardKey = keyboardKey
//                    print("keyboardKey dropped")
//                }
//
//                return true
//            }
//
//            .onTapGesture(count: 2, perform: {
//                print("double clicked")
//                indicator = true
//                keyboardMonitor.isMonitoring = true
//                keyboardMonitor.startMonitoring_ToDetail(
//                    keyboardKey.getBindingToDetail(condition: selectedCondition, layer: selectedLayer),
//                    type: .tap,
//                    indicator: $indicator
//                )
//            })
//            .onTapGesture {
//                withAnimation {
//                    selectedKeyboardKey = keyboardKey
//                }
//            }
//
//            .draggable(dragClass)
//            .onHover { hovering in
//                handleHoverChange(isHovering: hovering)
//            }
//
//            .popover(isPresented: $showPopover, arrowEdge: .top) {
//                PopoverView(
//                    keyboardKey: $keyboardKey,
//                    isHovered: $isHovered,
//                    showPopover: $showPopover,
//                    keyboardMonitor: keyboardMonitor,
//                    macroCollection: macroCollection,
//                    keyMetrics: keyMetrics
//                )
//            }
//            .padding(keyMetrics.padding)
//        }
//    }
//    // ホバー状態の変化を処理
//    private func handleHoverChange(isHovering: Bool) {
//        if isSelected {
//            if isHovering {
//                // 既存のタイマーを無効化
//                hoverTimer?.invalidate()
//                hoverTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//                    isHovered = true
//                    showPopover = true
//                }
//            } else {
//                // 遅延を設けてポップオーバーを消す
//                hoverTimer?.invalidate()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    if !isHovered {
//                        showPopover = false
//                    }
//                }
//            }
//        }
//    }
//
//    private var holdKeyView: some View {
//        Group {
//            if toDetail.isTapHoldEnabled && toDetail.isCustomized_hold {
//                if toDetail.isMacro_hold {
//                    Text(macroCollection.getMacro(byId: toDetail.macro_id_hold)?.name ?? "Missing Macro")
//                        .foregroundColor(macroCollection.getMacro(byId: toDetail.macro_id_hold) == nil ? .red : nil)
//                        .font(.system(size: keyMetrics.fontSize_tap))
//                } else {
//                    SFSymbolOrTextView(content: toDetail.outputAndDisplay_hold, size: keyMetrics.fontSize_hold)
//                }
//            } else {
//                EmptyView()
//            }
//        }
//        .foregroundColor(toDetail.outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor)
//        .opacity(0.5)
//    }
//    private var tapKeyView: some View {
//        Group {
//            if toDetail.isCustomized_tap {
//                customizedContent
//            } else {
//                defaltContent
//            }
//        }
//    }
//    private var defaltContent: some View {
//        Group {
//            if selectedCondition == .condition0 {
//                if selectedLayer == .layer0 {
//                    //layer0ならFromのテキスト
//                    SFSymbolOrTextView(content: keyboardKey.fromDetail.outputAndDisplay, size: keyMetrics.fontSize_tap)
//                        .foregroundColor(toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
//                } else {
//                    EmptyView()
//                }
//            } else {
//                ZStack {
//                    holdKeyView_condition0
//                    tapKeyView_condition0
//                }
//            }
//
//        }
//    }
//    private var customizedContent: some View {
//        Group {
//            ZStack {
//                HStack(spacing: 0) {
//                    if toDetail.isMacro_tap {
//                        Text(macroCollection.getMacro(byId: toDetail.macro_id_tap)?.name ?? "Missing Macro")
//                            .foregroundColor(macroCollection.getMacro(byId: toDetail.macro_id_tap) == nil ? .red : selectedLayer.accentColor)
//                            .font(.system(size: keyMetrics.fontSize_tap))
//
//                    } else {
//                        ModifierContentView(withModifier: toDetail.withModifier_tap, keyMetrics: keyMetrics)
//                        SFSymbolOrTextView(content: toDetail.outputAndDisplay_tap, size: keyMetrics.fontSize_tap)
//                    }
//                }
//                //Tapにレイヤー遷移キーが入っている場合はそのレイヤーのカラー、それ以外の場合は現在のレイヤーの色
//                .foregroundColor(toDetail.outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
//                if selectedLayer == .layer0 {//レイヤー0の時はBeforeの文字を入れてあげる
//                    VStack(spacing: 0) {
//                        Spacer()
//                        HStack(spacing: 0) {
//                            Spacer()
//                            SFSymbolOrTextView(content: keyboardKey.fromDetail.outputAndDisplay, size: keyMetrics.fontSize_tap / 2)
//                        }
//                    }
//                } else {
//                    EmptyView()
//                }
//            }
//        }
//    }
//    private var tapKeyView_condition0: some View {
//        Group {
//            if keyboardKey.getToDetail(.condition0, layer: selectedLayer).isCustomized_tap || keyboardKey.getToDetail(.condition0, layer: selectedLayer).isCustomized_hold {
//                customizedContent_condition0
//            } else {
//                defaltContent_condition0
//            }
//        }
//    }
//    private var holdKeyView_condition0: some View {
//        Group {
//            if keyboardKey.getToDetail(.condition0, layer: selectedLayer).isTapHoldEnabled && keyboardKey.getToDetail(.condition0, layer: selectedLayer).isCustomized_hold {
//                if keyboardKey.getToDetail(.condition0, layer: selectedLayer).isMacro_hold {
//                    Text(macroCollection.getMacro(byId: toDetail.macro_id_hold)?.name ?? "Missing Macro")
//                        .foregroundColor(macroCollection.getMacro(byId: toDetail.macro_id_hold) == nil ? .red : nil)
//                        .font(.system(size: keyMetrics.fontSize_tap))
//                } else {
//                    SFSymbolOrTextView(content: keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_hold, size: keyMetrics.fontSize_hold)
//                }
//            } else {
//                EmptyView()
//            }
//        }
//        .foregroundColor(keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_hold.layerKey.layerKeyColor ?? selectedLayer.accentColor)
//        .opacity(0.5)
//    }
//    private var defaltContent_condition0: some View {
//        Group {
//            if selectedLayer == .layer0 {
//                SFSymbolOrTextView(content: keyboardKey.fromDetail.outputAndDisplay, size: keyMetrics.fontSize_tap)
//                    .foregroundColor(keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
//            } else {
//                EmptyView()
//            }
//        }
//    }
//    private var customizedContent_condition0: some View {
//        Group {
//            ZStack {
//                HStack(spacing: 0) {
//                    if keyboardKey.getToDetail(.condition0, layer: selectedLayer).isMacro_tap {
//                        Text(macroCollection.getMacro(byId: toDetail.macro_id_tap)?.name ?? "Missing Macro")
//                            .foregroundColor(macroCollection.getMacro(byId: toDetail.macro_id_tap) == nil ? .red : selectedLayer.accentColor)
//                            .font(.system(size: keyMetrics.fontSize_tap))
//
//                    } else {
//                        ModifierContentView(withModifier: keyboardKey.getToDetail(.condition0, layer: selectedLayer).withModifier_tap, keyMetrics: keyMetrics)
//                        SFSymbolOrTextView(content: keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_tap, size: keyMetrics.fontSize_tap)
//                    }
//                }
//                .foregroundColor(keyboardKey.getToDetail(.condition0, layer: selectedLayer).outputAndDisplay_tap.layerKey.layerKeyColor ?? selectedLayer.accentColor)
//                if selectedLayer == .layer0 {
//                    VStack(spacing: 0) {
//                        Spacer()
//                        HStack(spacing: 0) {
//                            Spacer()
//                            SFSymbolOrTextView(content: keyboardKey.fromDetail.outputAndDisplay, size: keyMetrics.fontSize_tap / 2)
//                        }
//                    }
//                } else {
//                    EmptyView()
//                }
//            }
//        }
//    }
//}

