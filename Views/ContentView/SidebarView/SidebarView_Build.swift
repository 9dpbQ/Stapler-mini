//
//  SidebarKeyboardKeyView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/08.
//

import SwiftUI

extension Double {
    func formatUnitSize() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0  // 最小桁数0
        formatter.maximumFractionDigits = 2  // 最大桁数2
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."     // 小数点の指定
        
        return (formatter.string(from: NSNumber(value: self)) ?? "\(self)") + " u"
    }
}

struct SidebarView_Build: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics { viewModel.keyMetrics }
    
//    @Binding var selectedKeyboardKey: KeyboardKey
//    @Binding var deviceRows: DeviceRows
        
    @State private var isVendorIDExpanded = false
    @State private var isProductIDExpanded = false
    @State private var isLocationIDExpanded = false

    var body: some View {
        if viewModel.configuration.selections.keyboardKey != .initialKey {
            let selectedKeyboardKey = $viewModel.configuration.selections.keyboardKey
            if let deviceRows = viewModel.configuration.keymap.getDeviceRows_byID(by: viewModel.configuration.selections.keyboardKey.id){
                VStack {
                    
                    KeytopView_FromDetail(
                        fromDetail: selectedKeyboardKey.wrappedValue.fromDetail,
                        isSelected: true,
                        keyMetrics: keyMetrics,
                        keyShape: selectedKeyboardKey.wrappedValue.keyShape
                    )
                    
                    List {
                        Section {
                            Stepper {
                                Text(selectedKeyboardKey.wrappedValue.unitSize.formatUnitSize())
                            } onIncrement: {
                                withAnimation {
                                    selectedKeyboardKey.wrappedValue.unitSize += 0.25
                                }
                            } onDecrement: {
                                if selectedKeyboardKey.wrappedValue.unitSize > 0.5 {
                                    withAnimation {
                                        selectedKeyboardKey.wrappedValue.unitSize -= 0.25
                                    }
                                }
                            }
                            .disabled(selectedKeyboardKey.wrappedValue.keyShape != .square)
                            
                            Toggle("is Spacer", isOn: selectedKeyboardKey.isSpacer)
                                .toggleStyle(.switch)
                            
                            Picker("Shape", selection: selectedKeyboardKey.keyShape) {
                                ForEach(KeyShape.allCases.filter { !$0.isArrows }, id: \.self) { shape in
                                    Text(shape.rawValue).tag(shape)
                                }
                            }
                            .disabled(selectedKeyboardKey.wrappedValue.keyShape.isArrows)
                            .labelsHidden()
                            .onChange(of: selectedKeyboardKey.wrappedValue.keyShape) { _, newShape in
                                if let unitSize = newShape.handleShapeChanged() {
                                    withAnimation {
                                        selectedKeyboardKey.wrappedValue.unitSize = unitSize
                                    }
                                }
                            }
                            
                            DisclosureGroup("Label") {
                                DisplayTextFieldView(
                                    string: selectedKeyboardKey.fromDetail.display,
                                    isSFSymbol: selectedKeyboardKey.fromDetail.isSFSymbol
                                )
                            }
                        }
                        
                        Spacer()
                        
                        DisclosureGroup("Owned Device") {
                            Form {
                                TextField("Device Name", text: deviceRows.sectionDetail.deviceDetail.device_name)
                            }
                            .formStyle(.columns)
                            
                            Toggle("Main Section", isOn: deviceRows.isEnableMain)
                                .disabled(!deviceRows.wrappedValue.isEnableSub && !deviceRows.wrappedValue.isEnableTenkey)
                                .toggleStyle(.switch)
                            Toggle("Sub Section", isOn: deviceRows.isEnableSub)
                                .disabled(!deviceRows.wrappedValue.isEnableMain && !deviceRows.wrappedValue.isEnableTenkey)
                                .toggleStyle(.switch)
                            Toggle("Tenkey Section", isOn: deviceRows.isEnableTenkey)
                                .disabled(!deviceRows.wrappedValue.isEnableMain && !deviceRows.wrappedValue.isEnableSub)
                                .toggleStyle(.switch)
                            
                            DisclosureGroup("Device Condition") {
                                Toggle("Builtin Keyboard", isOn: deviceRows.sectionDetail.deviceDetail.is_builtin_keyboard)
                                    .toggleStyle(.switch)
                                
                                DisclosureGroup(isExpanded: $isVendorIDExpanded) {
                                    TextField("vendor_id", text: deviceRows.sectionDetail.deviceDetail.vendor_id)
                                        .textFieldStyle(.roundedBorder)
                                } label: {
                                    Toggle("vendor_id", isOn: deviceRows.sectionDetail.deviceDetail.is_vendor_id_Enabled)
                                        .toggleStyle(.switch)
                                        .onChange(of: deviceRows.wrappedValue.sectionDetail.deviceDetail.is_vendor_id_Enabled) { _, newValue in
                                            withAnimation {
                                                isVendorIDExpanded = newValue
                                            }
                                        }
                                }
                                
                                DisclosureGroup(isExpanded: $isProductIDExpanded) {
                                    TextField("product_id", text: deviceRows.sectionDetail.deviceDetail.product_id)
                                        .textFieldStyle(.roundedBorder)
                                } label: {
                                    Toggle("product_id", isOn: deviceRows.sectionDetail.deviceDetail.is_product_id_Enabled)
                                        .toggleStyle(.switch)
                                        .onChange(of: deviceRows.wrappedValue.sectionDetail.deviceDetail.is_product_id_Enabled) { _, newValue in
                                            withAnimation {
                                                isProductIDExpanded = newValue
                                            }
                                        }
                                }
                                
                                DisclosureGroup(isExpanded: $isLocationIDExpanded) {
                                    TextField("location_id", text: deviceRows.sectionDetail.deviceDetail.location_id)
                                        .textFieldStyle(.roundedBorder)
                                } label: {
                                    Toggle("location_id", isOn: deviceRows.sectionDetail.deviceDetail.is_location_id_Enabled)
                                        .toggleStyle(.switch)
                                        .onChange(of: deviceRows.wrappedValue.sectionDetail.deviceDetail.is_location_id_Enabled) { _, newValue in
                                            withAnimation {
                                                isLocationIDExpanded = newValue
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
                Text("SelectedKey is not Exsist in Devices. This Text should not be appeared.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding()
            }
        } else {
            InitialKeyboardKeyView()
        }
    }
    
}


    
struct InitialKeyboardKeyView: View {
    var body: some View {
        VStack {
            Text("Select any key on the keyboard view.")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}
