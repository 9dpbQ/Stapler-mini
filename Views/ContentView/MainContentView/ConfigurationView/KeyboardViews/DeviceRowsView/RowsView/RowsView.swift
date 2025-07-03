//
//  RowsView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/10.
//
import SwiftUI

// RowsのKeyboaardKeyを描画するビュー
struct RowsView: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics { KeyMetrics(unitSize: 1, baseSizeX: viewModel.configuration.displayKeySize) }

    @Binding var rows: Rows

    private var configuration: Configuration {
        viewModel.configuration
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach(RowIndex.allCases, id: \.self) { rowIndex in
                VStack(alignment: .leading, spacing: 0) {
                    let keyboardKeys = rows.getRowKeyboardKeys(rowIndex)
                    if keyboardKeys.isEmpty {
                        EmptyView()
                    } else {
                        ForEach(0..<rowIndex.indexValue(), id: \.self) { _ in
                            //インデックス分のスペーサーを用意
                            Spacer()
                                .frame(
                                    width: keyMetrics.frame.width * rows.sumOfUnitSize(rowIndex: rowIndex),
                                    height: keyMetrics.frame.height
                                )
                        }
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(keyboardKeys.indices, id: \.self) { keyIndex in
                                KeyboardKeyView(keyboardKey: keyboardKeys[keyIndex]) {
                                    configuration.selections.keyboardKey = .initialKey
                                    keyboardKeys.wrappedValue.remove(at: keyIndex)
                                }
                            }
                            
                            if rows.enableArrowKeys && (rows.rowIndex_arrow == rowIndex) {
                               //ここにArrowがこのRowにあるようならarrowビューを呼び出す感じ？
                                ArrowsView(
                                    left: $rows.arrow_left,
                                    right: $rows.arrow_right,
                                    up: $rows.arrow_up,
                                    down: $rows.arrow_down
                                )
                                .contextMenu {
                                    Button("disable arrow Keys") {
                                        print("disable arrow keys")
                                        rows.enableArrowKeys = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
