//
//  PopoverView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/19.
//

import SwiftUI

struct PopoverView_DeviceDetail: View {
    @EnvironmentObject private var viewModel: ViewModel

    @Binding var deviceDetail: DeviceDetail
    @Binding var deviceRows: DeviceRows
    
    @State private var isVendorIDExpanded = false
    @State private var isProductIDExpanded = false
    @State private var isLocationIDExpanded = false
    
    var body: some View {
        VStack {
            List {
                TextField("Device Name", text: $deviceDetail.device_name)
                    .font(.largeTitle)
                
                HStack {
                    Toggle("Main", isOn: $deviceRows.isEnableMain)
                        .disabled(!deviceRows.isEnableSub && !deviceRows.isEnableTenkey)
                        .toggleStyle(.button)
                    Toggle("Sub", isOn: $deviceRows.isEnableSub)
                        .disabled(!deviceRows.isEnableMain && !deviceRows.isEnableTenkey)
                        .toggleStyle(.button)
                    Toggle("Tenkey", isOn: $deviceRows.isEnableTenkey)
                        .disabled(!deviceRows.isEnableMain && !deviceRows.isEnableSub)
                        .toggleStyle(.button)
                }
                
                Toggle("Builtin Keyboard", isOn: $deviceDetail.is_builtin_keyboard)
                    .toggleStyle(.switch)
                
                DisclosureGroup(isExpanded: $isVendorIDExpanded) {
                    TextField("vendor_id", text: $deviceDetail.vendor_id)
                        .textFieldStyle(.roundedBorder)
                } label: {
                    Toggle("vendor_id", isOn: $deviceDetail.is_vendor_id_Enabled)
                        .toggleStyle(.switch)
                        .onChange(of: deviceDetail.is_vendor_id_Enabled) { _, newValue in
                            withAnimation {
                                isVendorIDExpanded = newValue
                            }
                        }
                }
                
                DisclosureGroup(isExpanded: $isProductIDExpanded) {
                    TextField("product_id", text: $deviceDetail.product_id)
                        .textFieldStyle(.roundedBorder)
                } label: {
                    Toggle("product_id", isOn: $deviceDetail.is_product_id_Enabled)
                        .toggleStyle(.switch)
                        .onChange(of: deviceDetail.is_product_id_Enabled) { _, newValue in
                            withAnimation {
                                isProductIDExpanded = newValue
                            }
                        }
                }
                
                DisclosureGroup(isExpanded: $isLocationIDExpanded) {
                    TextField("location_id", text: $deviceDetail.location_id)
                        .textFieldStyle(.roundedBorder)
                } label: {
                    Toggle("location_id", isOn: $deviceDetail.is_location_id_Enabled)
                        .toggleStyle(.switch)
                        .onChange(of: deviceDetail.is_location_id_Enabled) { _, newValue in
                            withAnimation {
                                isLocationIDExpanded = newValue
                            }
                        }
                }
                
                // display key size
                
                Slider(value: $viewModel.configuration.displayKeySize, in: 30...65, step: 5)
            }
            .listStyle(.sidebar)
        }
        .frame(minWidth: 250, minHeight: 250)
        .padding()
    }
}
