//
//  oaieoaei.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

struct KeytopView_FromDetail: View {
    @EnvironmentObject private var viewModel: ViewModel

    let fromDetail: FromDetail

    let isSelected: Bool
    let keyMetrics: KeyMetrics
    let keyShape: KeyShape
    
    @State var indicator: Bool = false
    
    var body: some View {
        KeyTopView(
            isSelected: isSelected,
            keyShape: keyShape,
            unitSize: keyMetrics.unitSize
        )
            .overlay {
                SFSymbolOrTextView(
                    symbolName: fromDetail.display,
                    isSFSymbol: fromDetail.isSFSymbol,
                    size: keyMetrics.fontSize_tap,
                    color: .white
                )
                RecordingIndicatorView(
                    indicator: indicator,
                    keyMetrics: keyMetrics,
                    keyShape: keyShape
                )
            }
            .dropDestination(for: DragClass.self) { items, location in
                withAnimation {
                    guard let item = items.first else { return false }
                    if let custom = item.customizeKey_from {
                        fromDetail.applyCustom(custom)
                        print("customizeKey dropped!")
                        return true
                    }
                    return true
                }
            }
            .onTapGesture(
                count: 2,
                perform: {
                    print("double clicked")
                    indicator = true
                    viewModel.keyboardMonitor.startMonitoring_FromDetail(
                        configuration: $viewModel.configuration,
                        isGoingToRepeat: false
                    )
                }
            )
            .frame(width: keyShape.frameSize(keyMetrics).width, height: keyShape.frameSize(keyMetrics).height)
            .animation(.easeInOut, value: keyMetrics.unitSize)
    }
}


