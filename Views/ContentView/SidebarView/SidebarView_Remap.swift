//
//  SidebarKeyboardKeyView 2.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/11.
//
import SwiftUI

struct SidebarView_Remap: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    @State var isTapHoldExpanded: Bool = false
    @State var isMultiActionExpanded: Bool = false
    @State var isCustomJSONExpanded: Bool = false
    
    let keyMetrics: KeyMetrics = KeyMetrics(unitSize: 1, baseSizeX: 65)
    
    var body: some View {
        if viewModel.configuration.selections.keyboardKey != .initialKey {
            let selectedKeyboardKey = viewModel.configuration.selections.keyboardKey
            let toDetail = viewModel.configuration.selections.keyboardKey.getBindingToDetail(
                condition: viewModel.configuration.selections.condition,
                layer: viewModel.configuration.selections.layer
            )
            
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text("Tap")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        KeyTopView_ToDetail(
                            toDetail: toDetail,
                            keyShape: selectedKeyboardKey.keyShape,
                            keyMetrics: keyMetrics,
                            tapOrHold: .tap
                        )
                        
                        ModifierToggleView(withModifier: toDetail.withModifier_tap)
                    }
                    
                    if toDetail.wrappedValue.isTapHoldEnabled {
                        Spacer()
                        VStack {
                            Text("Hold")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            KeyTopView_ToDetail(
                                toDetail: toDetail,
                                keyShape: selectedKeyboardKey.keyShape,
                                keyMetrics: keyMetrics,
                                tapOrHold: .hold
                            )
                            ModifierToggleView(withModifier: toDetail.withModifier_hold)
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    Spacer()
                    
                }
                List {
                    DisclosureGroup("Label") {
                        DisclosureGroup("Tap") {
                            DisplayTextFieldView(
                                string: toDetail.outputAndDisplay_tap.display,
                                isSFSymbol: toDetail.outputAndDisplay_tap.isSFSymbol
                            )
                        }
                        if toDetail.wrappedValue.isTapHoldEnabled {
                            DisclosureGroup("Hold") {
                                DisplayTextFieldView(
                                    string: toDetail.outputAndDisplay_hold.display,
                                    isSFSymbol: toDetail.outputAndDisplay_hold.isSFSymbol
                                )
                            }
                        }
                    }
                    DisclosureGroup(isExpanded: $isTapHoldExpanded) {
                        TapHoldOptionsView(toDetail: toDetail)
                    } label: {
                        Toggle("Tap Hold", isOn: toDetail.isTapHoldEnabled)
                            .toggleStyle(.switch)
                            .onChange(of: toDetail.wrappedValue.isTapHoldEnabled) { oldValue, newValue in
                                withAnimation {
                                    isTapHoldExpanded = newValue
                                }
                            }
                    }
                    
                    DisclosureGroup(isExpanded: $isMultiActionExpanded) {
                        MultiActionsView(toDetail: toDetail, keyShape: selectedKeyboardKey.keyShape)
                    } label: {
                        Toggle("Multi Tap Hold", isOn: toDetail.isMultiTapHoldEnabled)
                            .toggleStyle(.switch)
                            .onChange(of: toDetail.wrappedValue.isMultiTapHoldEnabled) { oldValue, newValue in
                                withAnimation {
                                    isMultiActionExpanded = newValue
                                }
                            }
                    }
                    
                    DisclosureGroup(isExpanded: $isCustomJSONExpanded) {
                        TextEditor(text: toDetail.userJSONEContent)
                            .disabled(!toDetail.wrappedValue.isUserCustomJSONEnabled)
                            .foregroundColor(
                                toDetail.wrappedValue.isUserCustomJSONEnabled
                                ? .primary : .gray
                            )
                    } label: {
                        Toggle("UserCustomJSON",isOn: toDetail.isUserCustomJSONEnabled)
                            .toggleStyle(.switch)
                            .onChange(of: toDetail.wrappedValue.isUserCustomJSONEnabled) { oldValue, newValue in
                                withAnimation {
                                    isCustomJSONExpanded = newValue
                                    if newValue { // トグルがオンになった時、ToDetail一つ分のjsonをstringで返してもらう
                                        let exporter = JSONExporter()
                                        do {
                                            if let sectionDetail = viewModel.configuration.keymap.getSectionDetail(by: selectedKeyboardKey.id) {
                                                if let jsonString = try exporter.singleModification_keyboardkey(
                                                    fromDetail: selectedKeyboardKey.fromDetail,
                                                    toDetail: toDetail.wrappedValue,
                                                    layer: viewModel.configuration.selections.layer,
                                                    condition: viewModel.configuration.selections.condition,
                                                    conditionDetail: viewModel.configuration.conditionDetailCollection.getConditionDetail(viewModel.configuration.selections.condition),
                                                    deviceDetail: sectionDetail.deviceDetail,
                                                    keycodeRegion: viewModel.configuration.keymap.keycodeRegion,
                                                    macroCollection: viewModel.configuration.macroCollection,
                                                    forUserCustomJSON: true
                                                ) {
                                                    toDetail.wrappedValue.userJSONEContent = jsonString
                                                } else {
                                                    // JSONが生成されなかった場合、例えば有効なカスタムがされていない場合
                                                    toDetail.wrappedValue.userJSONEContent = "there is no Valid Customization"
                                                }
                                            }
                                            
                                        } catch {
                                            print("error: \(error)")
                                            toDetail.wrappedValue.userJSONEContent = "Error: Unable to generate JSON. When Export setting to Karabiner-Elements, please toggle off this section or Fail to Import settings. Error: \(error)"
                                        }
                                    }
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .onAppear {
                isTapHoldExpanded = toDetail.wrappedValue.isTapHoldEnabled
                isMultiActionExpanded = toDetail.wrappedValue.isMultiTapHoldEnabled
                isCustomJSONExpanded = toDetail.wrappedValue.isUserCustomJSONEnabled
            }
            .animation(.easeInOut, value: toDetail.wrappedValue.isTapHoldEnabled)
            
        } else {
            InitialKeyboardKeyView()
        }
    }
}
