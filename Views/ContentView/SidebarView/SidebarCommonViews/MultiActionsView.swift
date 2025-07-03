//
//  MultiActionsView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

/// MulitiActionのカスタムを行うビュー
struct MultiActionsView: View {
    @Binding var toDetail: ToDetail
    @State var keyShape: KeyShape
    var body: some View {
        if toDetail.isMultiTapHoldEnabled {
            // TapHoldが有効かつ、タイプがChordの時、MultiActionは使えない
            // 代わりに、タップを連打でタップのホードを扱えるようになるオプションをここに表示する
            if toDetail.isTapHoldEnabled && toDetail.tapHoldType == .chord {
                Text("Chord type is not support Multi Action, but Repeat is available")
                Text("You Can type ･- as Hold Tap-Keycode.")
                Toggle("Repeat", isOn: $toDetail.is_repeat)
                    .toggleStyle(.switch)
                Toggle("Threshold", isOn: $toDetail.isMultiTapThresholdEnabled)
                    .toggleStyle(.switch)
                if toDetail.isMultiTapThresholdEnabled {
                    Slider(
                        value: $toDetail.multiTapThreshold,
                        in: 10...500,
                        step: 10
                    ) {
                        Text("\(Int(toDetail.multiTapThreshold))ms")
                    }
                }
            } else {
                // マルチタップホールドが有効
                // タップのみ
                // タップホールドかつDurationタイプ　の時
                Toggle("Threshold", isOn: $toDetail.isMultiTapThresholdEnabled)
                    .toggleStyle(.switch)
                if toDetail.isMultiTapThresholdEnabled {
                    Slider(
                        value: $toDetail.multiTapThreshold,
                        in: 10...500,
                        step: 10
                    ) {
                        Text("\(Int(toDetail.multiTapThreshold))ms")
                    }
                }
                
                ForEach($toDetail.multiTapHoldCollection.collection, id: \.self) { toDetail_multi in
                    HStack {
                        Spacer()
                        ToDetail_multiView(
                            toDetail_multi: toDetail_multi,
                            isTapHoldEnabled: toDetail.isTapHoldEnabled,
                            keyShape: keyShape
                        )
                        .contextMenu {
                            Button("delete") {
                                toDetail.multiTapHoldCollection.removeMulti(
                                        byId: toDetail_multi.id)
                            }
                        }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
                .onMove { indexSet, offset in
                    toDetail.multiTapHoldCollection.collection.move(fromOffsets: indexSet, toOffset: offset)
                }
                
                HStack {
                    Spacer()
                    Button("add") {
                        let newMulti = ToDetail_multi()
                        toDetail.multiTapHoldCollection.addMulti(newMulti)
                    }
                    Spacer()
                }
            }
        } else {
            Text("Multi Action is not Enabled")
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}
