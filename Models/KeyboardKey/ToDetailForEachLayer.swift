//
//  ToDetailForEachLayer.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ToDetailForEachLayer: ObservableObject, Codable {
    var layer0: ToDetail
    var layer1: ToDetail
    var layer2: ToDetail
    var layer3: ToDetail
    var layer4: ToDetail
    var layer5: ToDetail
    var layer6: ToDetail
    var layer7: ToDetail
    var layer8: ToDetail
    
    init(
        layer0: ToDetail = ToDetail(),
        layer1: ToDetail = ToDetail(),
        layer2: ToDetail = ToDetail(),
        layer3: ToDetail = ToDetail(),
        layer4: ToDetail = ToDetail(),
        layer5: ToDetail = ToDetail(),
        layer6: ToDetail = ToDetail(),
        layer7: ToDetail = ToDetail(),
        layer8: ToDetail = ToDetail()
    ) {
        self.layer0 = layer0
        self.layer1 = layer1
        self.layer2 = layer2
        self.layer3 = layer3
        self.layer4 = layer4
        self.layer5 = layer5
        self.layer6 = layer6
        self.layer7 = layer7
        self.layer8 = layer8
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.layer0 = try container.decodeIfPresent(ToDetail.self, forKey: .layer0) ?? ToDetail()
        self.layer1 = try container.decodeIfPresent(ToDetail.self, forKey: .layer1) ?? ToDetail()
        self.layer2 = try container.decodeIfPresent(ToDetail.self, forKey: .layer2) ?? ToDetail()
        self.layer3 = try container.decodeIfPresent(ToDetail.self, forKey: .layer3) ?? ToDetail()
        self.layer4 = try container.decodeIfPresent(ToDetail.self, forKey: .layer4) ?? ToDetail()
        self.layer5 = try container.decodeIfPresent(ToDetail.self, forKey: .layer5) ?? ToDetail()
        self.layer6 = try container.decodeIfPresent(ToDetail.self, forKey: .layer6) ?? ToDetail()
        self.layer7 = try container.decodeIfPresent(ToDetail.self, forKey: .layer7) ?? ToDetail()
        self.layer8 = try container.decodeIfPresent(ToDetail.self, forKey: .layer8) ?? ToDetail()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if layer0.isTapOrHoldCustomized {
            // どっちもカスタマイズされていない場合、エンコードせず、デコード時に初期化する
            try container.encode(layer0, forKey: .layer0)
        }
        if layer1.isTapOrHoldCustomized {
            try container.encode(layer1, forKey: .layer1)
        }
        if layer2.isTapOrHoldCustomized {
            try container.encode(layer2, forKey: .layer2)
        }
        if layer3.isTapOrHoldCustomized {
            try container.encode(layer3, forKey: .layer3)
        }
        if layer4.isTapOrHoldCustomized {
            try container.encode(layer4, forKey: .layer4)
        }
        if layer5.isTapOrHoldCustomized {
            try container.encode(layer5, forKey: .layer5)
        }
        if layer6.isTapOrHoldCustomized {
            try container.encode(layer6, forKey: .layer6)
        }
        if layer7.isTapOrHoldCustomized {
            try container.encode(layer7, forKey: .layer7)
        }
        if layer8.isTapOrHoldCustomized {
            try container.encode(layer8, forKey: .layer8)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case layer0, layer1, layer2, layer3, layer4, layer5, layer6, layer7, layer8
    }
    
    // どれか一つでもカスタマイズされている場合、Trueを返す変数
    var isAnyLayerCustomized : Bool {
        layer0.isTapOrHoldCustomized
        || layer1.isTapOrHoldCustomized
        || layer2.isTapOrHoldCustomized
        || layer3.isTapOrHoldCustomized
        || layer4.isTapOrHoldCustomized
        || layer5.isTapOrHoldCustomized
        || layer6.isTapOrHoldCustomized
        || layer7.isTapOrHoldCustomized
        || layer8.isTapOrHoldCustomized
    }
}
