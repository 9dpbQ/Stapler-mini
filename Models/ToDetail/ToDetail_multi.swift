//
//  ToDetail 2.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ToDetail_multi: Identifiable, ObservableObject, Codable {
    var id: UUID
    var isCustomized_tap: Bool
    var outputAndDisplay_tap: OutputAndDisplay
    var withModifier_tap: WithModifier
    var isMacro_tap: Bool
    var macro_id_tap: String

    var isCustomized_hold: Bool
    var outputAndDisplay_hold: OutputAndDisplay
    var withModifier_hold: WithModifier
    var isMacro_hold: Bool
    var macro_id_hold: String
    
    @Relationship(deleteRule: .nullify)
    var array: MultiTapHoldCollection?
    
    init() {
        self.id = UUID()
        
        self.isCustomized_tap = false
        self.outputAndDisplay_tap = OutputAndDisplay()
        self.withModifier_tap = WithModifier()
        self.isMacro_tap = false
        self.macro_id_tap = Macro.initialMacro.id.uuidString

        self.isCustomized_hold = false
        self.outputAndDisplay_hold = OutputAndDisplay()
        self.withModifier_hold = WithModifier()
        self.isMacro_hold = false
        self.macro_id_hold = Macro.initialMacro.id.uuidString
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        
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
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id) // 配列の中に格納されるのでIDは変更せず、しても良いがそれ用の処理は必要になるはず
        
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
    }
    enum CodingKeys: String, CodingKey {
        case id
        case isCustomized_tap, outputAndDisplay_tap, withModifier_tap, isMacro_tap, macro_id_tap
        case isCustomized_hold, outputAndDisplay_hold, withModifier_hold, isMacro_hold, macro_id_hold
    }
    
    func applyTap(_ outputAndDisplay: OutputAndDisplay, withModifier: WithModifier = WithModifier()) {
        self.isCustomized_tap = true
        self.outputAndDisplay_tap.applyOutputDisplay(outputAndDisplay)
        self.withModifier_tap.applyWithModifier(withModifier)
    }
    func applyHold(_ outputAndDisplay: OutputAndDisplay, withModifier: WithModifier = WithModifier()) {
        self.isCustomized_hold = true
        self.outputAndDisplay_hold.applyOutputDisplay(outputAndDisplay)
        self.withModifier_hold.applyWithModifier(withModifier)
    }
    
    func resetCustom(_ tapOrHold: TapOrHold) {
        switch tapOrHold {
        case .tap:
            self.isCustomized_tap = false
            self.outputAndDisplay_tap = OutputAndDisplay()
            self.withModifier_tap = WithModifier()
            self.isMacro_tap = false
            self.macro_id_tap = Macro.initialMacro.id.uuidString
        case .hold:
            self.isCustomized_hold = false
            self.outputAndDisplay_hold = OutputAndDisplay()
            self.withModifier_hold = WithModifier()
            self.isMacro_hold = false
            self.macro_id_hold = Macro.initialMacro.id.uuidString
        }
    }
}
