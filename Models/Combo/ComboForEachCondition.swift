//
//  ComboForEachCondition.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ComboForEachCondition: ObservableObject, Codable {
    var condition0: ComboForEachLayer
    var condition1: ComboForEachLayer
    var condition2: ComboForEachLayer
    var condition3: ComboForEachLayer
    var condition4: ComboForEachLayer
    var condition5: ComboForEachLayer
    var condition6: ComboForEachLayer
    var condition7: ComboForEachLayer
    var condition8: ComboForEachLayer
    var condition9: ComboForEachLayer
    init() {
        self.condition0 = ComboForEachLayer()
        self.condition1 = ComboForEachLayer()
        self.condition2 = ComboForEachLayer()
        self.condition3 = ComboForEachLayer()
        self.condition4 = ComboForEachLayer()
        self.condition5 = ComboForEachLayer()
        self.condition6 = ComboForEachLayer()
        self.condition7 = ComboForEachLayer()
        self.condition8 = ComboForEachLayer()
        self.condition9 = ComboForEachLayer()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.condition0 = try container.decode(ComboForEachLayer.self, forKey: .condition0)
        self.condition1 = try container.decode(ComboForEachLayer.self, forKey: .condition1)
        self.condition2 = try container.decode(ComboForEachLayer.self, forKey: .condition2)
        self.condition3 = try container.decode(ComboForEachLayer.self, forKey: .condition3)
        self.condition4 = try container.decode(ComboForEachLayer.self, forKey: .condition4)
        self.condition5 = try container.decode(ComboForEachLayer.self, forKey: .condition5)
        self.condition6 = try container.decode(ComboForEachLayer.self, forKey: .condition6)
        self.condition7 = try container.decode(ComboForEachLayer.self, forKey: .condition7)
        self.condition8 = try container.decode(ComboForEachLayer.self, forKey: .condition8)
        self.condition9 = try container.decode(ComboForEachLayer.self, forKey: .condition9)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(condition0, forKey: .condition0)
        try container.encode(condition1, forKey: .condition1)
        try container.encode(condition2, forKey: .condition2)
        try container.encode(condition3, forKey: .condition3)
        try container.encode(condition4, forKey: .condition4)
        try container.encode(condition5, forKey: .condition5)
        try container.encode(condition6, forKey: .condition6)
        try container.encode(condition7, forKey: .condition7)
        try container.encode(condition8, forKey: .condition8)
        try container.encode(condition9, forKey: .condition9)
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
    func getNextCombo(condition: SpecificCondition, layer: Layer, id: UUID) -> Combo? {
        getComboArray(condition: condition, layer: layer).array.first { $0.id == id}
    }
    
    func getComboArray(condition: SpecificCondition, layer: Layer) -> ComboArray {
        let comboForEachLayer: ComboForEachLayer
        
        switch condition {
        case .condition0:
            comboForEachLayer = self.condition0
        case .condition1:
            comboForEachLayer = self.condition1
        case .condition2:
            comboForEachLayer = self.condition2
        case .condition3:
            comboForEachLayer = self.condition3
        case .condition4:
            comboForEachLayer = self.condition4
        case .condition5:
            comboForEachLayer = self.condition5
        case .condition6:
            comboForEachLayer = self.condition6
        case .condition7:
            comboForEachLayer = self.condition7
        case .condition8:
            comboForEachLayer = self.condition8
        case .condition9:
            comboForEachLayer = self.condition9
        }
        
        switch layer {
        case .layer0:
            return comboForEachLayer.layer0
        case .layer1:
            return comboForEachLayer.layer1
        case .layer2:
            return comboForEachLayer.layer2
        case .layer3:
            return comboForEachLayer.layer3
        case .layer4:
            return comboForEachLayer.layer4
        case .layer5:
            return comboForEachLayer.layer5
        case .layer6:
            return comboForEachLayer.layer6
        case .layer7:
            return comboForEachLayer.layer7
        case .layer8:
            return comboForEachLayer.layer8
        }
    }
}
extension ComboForEachCondition {
    func bindingForCondition(selectedCondition: SpecificCondition, selectedLayer: Layer) -> Binding<[Combo]> {
        let condition = [
            condition0, condition1, condition2, condition3, condition4,
            condition5, condition6, condition7, condition8, condition9
        ]
        return condition[selectedCondition.indexValue()].bindingForLayer(selectedLayer)
    }
}
