//
//  DeviceView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/10.
//
import SwiftUI

// 一つのデバイスのビュー
struct DeviceView: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    @Binding var deviceRows: DeviceRows
//    @Binding var configuration: Configuration
//    private var configuration: Configuration {
//        viewModel.configuration
//    }
    
    private var keyMetrics: KeyMetrics { viewModel.keyMetrics }
    @State var showingPopover: Bool = false
    var body: some View {
        ZStack {
            // キーボードのボディの塗り
            RoundedRectangle(cornerRadius: keyMetrics.round_body)
                .fill(
                    LinearGradient(
                        colors: [Color(red: 200/255, green: 200/255, blue: 190/255), Color(red: 150/255, green: 150/255, blue: 160/255)],
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .frame(
                    width: deviceRows.deviceFrame(keyMetrics).width,
                    height: deviceRows.deviceFrame(keyMetrics).height
                )
            // MARK: - ↑デバイスの有効無効化のUIをここに追加する
            // .ifでdevice Editタブならポップオーバーとオンホバー、コンテキストメニュー(無効化)をオンに、
            // ポップオーバーから無効にできるようにしても良いな
                .if(viewModel.configuration.selections.tab == .deviceEdit) { view in
                    view
                        .overlay(content: {
                            OnHoverButtonView(
                                symbolName: "gear",
                                hoverColor: .accentColor,
                                size: CGSize(width: viewModel.configuration.displayKeySize / 2, height: viewModel.configuration.displayKeySize / 2)
                            ) {
                                showingPopover = true
                            }
                                .help("Show popover to edit device condition")
                                .offset(
                                    CGSize(
                                        width: deviceRows.deviceFrame(keyMetrics).width / 2,
                                        height: deviceRows.deviceFrame(keyMetrics).height / -2
                                    )
                                )
                            
                            OnHoverButtonView(
                                symbolName: "minus",
                                hoverColor: .red,
                                size: CGSize(width: viewModel.configuration.displayKeySize / 2, height: viewModel.configuration.displayKeySize / 2)
                            ) {
                                viewModel.configuration.keymap.validSections.removeSection(deviceRows.sectionDetail.section)
                            }
                            .help("Disable this Device. Your customized content will not be deleted.")
                                .offset(
                                    CGSize(
                                        width: deviceRows.deviceFrame(keyMetrics).width / -2,
                                        height: deviceRows.deviceFrame(keyMetrics).height / -2
                                    )
                                )
                            
                        })
                        .popover(isPresented: $showingPopover) {
                            PopoverView_DeviceDetail(
                                deviceDetail: $deviceRows.sectionDetail.deviceDetail,
                                deviceRows: $deviceRows
                            )
                        }
                }
                .shadow(
                    color: Color(red: 23/255, green: 23/255, blue: 0/255),
                    radius: keyMetrics.padding_body * 0.6
                )

            
            // Keyboardのキーたち、
            HStack(alignment: .top, spacing: 0) {
                if deviceRows.isEnableMain {
                    RowsView(rows: $deviceRows.mainRows)
                }
                if deviceRows.isEnableMain && (deviceRows.isEnableSub || deviceRows.isEnableTenkey) {
                    Spacer()
                        .frame(width: keyMetrics.padding_section, height: keyMetrics.frameHeight)
                }
                if deviceRows.isEnableSub {
                    RowsView(rows: $deviceRows.subRows)
                }
                if deviceRows.isEnableSub && deviceRows.isEnableTenkey {
                    Spacer()
                        .frame(width: keyMetrics.padding_section, height: keyMetrics.frameHeight)
                }
                if deviceRows.isEnableTenkey {
                    RowsView(rows: $deviceRows.tenkeyRows)
                }
            }
            
            if viewModel.configuration.selections.tab == .deviceEdit {
                // KeyboardKeyの間に表示される追加ボタンたち
                HStack(alignment: .top, spacing: 0) {
                    if deviceRows.isEnableMain {
                        RowsAddButtonView(rows: $deviceRows.mainRows)
                    }
                    if deviceRows.isEnableSub {
                        RowsAddButtonView(rows: $deviceRows.subRows)
                    }
                    if deviceRows.isEnableTenkey {
                        RowsAddButtonView(rows: $deviceRows.tenkeyRows)
                    }
                }
            }
        }
    }
}
