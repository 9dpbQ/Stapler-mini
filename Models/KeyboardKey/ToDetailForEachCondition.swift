//
//  ToDetailForEachCondition.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ToDetailForEachCondition: ObservableObject, Codable {
    var condition0: ToDetailForEachLayer
    var condition1: ToDetailForEachLayer
    var condition2: ToDetailForEachLayer
    var condition3: ToDetailForEachLayer
    var condition4: ToDetailForEachLayer
    var condition5: ToDetailForEachLayer
    var condition6: ToDetailForEachLayer
    var condition7: ToDetailForEachLayer
    var condition8: ToDetailForEachLayer
    var condition9: ToDetailForEachLayer
    
    init(
        condition0: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition1: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition2: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition3: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition4: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition5: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition6: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition7: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition8: ToDetailForEachLayer = ToDetailForEachLayer(),
        condition9: ToDetailForEachLayer = ToDetailForEachLayer()
    ) {
        self.condition0 = condition0
        self.condition1 = condition1
        self.condition2 = condition2
        self.condition3 = condition3
        self.condition4 = condition4
        self.condition5 = condition5
        self.condition6 = condition6
        self.condition7 = condition7
        self.condition8 = condition8
        self.condition9 = condition9
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.condition0 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition0) ?? ToDetailForEachLayer()
        self.condition1 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition1) ?? ToDetailForEachLayer()
        self.condition2 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition2) ?? ToDetailForEachLayer()
        self.condition3 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition3) ?? ToDetailForEachLayer()
        self.condition4 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition4) ?? ToDetailForEachLayer()
        self.condition5 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition5) ?? ToDetailForEachLayer()
        self.condition6 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition6) ?? ToDetailForEachLayer()
        self.condition7 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition7) ?? ToDetailForEachLayer()
        self.condition8 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition8) ?? ToDetailForEachLayer()
        self.condition9 = try container.decodeIfPresent(ToDetailForEachLayer.self, forKey: .condition9) ?? ToDetailForEachLayer()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if condition0.isAnyLayerCustomized {
            try container.encode(condition0, forKey: .condition0)
        }
        if condition1.isAnyLayerCustomized {
            try container.encode(condition1, forKey: .condition1)
        }
        if condition2.isAnyLayerCustomized {
            try container.encode(condition2, forKey: .condition2)
        }
        if condition3.isAnyLayerCustomized {
            try container.encode(condition3, forKey: .condition3)
        }
        if condition4.isAnyLayerCustomized {
            try container.encode(condition4, forKey: .condition4)
        }
        if condition5.isAnyLayerCustomized {
            try container.encode(condition5, forKey: .condition5)
        }
        if condition6.isAnyLayerCustomized {
            try container.encode(condition6, forKey: .condition6)
        }
        if condition7.isAnyLayerCustomized {
            try container.encode(condition7, forKey: .condition7)
        }
        if condition8.isAnyLayerCustomized {
            try container.encode(condition8, forKey: .condition8)
        }
        if condition9.isAnyLayerCustomized {
            try container.encode(condition9, forKey: .condition9)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case condition0
        case condition1
        case condition2
        case condition3
        case condition4
        case condition5
        case condition6
        case condition7
        case condition8
        case condition9
    }
}
