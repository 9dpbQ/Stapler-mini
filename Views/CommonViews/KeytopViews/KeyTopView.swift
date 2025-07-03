//
//  BackGroundViews.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2025/01/03.
//

import SwiftUI

struct KeyTopView: View {
    @EnvironmentObject private var viewModel: ViewModel

    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: unitSize, baseSizeX: displaySize ?? viewModel.configuration.displayKeySize)
    }
    let isSelected: Bool
    let hilightColor: Color
    let keyShape: KeyShape
    let unitSize: Double
    let displaySize: CGFloat?

    init(isSelected: Bool = false, hilightColor: Color = .white, keyShape: KeyShape = .square , unitSize: Double = 1, displaySize: CGFloat? = nil) {
        self.keyShape = keyShape
        self.isSelected = isSelected
        self.hilightColor = hilightColor
        self.unitSize = unitSize
        self.displaySize = displaySize
    }
    
    var body: some View {
        keyShape.keytopShape(keyMetrics)
            .fill(
                isSelected
                ? LinearGradient(
                    colors: [ Color(red: 80/255, green: 80/255, blue: 70/255), Color(red: 50/255, green: 50/255, blue: 70/255)],
                    startPoint: .top, endPoint: .bottom
                )
                : LinearGradient(
                    colors: [ Color(red: 51/255, green: 49/255, blue: 42/255), Color(red: 18/255, green: 18/255, blue: 38/255)],
                    startPoint: .top, endPoint: .bottom
                )
            )
            .frame(
                width: keyShape.keytopSize(keyMetrics).width,
                height: keyShape.keytopSize(keyMetrics).height
            )
            .shadow(color: isSelected ? hilightColor : hilightColor.opacity(0), radius: isSelected ? keyMetrics.padding_keytop : 0)
    }
    private var alignmentForKeyShape: Alignment {
        switch keyShape {
        case .arrow_Up:
            return .bottom
        case .arrow_Down:
            return .top
        default:
            return .center
        }
    }
}
