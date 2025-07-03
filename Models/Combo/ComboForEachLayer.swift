//
//  ComboForEachLayer.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ComboForEachLayer: ObservableObject, Codable {
    var layer0: ComboArray
    var layer1: ComboArray
    var layer2: ComboArray
    var layer3: ComboArray
    var layer4: ComboArray
    var layer5: ComboArray
    var layer6: ComboArray
    var layer7: ComboArray
    var layer8: ComboArray
    
    init() {
        self.layer0 = ComboArray()
        self.layer1 = ComboArray()
        self.layer2 = ComboArray()
        self.layer3 = ComboArray()
        self.layer4 = ComboArray()
        self.layer5 = ComboArray()
        self.layer6 = ComboArray()
        self.layer7 = ComboArray()
        self.layer8 = ComboArray()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.layer0 = try container.decode(ComboArray.self, forKey: .layer0)
        self.layer1 = try container.decode(ComboArray.self, forKey: .layer1)
        self.layer2 = try container.decode(ComboArray.self, forKey: .layer2)
        self.layer3 = try container.decode(ComboArray.self, forKey: .layer3)
        self.layer4 = try container.decode(ComboArray.self, forKey: .layer4)
        self.layer5 = try container.decode(ComboArray.self, forKey: .layer5)
        self.layer6 = try container.decode(ComboArray.self, forKey: .layer6)
        self.layer7 = try container.decode(ComboArray.self, forKey: .layer7)
        self.layer8 = try container.decode(ComboArray.self, forKey: .layer8)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(layer0, forKey: .layer0)
        try container.encode(layer1, forKey: .layer1)
        try container.encode(layer2, forKey: .layer2)
        try container.encode(layer3, forKey: .layer3)
        try container.encode(layer4, forKey: .layer4)
        try container.encode(layer5, forKey: .layer5)
        try container.encode(layer6, forKey: .layer6)
        try container.encode(layer7, forKey: .layer7)
        try container.encode(layer8, forKey: .layer8)
    }
    
    enum CodingKeys: String, CodingKey {
        case layer0, layer1, layer2, layer3, layer4, layer5, layer6, layer7, layer8
    }
}
extension ComboForEachLayer {
    func bindingForLayer(_ layer: Layer) -> Binding<[Combo]> {
        switch layer {
        case .layer0: return layer0.bindingArray
        case .layer1: return layer1.bindingArray
        case .layer2: return layer2.bindingArray
        case .layer3: return layer3.bindingArray
        case .layer4: return layer4.bindingArray
        case .layer5: return layer5.bindingArray
        case .layer6: return layer6.bindingArray
        case .layer7: return layer7.bindingArray
        case .layer8: return layer8.bindingArray
        }
    }
    
}
