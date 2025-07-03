//
//  ToDetail.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ToDetail: Identifiable, ObservableObject, Codable {
    var id: UUID
    
    var isTapHoldEnabled: Bool
    var tapHoldType: TapHoldType
    
    //カスタム値を有効化するかどうか、有効じゃなければデフォルトをKarabinerからいじれるからそれで十分かな
    var is_held_down_threshold_enabled: Bool
    var to_if_held_down_threshold_milliseconds: Double
    
    var is_alone_timeout_enabled: Bool
    var to_if_alone_timeout_milliseconds: Double
        
    var is_lazy: Bool
    var is_repeat: Bool
    
    var isCustomized_tap: Bool
    var outputAndDisplay_tap: OutputAndDisplay
    var withModifier_tap: WithModifier
    var isMacro_tap: Bool
    var macro_id_tap: String // id か　StoredMacroの辞書鍵　が入る
    
    var isCustomized_hold: Bool
    var outputAndDisplay_hold: OutputAndDisplay
    var withModifier_hold: WithModifier
    var isMacro_hold: Bool
    var macro_id_hold: String
    
    var isMultiTapHoldEnabled: Bool
    var multiTapHoldCollection: MultiTapHoldCollection
    var isMultiTapThresholdEnabled: Bool
    var multiTapThreshold: Double
    
    var isUserCustomJSONEnabled: Bool
    var userJSONEContent: String
    
    var error: Bool
    
    var isTapOrHoldCustomized: Bool {
        isCustomized_tap || isCustomized_hold
    }
    
    init() {
        self.id = UUID()
        
        self.isTapHoldEnabled = false
        self.tapHoldType = .chord
        
        self.is_held_down_threshold_enabled = false
        self.to_if_held_down_threshold_milliseconds = 200.0
        
        self.is_alone_timeout_enabled = false
        self.to_if_alone_timeout_milliseconds = 1000.0
        
    
        self.is_lazy = false
        self.is_repeat = false
        
        self.isCustomized_tap = false
        self.outputAndDisplay_tap = OutputAndDisplay(output: .not_customized_key(.not_customized), display: "none")
        self.withModifier_tap = WithModifier()
        self.isMacro_tap = false
        self.macro_id_tap = Macro.initialMacro.id.uuidString
        
        self.isCustomized_hold = false
        self.outputAndDisplay_hold = OutputAndDisplay(output: .not_customized_key(.not_customized), display: "none")
        self.withModifier_hold = WithModifier()
        self.isMacro_hold = false
        self.macro_id_hold = Macro.initialMacro.id.uuidString
        
        self.isMultiTapHoldEnabled = false
        self.multiTapHoldCollection = MultiTapHoldCollection()
        self.isMultiTapThresholdEnabled = false
        self.multiTapThreshold = 500.0
        
        self.isUserCustomJSONEnabled = false
        self.userJSONEContent = "none"
        
        self.error = false
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.isTapHoldEnabled = try container.decodeIfPresent(Bool.self, forKey: .isTapHoldEnabled) ?? false
        self.tapHoldType = try container.decodeIfPresent(TapHoldType.self, forKey: .tapHoldType) ?? .chord
        
        self.is_held_down_threshold_enabled = try container.decodeIfPresent(Bool.self, forKey: .is_held_down_threshold_enabled) ?? false
        self.to_if_held_down_threshold_milliseconds = try container.decodeIfPresent(Double.self, forKey: .to_if_held_down_threshold_milliseconds) ?? 200
        
        self.is_alone_timeout_enabled = try container.decodeIfPresent(Bool.self, forKey: .is_alone_timeout_enabled) ?? false
        self.to_if_alone_timeout_milliseconds = try container.decodeIfPresent(Double.self, forKey: .to_if_alone_timeout_milliseconds) ?? 1000
        
        self.is_lazy = try container.decodeIfPresent(Bool.self, forKey: .is_lazy) ?? false
        self.is_repeat = try container.decodeIfPresent(Bool.self, forKey: .is_repeat) ?? false
        
        self.isCustomized_tap = try container.decodeIfPresent(Bool.self, forKey: .isCustomized_tap) ?? false
        self.outputAndDisplay_tap = try container.decodeIfPresent(OutputAndDisplay.self, forKey: .outputAndDisplay_tap) ?? OutputAndDisplay()
        self.withModifier_tap = try container.decodeIfPresent(WithModifier.self, forKey: .withModifier_tap) ?? WithModifier()
        self.isMacro_tap = try container.decodeIfPresent(Bool.self, forKey: .isMacro_tap) ?? false
        self.macro_id_tap = try container.decodeIfPresent(String.self, forKey: .macro_id_tap) ?? Macro.initialMacro.id.uuidString
        
        self.isCustomized_hold = try container.decodeIfPresent(Bool.self, forKey: .isCustomized_hold) ?? false
        self.outputAndDisplay_hold = try container.decodeIfPresent(OutputAndDisplay.self, forKey: .outputAndDisplay_hold) ?? OutputAndDisplay()
        self.withModifier_hold = try container.decodeIfPresent(WithModifier.self, forKey: .withModifier_hold) ?? WithModifier()
        self.isMacro_hold = try container.decodeIfPresent(Bool.self, forKey: .isMacro_hold) ?? false
        self.macro_id_hold = try container.decodeIfPresent(String.self, forKey: .macro_id_hold) ?? Macro.initialMacro.id.uuidString
        
        self.isMultiTapHoldEnabled = try container.decodeIfPresent(Bool.self, forKey: .isMultiTapHoldEnabled) ?? false
        self.multiTapHoldCollection = try container.decodeIfPresent(MultiTapHoldCollection.self, forKey: .multiTapHoldCollection) ?? MultiTapHoldCollection()
        self.isMultiTapThresholdEnabled = try container.decodeIfPresent(Bool.self, forKey: .isMultiTapThresholdEnabled) ?? false
        self.multiTapThreshold = try container.decodeIfPresent(Double.self, forKey: .multiTapThreshold) ?? 500
        
        self.isUserCustomJSONEnabled = try container.decodeIfPresent(Bool.self, forKey: .isUserCustomJSONEnabled) ?? false
        self.userJSONEContent = try container.decodeIfPresent(String.self, forKey: .userJSONContent) ?? "none"
        
        self.error = try container.decodeIfPresent(Bool.self, forKey: .error) ?? false
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
        
        if isTapHoldEnabled {
            try container.encode(isTapHoldEnabled, forKey: .isTapHoldEnabled)
            try container.encode(tapHoldType, forKey: .tapHoldType)
            
            if tapHoldType == .duration && is_lazy { try container.encode(is_lazy, forKey: .is_lazy) }
            if tapHoldType == .chord && is_repeat { try container.encode(is_repeat, forKey: .is_repeat) }
        }
        
        if is_held_down_threshold_enabled {
            try container.encode(is_held_down_threshold_enabled, forKey: .is_held_down_threshold_enabled)
            try container.encode(to_if_held_down_threshold_milliseconds, forKey: .to_if_held_down_threshold_milliseconds)
        }
        
        if is_alone_timeout_enabled {
            try container.encode(is_alone_timeout_enabled, forKey: .is_alone_timeout_enabled)
            try container.encode(to_if_alone_timeout_milliseconds, forKey: .to_if_alone_timeout_milliseconds)
        }
        
        if isCustomized_tap {
            try container.encode(isCustomized_tap, forKey: .isCustomized_tap)
            try container.encode(outputAndDisplay_tap, forKey: .outputAndDisplay_tap)
            try container.encode(withModifier_tap, forKey: .withModifier_tap)
            if isMacro_tap {
                try container.encode(isMacro_tap, forKey: .isMacro_tap)
                try container.encode(macro_id_tap, forKey: .macro_id_tap)
            }
        }
        
        if isCustomized_hold {
            try container.encode(isCustomized_hold, forKey: .isCustomized_hold)
            try container.encode(outputAndDisplay_hold, forKey: .outputAndDisplay_hold)
            try container.encode(withModifier_hold, forKey: .withModifier_hold)
            if isMacro_hold {
                try container.encode(isMacro_hold, forKey: .isMacro_hold)
                try container.encode(macro_id_hold, forKey: .macro_id_hold)
            }
        }
        
        if isMultiTapHoldEnabled {
            try container.encode(isMultiTapHoldEnabled, forKey: .isMultiTapHoldEnabled)
            try container.encode(multiTapHoldCollection, forKey: .multiTapHoldCollection)
            if isMultiTapThresholdEnabled {
                try container.encode(isMultiTapThresholdEnabled, forKey: .isMultiTapThresholdEnabled)
                try container.encode(multiTapThreshold, forKey: .multiTapThreshold)
            }
        }
        
        if isUserCustomJSONEnabled {
            try container.encode(isUserCustomJSONEnabled, forKey: .isUserCustomJSONEnabled)
            try container.encode(userJSONEContent, forKey: .userJSONContent)
        }
        
        if error {
            try container.encode(error, forKey: .error)
        }
    }
    enum CodingKeys: String, CodingKey {
        case id
        case isTapHoldEnabled, tapHoldType
        case is_held_down_threshold_enabled, to_if_held_down_threshold_milliseconds
        case is_alone_timeout_enabled, to_if_alone_timeout_milliseconds
        case is_lazy, is_repeat
        case isCustomized_tap, outputAndDisplay_tap, withModifier_tap, isMacro_tap, macro_id_tap
        case isCustomized_hold, outputAndDisplay_hold, withModifier_hold, isMacro_hold, macro_id_hold
        case isMultiTapHoldEnabled, multiTapHoldCollection, isMultiTapThresholdEnabled, multiTapThreshold
        case isUserCustomJSONEnabled, userJSONContent
        case error
    }
    static let initialDetail = ToDetail()
    
    func applyTap(_ outputAndDisplay: OutputAndDisplay, withModifier: WithModifier = WithModifier()) {
        self.isMacro_tap = false
        self.isCustomized_tap = true
        self.outputAndDisplay_tap.applyOutputDisplay(outputAndDisplay)
        self.withModifier_tap.applyWithModifier(withModifier)
    }
    func applyHold(_ outputAndDisplay: OutputAndDisplay, withModifier: WithModifier = WithModifier()) {
        self.isMacro_hold = false
        self.isCustomized_hold = true
        self.outputAndDisplay_hold.applyOutputDisplay(outputAndDisplay)
        self.withModifier_hold.applyWithModifier(withModifier)
    }
    func resetCustom(_ tapOrHold: TapOrHold) { // 片方のみをリセット
        switch tapOrHold {
        case .tap:
            self.isCustomized_tap = false
            self.outputAndDisplay_tap = OutputAndDisplay(output: .not_customized_key(.not_customized), display: "none")
            self.withModifier_tap = WithModifier()
            self.isMacro_tap = false
            self.macro_id_tap = Macro.initialMacro.id.uuidString
        case .hold:
            self.isCustomized_hold = false
            self.outputAndDisplay_hold = OutputAndDisplay(output: .not_customized_key(.not_customized), display: "none")
            self.withModifier_hold = WithModifier()
            self.isMacro_hold = false
            self.macro_id_hold = Macro.initialMacro.id.uuidString
        }
    }
    func resetAll() { // 全ての設定をリセット
        self.isTapHoldEnabled = false
        self.tapHoldType = .chord
        
        self.is_held_down_threshold_enabled = false
        self.to_if_held_down_threshold_milliseconds = 200.0
        
        self.is_alone_timeout_enabled = false
        self.to_if_alone_timeout_milliseconds = 1000.0
        
    
        self.is_lazy = false
        self.is_repeat = false
        
        self.isCustomized_tap = false
        self.outputAndDisplay_tap = OutputAndDisplay(output: .not_customized_key(.not_customized), display: "none")
        self.withModifier_tap = WithModifier()
        self.isMacro_tap = false
        self.macro_id_tap = Macro.initialMacro.id.uuidString
        
        self.isCustomized_hold = false
        self.outputAndDisplay_hold = OutputAndDisplay(output: .not_customized_key(.not_customized), display: "none")
        self.withModifier_hold = WithModifier()
        self.isMacro_hold = false
        self.macro_id_hold = Macro.initialMacro.id.uuidString
        
        self.isMultiTapHoldEnabled = false
        self.multiTapHoldCollection = MultiTapHoldCollection()
        self.isMultiTapThresholdEnabled = false
        self.multiTapThreshold = 500.0
        
        self.isUserCustomJSONEnabled = false
        self.userJSONEContent = "none"
        
        self.error = false
    }
}
