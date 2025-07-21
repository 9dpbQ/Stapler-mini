//
//  SidebarComboView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/08.
//

import SwiftUI

struct SidebarView_Combo: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    @State var isTapHoldExpanded: Bool = false
    @State var isMultiActionExpanded: Bool = false
    @State var isCustomJSONExpanded: Bool = false
    let keyMetrics: KeyMetrics = KeyMetrics(unitSize: 1, baseSizeX: 65)

    var body: some View {
        Group {
            if viewModel.configuration.isComboSelected {
                VStack {
                    HStack {
                        VStack {
                            Text("Tap")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            KeyTopView_ToDetail(
                                toDetail: $viewModel.configuration.selections.combo.toDetail,
                                keyShape: .square,
                                keyMetrics: keyMetrics,
                                tapOrHold: .tap
                            )
                            ModifierToggleView(withModifier: $viewModel.configuration.selections.combo.toDetail.withModifier_tap)
                        }
                        if viewModel.configuration.selections.combo.toDetail.isTapHoldEnabled {
                            VStack {
                                Text("Hold")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                KeyTopView_ToDetail(
                                    toDetail: $viewModel.configuration.selections.combo.toDetail,
                                    keyShape: .square,
                                    keyMetrics: keyMetrics,
                                    tapOrHold: .hold
                                )
                                ModifierToggleView(withModifier: $viewModel.configuration.selections.combo.toDetail.withModifier_hold)
                            }
                        }
                    }
                    List {
                        DisclosureGroup("Label") {
                            Section("Tap") {
                                DisplayTextFieldView(
                                    string: $viewModel.configuration.selections.combo.toDetail.outputAndDisplay_tap.display,
                                    isSFSymbol: $viewModel.configuration.selections.combo.toDetail.outputAndDisplay_tap.isSFSymbol
                                )
                            }
                            if viewModel.configuration.selections.combo.toDetail.isTapHoldEnabled {
                                Section("Hold") {
                                    DisplayTextFieldView(
                                        string: $viewModel.configuration.selections.combo.toDetail.outputAndDisplay_hold.display,
                                        isSFSymbol: $viewModel.configuration.selections.combo.toDetail.outputAndDisplay_hold.isSFSymbol
                                    )
                                }
                            }
                        }
                        DisclosureGroup(isExpanded: $isTapHoldExpanded) {
                            TapHoldOptionsView(toDetail: $viewModel.configuration.selections.combo.toDetail)
                        } label: {
                            Toggle("Tap Hold", isOn: $viewModel.configuration.selections.combo.toDetail.isTapHoldEnabled)
                                .toggleStyle(.switch)
                                .onChange(of: viewModel.configuration.selections.combo.toDetail.isTapHoldEnabled) { oldValue, newValue in
                                    withAnimation {
                                        if newValue && !isTapHoldExpanded {
                                            isTapHoldExpanded = true
                                        } else {
                                            isTapHoldExpanded = false
                                        }
                                    }
                                }
                        }
                        
                        DisclosureGroup(isExpanded: $isMultiActionExpanded) {
                            MultiActionsView(toDetail: $viewModel.configuration.selections.combo.toDetail, keyShape: .square)
                        } label: {
                            Toggle("Multi Tap Hold", isOn: $viewModel.configuration.selections.combo.toDetail.isMultiTapHoldEnabled)
                                .toggleStyle(.switch)
                                .onChange(of: viewModel.configuration.selections.combo.toDetail.isMultiTapHoldEnabled) { oldValue, newValue in
                                    withAnimation {
                                        if newValue {
                                            isMultiActionExpanded = true
                                        } else {
                                            isMultiActionExpanded = false
                                        }
                                    }
                                }
                        }
                        
                        DisclosureGroup("Simultaneouses") {
                            ForEach(viewModel.configuration.selections.combo.simultaneouses, id: \.self) { simultaneousId in
                                HStack {
                                    if let key = viewModel.configuration.keymap.getKeyboardKey(
                                        by: simultaneousId.id
                                    ) {
                                        Group {
                                            if key.fromDetail.isSFSymbol {
                                                Image(systemName: key.fromDetail.display)
                                            } else {
                                                Text(key.fromDetail.display)
                                            }
                                            Spacer()
                                            Image(systemName: "line.3.horizontal")
                                                .foregroundStyle(.gray)
                                        }
                                        
                                    } else {
                                        Text("not found 🎈")
                                            .foregroundStyle(.red)
                                            .bold()
                                            .font(.caption2)
                                        Spacer()
                                        Button("Remove") {
                                            withAnimation {
                                                viewModel.configuration.selections.combo.simultaneouses.removeAll { $0 == simultaneousId }
                                            }
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .onMove { indexSet, offset in
                                viewModel.configuration.selections.combo.simultaneouses.move(fromOffsets: indexSet, toOffset: offset)
                            }
                        }
                        
                        DisclosureGroup("Simultaneous Options") {
                            Toggle("Threshold", isOn: $viewModel.configuration.selections.combo.isThresholdEnabled)
                                .toggleStyle(.switch)
                            if viewModel.configuration.selections.combo.isThresholdEnabled {
                                Text("\(Int(viewModel.configuration.selections.combo.comboThreshold))ms")
                                Slider(
                                    value: $viewModel.configuration.selections.combo.comboThreshold,
                                    in: 10...500,
                                    step: 10
                                )
                            }
                            Toggle("uninterrupt", isOn: $viewModel.configuration.selections.combo.detect_key_down_uninterruptedly)
                                .toggleStyle(.switch)
                            Picker("Down Order", selection: $viewModel.configuration.selections.combo.key_down_order) {
                                ForEach(OrderType.allCases, id: \.self) { type in
                                    Text(type.rawValue.capitalized).tag(type)
                                }
                            }
                            Picker("Up Order", selection: $viewModel.configuration.selections.combo.key_up_order) {
                                ForEach(OrderType.allCases, id: \.self) { type in
                                    Text(type.rawValue.capitalized).tag(type)
                                }
                            }
                            Toggle("Up When All Keys Up", isOn: $viewModel.configuration.selections.combo.key_up_when_all_keys_up)
                                .toggleStyle(.switch)
                        }
                        DisclosureGroup(isExpanded: $isCustomJSONExpanded) {
                            TextEditor(text: $viewModel.configuration.selections.combo.toDetail.userJSONEContent)
                                .disabled(!viewModel.configuration.selections.combo.toDetail.isUserCustomJSONEnabled)
                                .foregroundColor(
                                    viewModel.configuration.selections.combo.toDetail.isUserCustomJSONEnabled
                                    ? .primary : .gray
                                )
                        } label: {
                            Toggle("Custom JSON", isOn: $viewModel.configuration.selections.combo.toDetail.isUserCustomJSONEnabled)
                                .toggleStyle(.switch)
                                .onChange(of: viewModel.configuration.selections.combo.toDetail.isUserCustomJSONEnabled) { oldValue, newValue in
                                    withAnimation {
                                        isCustomJSONExpanded = newValue
                                        if newValue {
                                            let exporter = JSONExporter()
                                            do {
                                                if let jsonString = try exporter.singleModification_combo(
                                                    combo: viewModel.configuration.selections.combo,
                                                    layer: viewModel.configuration.selections.layer,
                                                    condition: viewModel.configuration.selections.condition,
                                                    conditionDetail: viewModel.configuration.conditionDetailCollection.getConditionDetail(viewModel.configuration.selections.condition),
                                                    keycodeRegion: viewModel.configuration.keymap.keycodeRegion,
                                                    macroCollection: viewModel.configuration.macroCollection,
                                                    keymap: viewModel.configuration.keymap,
                                                    deviceSections: viewModel.configuration.keymap.validSections,
                                                    forUserCustomJSON: true
                                                ) {
                                                    viewModel.configuration.selections.combo.toDetail.userJSONEContent = jsonString
                                                } else {
                                                    viewModel.configuration.selections.combo.toDetail.userJSONEContent = "there is no Valid Customization"
                                                }
                                            } catch {
                                                print(error)
                                                viewModel.configuration.selections.combo.toDetail.userJSONEContent = "Error: Unable to generate JSON. When Export setting to Karabiner-Elements, please toggle off this section or Fail to Import settings. Error: \(error)"
                                            }
                                        }
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    
                }
            } else {
                InitialComboView()
            }
        }
    }
}




