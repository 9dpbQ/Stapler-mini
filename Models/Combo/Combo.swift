//
//  Combo.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class Combo: Identifiable, ObservableObject, Codable {
    var id: UUID
    var simultaneouses: [CustomUUID]
    var isThresholdEnabled: Bool
    var comboThreshold: Double
    var toDetail: ToDetail
    var indicator: Bool
    
    var detect_key_down_uninterruptedly: Bool // 他のキーが途中で押されてもコンボとして成立するのか: true, false
    var key_down_order: OrderType // 押される順番を厳密に扱うか？: strict, strict_inverse, insensitive
    var key_up_order: OrderType // Upの順番を厳密に扱うか？: strict, strict_inverse, insensitive
    var key_up_when_all_keys_up: Bool // 全てのキーが離されたらKeyupイベントを発火する？:　any, all
//    var to_after_key_up: Bool // Array Eventを発火するらしい。このアプリでは不採用で良いのでは
    
    
    @Relationship(deleteRule: .nullify)
    var array: ComboArray?
    
    init(toDetail: ToDetail = ToDetail()) {
        self.id = UUID()
        self.simultaneouses = [CustomUUID]()
        self.isThresholdEnabled = false
        self.comboThreshold = 50.0
        self.toDetail = toDetail
        self.indicator = false
        
        self.detect_key_down_uninterruptedly = false
        self.key_down_order = .insensitive
        self.key_up_order = .insensitive
        self.key_up_when_all_keys_up = false
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        
        self.simultaneouses = try container.decodeIfPresent([CustomUUID].self, forKey: .simultaneouses) ?? []
        self.isThresholdEnabled = try container.decodeIfPresent(Bool.self, forKey: .isThresholdEnabled) ?? false
        self.comboThreshold = try container.decodeIfPresent(Double.self, forKey: .comboThreshold) ?? 50.0
        self.toDetail = try container.decode(ToDetail.self, forKey: .toDetail)
        self.indicator = false
        
        self.detect_key_down_uninterruptedly = try container.decodeIfPresent(Bool.self, forKey: .detect_key_down_uninterruptedly) ?? false
        self.key_down_order = try container.decodeIfPresent(OrderType.self, forKey: .key_down_order) ?? .insensitive
        self.key_up_order = try container.decodeIfPresent(OrderType.self, forKey: .key_up_order) ?? .insensitive
        self.key_up_when_all_keys_up = try container.decodeIfPresent(Bool.self, forKey: .key_up_when_all_keys_up) ?? false
    }
    static let initialCombo = Combo()
}

extension Combo {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        if !simultaneouses.isEmpty { try container.encode(simultaneouses, forKey: .simultaneouses) }
        if isThresholdEnabled { try container.encode(isThresholdEnabled, forKey: .isThresholdEnabled) }
        if comboThreshold == 50.0 { try container.encode(comboThreshold, forKey: .comboThreshold) }
        try container.encode(toDetail, forKey: .toDetail)
        
        if detect_key_down_uninterruptedly { try container.encode(detect_key_down_uninterruptedly, forKey: .detect_key_down_uninterruptedly) }
        if key_down_order == .insensitive { try container.encode(key_down_order, forKey: .key_down_order) }
        if key_up_order == .insensitive { try container.encode(key_up_order, forKey: .key_up_order) }
        if key_up_when_all_keys_up { try container.encode(key_up_when_all_keys_up, forKey: .key_up_when_all_keys_up) }
    }
    enum CodingKeys: String, CodingKey {
        case id, simultaneouses, isThresholdEnabled, comboThreshold, toDetail, indicator
        case detect_key_down_uninterruptedly
        case key_down_order, key_up_order, key_up_when_all_keys_up
    }
   
}
