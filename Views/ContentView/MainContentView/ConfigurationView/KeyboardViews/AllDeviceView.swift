//
//  KeyboardView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2025/01/05.
//

import SwiftUI
///キーボードのビュー。
///選択されているSectionのキーたちを表示するビュー
///全体のサイズはユニットサイズの合計から弾き出して、それっぽくベゼルをつけてキーボードの形にするイメージ


struct AllDeviceView: View {
    @Binding var keymap: Keymap
    @EnvironmentObject private var viewModel: ViewModel
    
    private var keyMetrics: KeyMetrics { viewModel.configuration.keyMetrics }
    
    var body: some View {
        HStack(spacing: 0) {
            //テンキー
            if keymap.validSections.containsSection(.other) {
                DeviceView(deviceRows: $keymap.other)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding()
            } else if viewModel.configuration.selections.tab == .deviceEdit {
                // ここにデバイスを有効にするボタン、ホバーでちょっと大きくなるやつ
                OnHoverButtonView(symbolName: "plus", hoverColor: .accentColor, size: CGSize(width: viewModel.configuration.displayKeySize, height: viewModel.configuration.displayKeySize)) {
                    viewModel.configuration.keymap.validSections.addSection(.other)
                }
                .help("Enable Device.")
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
            } else {
                EmptyView()
            }
            //メインキーボード
            if keymap.validSections.containsSection(.main) {
                DeviceView(deviceRows: $keymap.main)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding()
            } else if viewModel.configuration.selections.tab == .deviceEdit {
                OnHoverButtonView(symbolName: "plus", hoverColor: .accentColor, size: CGSize(width: viewModel.configuration.displayKeySize, height: viewModel.configuration.displayKeySize)) {
                    viewModel.configuration.keymap.validSections.addSection(.main)
                }
                .help("Enable Device.")
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
            } else {
                EmptyView()
            }
            //マウス
            if keymap.validSections.containsSection(.mouse) {
                DeviceView(deviceRows: $keymap.mouse)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding()
            } else if viewModel.configuration.selections.tab == .deviceEdit {
                OnHoverButtonView(symbolName: "plus", hoverColor: .accentColor, size: CGSize(width: viewModel.configuration.displayKeySize, height: viewModel.configuration.displayKeySize)) {
                    viewModel.configuration.keymap.validSections.addSection(.mouse)
                }
                .help("Enable Device.")
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
            } else {
                EmptyView()
            }
        }
        .animation(.default, value: viewModel.configuration.keymap.validSections.sections) // アニメーション適用
    }
}











