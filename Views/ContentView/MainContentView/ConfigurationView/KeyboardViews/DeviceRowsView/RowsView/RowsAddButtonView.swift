//
//  RowsAddButtonView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/10.
//
import SwiftUI

// KeyboardKey Viewの間に表示される追加ボタンのビュー
struct RowsAddButtonView: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics { viewModel.keyMetrics }
    @Binding var rows: Rows
    
    var body: some View {
        // 横方向のボタン、
        VStack(alignment: .leading, spacing: 0) {
            ForEach(RowIndex.allCases, id: \.self) { rowIndex in
                Group {
                    let keyboardKeys = rows.getRowKeyboardKeys(rowIndex)
                    if keyboardKeys.isEmpty && rows.afterRowIsNotEmpty(rowIndex) {
                        // 配列に何もないが、後列にはキーが存在してる時
                        OnHoverButtonView_appear(
                            symbolName: "plus",
                            hoverColor: Color.accentColor,
                            size: CGSize(width: keyMetrics.addButtonWidth, height: keyMetrics.frameHeight)) {
                                withAnimation {
                                    let newKey = KeyboardKey(output: .letter_keys(.a))
                                    rows.appendKey(newKey, from: rowIndex)
                                }
                                
                            }
                    } else if keyboardKeys.isEmpty { // 配列が空の時
                        EmptyView()
                    } else { // それ以外のキーとキーの間の時
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(0..<keyboardKeys.wrappedValue.count, id: \.self) { keyIndex in
                                let keyboardKeyKeyMetrics: KeyMetrics = KeyMetrics(
                                    unitSize: keyboardKeys[keyIndex].unitSize.wrappedValue,
                                    baseSizeX: keyMetrics.baseSizeX
                                )
                                // ここに追加のボタンを表示していく。
                                OnHoverButtonView_appear(
                                    symbolName: "plus",
                                    hoverColor: Color.accentColor,
                                    size: CGSize(width: keyboardKeyKeyMetrics.addButtonWidth, height: keyboardKeyKeyMetrics.frameHeight)) {
                                        withAnimation {
                                            let newKey = KeyboardKey(output: .letter_keys(.a))
                                            rows.insertKey(newKey, from: rowIndex, at: keyIndex)
                                        }
                                    }
                                    .contextMenu {
                                        Button("Move Builtin Arrow Keys to this row") {
                                            withAnimation {
                                                rows.enableArrowKeys = true
                                                rows.rowIndex_arrow = rowIndex
                                            }
                                        }
                                        Button("Disable Builtin Arrow Keys") {
                                            withAnimation {
                                                rows.enableArrowKeys = false
                                            }
                                        }
                                        Button("Add 5 Keys") {
                                            withAnimation {
                                                var keys: [KeyboardKey] = []
                                                var count = 0
                                                while count < 5 {
                                                    let newKey = KeyboardKey(output: .letter_keys(.a), unitSize: 1, keyShape: .square, isSpacer: false, region: viewModel.configuration.keymap.keycodeRegion)
                                                    keys.append(newKey)
                                                    count += 1
                                                }
                                                keyboardKeys.wrappedValue.insert(contentsOf: keys, at: keyIndex)
                                            }
                                        }
                                        if rowIndex.indexValue() < 5 {
                                            Button("Add Key to Next Row") {
                                                withAnimation {
                                                    var newKey = KeyboardKey(output: .letter_keys(.a))
                                                    rows.getRowKeyboardKeys(rowIndex.nextRow()).wrappedValue.append(newKey)
                                                }
                                            }
                                        }
                                    }
                                Spacer()
                                    .frame(
                                        width: keyboardKeyKeyMetrics.buttonSpacerWidth,
                                        height: keyboardKeyKeyMetrics.frame.height
                                    )
                            }
                            // 配列の最後のキーの右にこれを表示
                            OnHoverButtonView_appear(
                                symbolName: "plus",
                                hoverColor: Color.accentColor,
                                size: CGSize(width: keyMetrics.addButtonWidth, height: keyMetrics.frameHeight)) {
                                    withAnimation {
                                        let newKey = KeyboardKey(output: .letter_keys(.a))
                                        rows.appendKey(newKey, from: rowIndex)
                                    }
                                }
                                .contextMenu {
                                    Button("Move Builtin Arrow Keys to this row") {
                                        withAnimation {
                                            rows.enableArrowKeys = true
                                            rows.rowIndex_arrow = rowIndex
                                        }
                                    }
                                    Button("Disable Builtin Arrow Keys") {
                                        withAnimation {
                                            rows.enableArrowKeys = false
                                        }
                                    }
                                    Button("Add 5 Keys") {
                                        withAnimation {
                                            var keys: [KeyboardKey] = []
                                            var count = 0
                                            while count < 5 {
                                                let newKey = KeyboardKey(output: .letter_keys(.a), unitSize: 1, keyShape: .square, isSpacer: false, region: viewModel.configuration.keymap.keycodeRegion)
                                                keys.append(newKey)
                                                count += 1
                                            }
                                            keyboardKeys.wrappedValue.append(contentsOf: keys)
                                        }
                                    }
                                    if rowIndex.indexValue() < 5 {
                                        Button("Add Key to Next Row") {
                                            withAnimation {
                                                var newKey = KeyboardKey(output: .letter_keys(.a))
                                                rows.getRowKeyboardKeys(rowIndex.nextRow()).wrappedValue.append(newKey)
                                            }
                                        }
                                    }
                                }
                            
                            // Arrowsが有効な時、その分のスペーサーを描画
                            if rows.enableArrowKeys && rows.rowIndex_arrow == rowIndex {
                                Spacer()
                                    .frame(
                                        width: 3 * (keyMetrics.buttonSpacerWidth + keyMetrics.addButtonWidth),
                                        height: keyMetrics.frame.height
                                    )
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
}
