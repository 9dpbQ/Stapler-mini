//
//  SpecificCondition.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

enum SpecificCondition: String, CaseIterable, Codable {
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
    
    var displayName: String {
        switch self {
        case .condition0: "Default"
        case .condition1: "Condition1"
        case .condition2: "Condition2"
        case .condition3: "Condition3"
        case .condition4: "Condition4"
        case .condition5: "Condition5"
        case .condition6: "Condition6"
        case .condition7: "Condition7"
        case .condition8: "Condition8"
        case .condition9: "Condition9"
            
        }
    }
    func indexValue() -> Int {
        switch self {
        case .condition0: 0
        case .condition1: 1
        case .condition2: 2
        case .condition3: 3
        case .condition4: 4
        case .condition5: 5
        case .condition6: 6
        case .condition7: 7
        case .condition8: 8
        case .condition9: 9
        }
    }
    
    // 関数処理用の順序（1〜9、最後に0）
    static var processingOrder: [SpecificCondition] {
        [.condition1, .condition2, .condition3, .condition4,
         .condition5, .condition6, .condition7, .condition8,
         .condition9, .condition0]
    }
}
