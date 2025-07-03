//
//  ComboView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2025/01/09.
//

import SwiftUI

struct ComboListView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State var nextIndicator: Bool = false
    @State private var isSorted: Bool = true // 🔥 ソートのオン・オフを管理
    
    var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: 65)
    }
    var keyboardKeyMetrics: KeyMetrics {
        viewModel.keyMetrics
    }
    // ソートされた / されていない配列
    private var computedCombos: [Combo] {
        isSorted
        ? viewModel.configuration.currentComboArray.wrappedValue.sorted { $0.simultaneouses.count > $1.simultaneouses.count }
        : viewModel.configuration.currentComboArray.wrappedValue
    }
    private var currentComboArray: [Combo] {
        viewModel.configuration.currentComboArray.wrappedValue
    }
    
    private var listHeight: CGFloat {
        viewModel.configuration.keymap.maxFrameHeight(keyboardKeyMetrics)
    }
    
    var body: some View {
        VStack {
            List(selection: $viewModel.configuration.selections.combo) {
                Section {
                    ForEach(computedCombos, id: \.self) { combo in
                        HStack {
                            Spacer()
                            ComboDetailView(
                                combo: Binding(
                                    get: { combo },
                                    set: { newValue in
                                        withAnimation {
                                            if let index = viewModel.configuration.currentComboArray.wrappedValue.firstIndex(of: combo) {
                                                viewModel.configuration.currentComboArray.wrappedValue[index] = newValue
                                            }
                                        }
                                    }
                                ),
                                nextIndicator: $nextIndicator
                            )
                            .overlay {
                                Text("\(combo.simultaneouses.count)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .offset(
                                        x: viewModel.keyMetrics.frame_keytop.width / 2,
                                        y: viewModel.keyMetrics.frame_keytop.height / 2
                                    )
                            }
                            Spacer()
                        }
                        .contextMenu {
                            Button("delete", role: .destructive) {
                                withAnimation {
                                    if let index = viewModel.configuration.currentComboArray.wrappedValue.firstIndex(of: combo) {
                                        viewModel.configuration.currentComboArray.wrappedValue.remove(at: index)
                                    }
                                }
                            }
                        }
//                        .help("The Keycode is triggered by a simultaneous press of the highlighted keys.")
                        .tag(combo)
                    }

                    // 配列順に表示中のみonMoveを有効にする
                    .if(!isSorted) { view in
                        view.onMove { indexSet, offset in
                            viewModel.configuration.currentComboArray.wrappedValue.move(fromOffsets: indexSet, toOffset: offset)
                        }
                    }
                } header: {
                    // 🔥 ソート切り替えトグル
                    HStack {
                        Text("Combo List")
                        Spacer()
                        Toggle("Descending order of simultaneouses", isOn: $isSorted)
                            .labelsHidden()
                            .help("Descending order of simultaneouses")
                    }
                } footer: {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                let newCombo = Combo()
                                viewModel.configuration.currentComboArray.wrappedValue.append(newCombo)
                                viewModel.configuration.selections.combo = newCombo
                            }
                        }) {
                            RoundedRectangle(cornerRadius: keyMetrics.round_keytop)
                                .fill(Color.gray)
                                .frame(width: keyMetrics.frame_keytop.width, height: keyMetrics.frame_keytop.height)
                                .padding(keyMetrics.padding_keytop)
                                .overlay {
                                    RecordingIndicatorView(indicator: nextIndicator, keyMetrics: keyMetrics, keyShape: .square)
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: keyMetrics.fontSize_tap))
                                        .foregroundColor(.white)
                                }
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Add Combo")
                        Spacer()
                    }
                    .dropDestination(for: DragClass.self) { items, location in
                        guard let item = items.first else { return false }
                        if let custom = item.customizeKey {
                            withAnimation {
                                let newCombo = Combo()
                                newCombo.applyCustom_tap(from: custom)
                                viewModel.configuration.currentComboArray.wrappedValue.append(newCombo)
                                viewModel.configuration.selections.combo = newCombo
                            }
                            return true
                        }
                        return true
                    }
                }
            }
            .frame(
                width: keyMetrics.frameWidth * 1.7 + keyMetrics.padding_body * 2,
                height: viewModel.configuration.keymap.main.deviceFrame(viewModel.keyMetrics).height
            )
            .cornerRadius(5)
            .shadow(radius: 2)
        }
    }
}
