//
//  ConditionDetail.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ConditionDetail: Identifiable, ObservableObject, Codable {
    var name: String
    var type: ConditionType
    var value: String
    // var variableName: String //TODO: VariableIfもTypeに追加してより柔軟なConditionに
    var isEnabled: Bool
    init(specificCondition: SpecificCondition) {
        self.name = specificCondition.displayName
        
        if specificCondition == .condition1 {
            self.type = .input_source
            self.value = "ja"
        } else {
            self.type = .appllication
            self.value = "com.vendor.\(specificCondition.rawValue)"
        }
        
        if specificCondition == .condition0 {
            self.isEnabled = true
        } else {
            self.isEnabled = false
        }
            
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(ConditionType.self, forKey: .type)
        self.value = try container.decode(String.self, forKey: .value)
        self.isEnabled = try container.decode(Bool.self, forKey: .isEnabled)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
        try container.encode(isEnabled, forKey: .isEnabled)
    }
    enum CodingKeys: String, CodingKey {
        case name, type, value, isEnabled
    }
}
