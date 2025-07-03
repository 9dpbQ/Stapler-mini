//
//  Layer.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

enum Layer: String, CaseIterable, Codable{
    case layer0
    case layer1
    case layer2
    case layer3
    case layer4
    case layer5
    case layer6
    case layer7
    case layer8

    var displayName: String {
        switch self {
        case .layer0: return "Base"
        case .layer1: return "Layer 1"
        case .layer2: return "Layer 2"
        case .layer3: return "Layer 3"
        case .layer4: return "Layer 4"
        case .layer5: return "Layer 5"
        case .layer6: return "Layer 6"
        case .layer7: return "Layer 7"
        case .layer8: return "Layer 8"
        }
    }
    var accentColor: Color {
        switch self {
        case .layer0: return .white
        case .layer1: return .orange
        case .layer2: return .green
        case .layer3: return .purple
        case .layer4: return .blue
        case .layer5: return .yellow
        case .layer6: return .red
        case .layer7: return .cyan
        case .layer8: return .indigo
        }
    }
    var layerKeyColor: Color? {
        switch self {
        case .layer0: return nil
        case .layer1: return .orange
        case .layer2: return .green
        case .layer3: return .purple
        case .layer4: return .blue
        case .layer5: return .yellow
        case .layer6: return .red
        case .layer7: return .cyan
        case .layer8: return .indigo
        }
    }
    // 関数処理用の順序（1〜8、最後に0）
    static var processingOrder: [Layer] {
        [
            .layer1,
            .layer2,
            .layer3,
            .layer4,
            .layer5,
            .layer6,
            .layer7,
            .layer8,
            .layer0
        ]
    }
    
    func helpText() -> String {
        switch self {
        case .layer0:
            "Always modify the keycode."
        default:
            "Modify the keycode when the \(self.displayName) variable is true."
        }
    }
}
