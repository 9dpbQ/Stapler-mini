//
//  ValidSectionButtonView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/10.
//
import SwiftUI

struct ValidSectionButtonView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var keymap: Keymap

    private var keyMetrics: KeyMetrics { viewModel.configuration.keyMetrics }
    
    @State var showingPopover_externalTenkey: Bool = false
    @State var showingPopover_main: Bool = false
    @State var showingPopover_mouse: Bool = false
    
    var body: some View {
        HStack {
            sectionButtonView(.other)
                .onHover { hovering in
                    if hovering && viewModel.configuration.keymap.validSections.containsSection(.other) {
                        showingPopover_externalTenkey = true
                    }
                }
                .popover(isPresented: $showingPopover_externalTenkey) {
                    PopoverView_DeviceDetail(
                        deviceDetail: $viewModel.configuration.keymap.other.sectionDetail.deviceDetail,
                        deviceRows: $viewModel.configuration.keymap.other
                    )
                }
            
            sectionButtonView(.main)
                .onHover { hovering in
                    if hovering && viewModel.configuration.keymap.validSections.containsSection(.main) {
                        showingPopover_main = true
                    }
                }
                .popover(isPresented: $showingPopover_main) {
                    PopoverView_DeviceDetail(
                        deviceDetail: $viewModel.configuration.keymap.main.sectionDetail.deviceDetail,
                        deviceRows: $viewModel.configuration.keymap.main
                    )
                }
            
            sectionButtonView(.mouse)
                .onHover { hovering in
                    if hovering && viewModel.configuration.keymap.validSections.containsSection(.mouse) {
                        showingPopover_mouse = true
                    }
                }
                .popover(isPresented: $showingPopover_mouse) {
                    PopoverView_DeviceDetail(
                        deviceDetail: $viewModel.configuration.keymap.mouse.sectionDetail.deviceDetail,
                        deviceRows: $viewModel.configuration.keymap.mouse
                    )
                }
            
            Slider(value: $viewModel.configuration.displayKeySize, in: 30...100, step: 10)
                .frame(width: 200)
        }
    }

    private func sectionButtonView(_ section: Devices) -> some View {
        Group {
            Button(action: {
                // Mainは除去可能にする？それ単体しか残っていなかった場合、除去はできないようにするとか
                if !keymap.validSections.containsSection(section) {
                    keymap.validSections.addSection(section)
                } else {
                    keymap.validSections.removeSection(section)
                }
            }) {
                Text(keymap.getBindingSectionDetail(section).deviceDetail.device_name.wrappedValue)
                    .frame(width: 100, height: 30)
                    .background(
                        keymap.validSections.containsSection(section)
                                ? .orange
                                : .gray
                    )
                    .foregroundStyle(
                        keymap.validSections.containsSection(section)
                        ? .white
                        : .black
                    )
                    .cornerRadius(5)
            }
        }
    }
}
