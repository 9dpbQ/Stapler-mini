//
//  KeyboardKey.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/07.
//
import SwiftData
import SwiftUI

@Model
final class KeyboardKey: Identifiable, ObservableObject, Codable {
    var id: UUID
    var unitSize: Double
    var keyShape: KeyShape
    var isSpacer: Bool
    var fromDetail: FromDetail
    var toDetailCollection: ToDetailForEachCondition
    var indicator: Bool
    
    @Relationship(deleteRule: .nullify)
    var row1: Rows?
    
    @Relationship(deleteRule: .nullify)
    var row2: Rows?
    
    @Relationship(deleteRule: .nullify)
    var row3: Rows?
    
    @Relationship(deleteRule: .nullify)
    var row4: Rows?
    
    @Relationship(deleteRule: .nullify)
    var row5: Rows?
    
    @Relationship(deleteRule: .nullify)
    var row6: Rows?
    
    init(
        output: FromKeycode,
        unitSize: Double = 1.0,
        keyShape: KeyShape = .square,
        isSpacer: Bool = false,
        region: KeycodeRegion = .ANSI
    ) {
        self.id = UUID()
        self.unitSize = unitSize
        self.keyShape = keyShape
        self.isSpacer = isSpacer
        self.fromDetail = FromDetail(output: output, region: region)
        self.toDetailCollection = ToDetailForEachCondition()
        self.indicator = false
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.unitSize = try container.decodeIfPresent(Double.self, forKey: .unitSize) ?? 1.0
        self.keyShape = try container.decodeIfPresent(KeyShape.self, forKey: .keyShape) ?? .square
        self.isSpacer = try container.decodeIfPresent(Bool.self, forKey: .isSpacer) ?? false
        self.fromDetail = try container.decode(FromDetail.self, forKey: .fromDetail)
        self.toDetailCollection = try container.decode(ToDetailForEachCondition.self, forKey: .toDetailCollection)
        self.indicator = false
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        
        if unitSize != 1.0 { try container.encode(unitSize, forKey: .unitSize) }
        if keyShape != .square { try container.encode(keyShape, forKey: .keyShape) }
        if isSpacer { try container.encode(isSpacer, forKey: .isSpacer) }
        try container.encode(fromDetail, forKey: .fromDetail)
        try container.encode(toDetailCollection, forKey: .toDetailCollection)
    }
    enum CodingKeys: String, CodingKey {
        case id, unitSize, keyShape, isSpacer, fromDetail, toDetailCollection, indicator
    }
}
extension KeyboardKey {
    static let initialKey = KeyboardKey(output: .letter_keys(.a))
   
    func getToDetail(_ condition: SpecificCondition, layer: Layer) -> ToDetail {
        var toDetailForEachLayer: ToDetailForEachLayer
        switch condition {
        case .condition0:
            toDetailForEachLayer = self.toDetailCollection.condition0
        case .condition1:
            toDetailForEachLayer = self.toDetailCollection.condition1
        case .condition2:
            toDetailForEachLayer = self.toDetailCollection.condition2
        case .condition3:
            toDetailForEachLayer = self.toDetailCollection.condition3
        case .condition4:
            toDetailForEachLayer = self.toDetailCollection.condition4
        case .condition5:
            toDetailForEachLayer = self.toDetailCollection.condition5
        case .condition6:
            toDetailForEachLayer = self.toDetailCollection.condition6
        case .condition7:
            toDetailForEachLayer = self.toDetailCollection.condition7
        case .condition8:
            toDetailForEachLayer = self.toDetailCollection.condition8
        case .condition9:
            toDetailForEachLayer = self.toDetailCollection.condition9
        }
        
        switch
        layer {
        case .layer0:
            return toDetailForEachLayer.layer0
        case .layer1:
            return toDetailForEachLayer.layer1
        case .layer2:
            return toDetailForEachLayer.layer2
        case .layer3:
            return toDetailForEachLayer.layer3
        case .layer4:
            return toDetailForEachLayer.layer4
        case .layer5:
            return toDetailForEachLayer.layer5
        case .layer6:
            return toDetailForEachLayer.layer6
        case .layer7:
            return toDetailForEachLayer.layer7
        case .layer8:
            return toDetailForEachLayer.layer8
        }
    }
    func getBindingToDetail(
        condition: SpecificCondition,
        layer: Layer
    ) -> Binding<ToDetail> {
        let conditionKeyPath: WritableKeyPath<ToDetailForEachCondition, ToDetailForEachLayer>
        switch condition {
        case .condition0: conditionKeyPath = \.condition0
        case .condition1: conditionKeyPath = \.condition1
        case .condition2: conditionKeyPath = \.condition2
        case .condition3: conditionKeyPath = \.condition3
        case .condition4: conditionKeyPath = \.condition4
        case .condition5: conditionKeyPath = \.condition5
        case .condition6: conditionKeyPath = \.condition6
        case .condition7: conditionKeyPath = \.condition7
        case .condition8: conditionKeyPath = \.condition8
        case .condition9: conditionKeyPath = \.condition9
        }
        
        let layerKeyPath: WritableKeyPath<ToDetailForEachLayer, ToDetail>
        switch layer {
        case .layer0: layerKeyPath = \.layer0
        case .layer1: layerKeyPath = \.layer1
        case .layer2: layerKeyPath = \.layer2
        case .layer3: layerKeyPath = \.layer3
        case .layer4: layerKeyPath = \.layer4
        case .layer5: layerKeyPath = \.layer5
        case .layer6: layerKeyPath = \.layer6
        case .layer7: layerKeyPath = \.layer7
        case .layer8: layerKeyPath = \.layer8
        }
        
        return Binding(
            get: {
                // 安全性を確保
                guard let toDetailCollection = self.toDetailCollection[keyPath: conditionKeyPath] as? ToDetailForEachLayer else {
                    fatalError("toDetailCollection is nil or invalid")
                }
                return toDetailCollection[keyPath: layerKeyPath]
            },
            set: { newValue in
                guard var toDetailCollection = self.toDetailCollection[keyPath: conditionKeyPath] as? ToDetailForEachLayer else {
                    fatalError("toDetailCollection is nil or invalid")
                }
                toDetailCollection[keyPath: layerKeyPath] = newValue
            }
        )
    }
    
    func resetAllCustom() {
        for condition in SpecificCondition.allCases {
            for layer in Layer.allCases {
                self.getBindingToDetail(condition: condition, layer: layer).wrappedValue.resetAll()
            }
        }
    }

}






