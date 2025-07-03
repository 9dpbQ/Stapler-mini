//
//  ConditionDetailCollection.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ConditionDetailCollection: Identifiable, ObservableObject, Codable {
    var condition0: ConditionDetail
    var condition1: ConditionDetail
    var condition2: ConditionDetail
    var condition3: ConditionDetail
    var condition4: ConditionDetail
    var condition5: ConditionDetail
    var condition6: ConditionDetail
    var condition7: ConditionDetail
    var condition8: ConditionDetail
    var condition9: ConditionDetail
    init() {
        self.condition0 = ConditionDetail(specificCondition: .condition0)
        self.condition1 = ConditionDetail(specificCondition: .condition1)
        self.condition2 = ConditionDetail(specificCondition: .condition2)
        self.condition3 = ConditionDetail(specificCondition: .condition3)
        self.condition4 = ConditionDetail(specificCondition: .condition4)
        self.condition5 = ConditionDetail(specificCondition: .condition5)
        self.condition6 = ConditionDetail(specificCondition: .condition6)
        self.condition7 = ConditionDetail(specificCondition: .condition7)
        self.condition8 = ConditionDetail(specificCondition: .condition8)
        self.condition9 = ConditionDetail(specificCondition: .condition9)
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.condition0 = try container.decode(ConditionDetail.self, forKey: .condition0)
        self.condition1 = try container.decode(ConditionDetail.self, forKey: .condition1)
        self.condition2 = try container.decode(ConditionDetail.self, forKey: .condition2)
        self.condition3 = try container.decode(ConditionDetail.self, forKey: .condition3)
        self.condition4 = try container.decode(ConditionDetail.self, forKey: .condition4)
        self.condition5 = try container.decode(ConditionDetail.self, forKey: .condition5)
        self.condition6 = try container.decode(ConditionDetail.self, forKey: .condition6)
        self.condition7 = try container.decode(ConditionDetail.self, forKey: .condition7)
        self.condition8 = try container.decode(ConditionDetail.self, forKey: .condition8)
        self.condition9 = try container.decode(ConditionDetail.self, forKey: .condition9)
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
    
    func getConditionDetail(_ specon: SpecificCondition) -> ConditionDetail {
        switch specon {
        case .condition1:
            return self.condition1
        case .condition2:
            return self.condition2
        case .condition3:
            return self.condition3
        case .condition4:
            return self.condition4
        case .condition5:
            return self.condition5
        case .condition6:
            return self.condition6
        case .condition7:
            return self.condition7
        case .condition8:
            return self.condition8
        case .condition9:
            return self.condition9
        case .condition0:
            return self.condition0
            
        }
    }
}
