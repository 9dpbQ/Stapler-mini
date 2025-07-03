//
//  Selections.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class Selections: ObservableObject, Codable {
    var layer: Layer
    var condition: SpecificCondition
    var tab: SelectedTab
    
    var keyboardKey: KeyboardKey
    var combo: Combo
    var macro: Macro
    var toDetail_macro: ToDetail_macro
    
    var customOrMacroTab: CustomOrMacroTab
    var fromTab: FromTab
    var toTab: ToTab
    var macroTab: MacroTab
    
    init() {
        self.layer = .layer0        // デフォルト値を設定
        self.condition = .condition0
        self.tab = .remap
        
        self.keyboardKey = .initialKey
        self.combo = .initialCombo
        self.macro = .initialMacro
        self.toDetail_macro = .initialToDetail_macro
        
        self.customOrMacroTab = .customizeKey
        self.fromTab = .qwertyKeyboard
        self.toTab = .qwertyKeyboard
        self.macroTab = .userMacro
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.layer = try container.decode(Layer.self, forKey: .layer)
        self.condition = try container.decode(SpecificCondition.self, forKey: .condition)
        self.tab = try container.decode(SelectedTab.self, forKey: .tab)
        
        self.keyboardKey = try container.decode(KeyboardKey.self, forKey: .keyboardKey)
        self.combo = try container.decode(Combo.self, forKey: .combo)
        self.macro = try container.decode(Macro.self, forKey: .macro)
        self.toDetail_macro = try container.decode(ToDetail_macro.self, forKey: .toDetail_macro)
        
        self.customOrMacroTab = try container.decode(CustomOrMacroTab.self, forKey: .customOrMacroTab)
        self.fromTab = try container.decode(FromTab.self, forKey: .fromTab)
        self.toTab = try container.decode(ToTab.self, forKey: .toTab)
        self.macroTab = try container.decode(MacroTab.self, forKey: .macroTab)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(layer, forKey: .layer)
        try container.encode(condition, forKey: .condition)
        try container.encode(tab, forKey: .tab)
        try container.encode(keyboardKey, forKey: .keyboardKey)
        try container.encode(combo, forKey: .combo)
        try container.encode(macro, forKey: .macro)
        try container.encode(toDetail_macro, forKey: .toDetail_macro)
        
        try container.encode(customOrMacroTab, forKey: .customOrMacroTab)
        try container.encode(fromTab, forKey: .fromTab)
        try container.encode(toTab, forKey: .toTab)
        try container.encode(macroTab, forKey: .macroTab)
    }
    enum CodingKeys: String, CodingKey {
        case layer
        case condition
        case tab
        case keyboardKey
        case combo
        case macro, toDetail_macro
        case customOrMacroTab, fromTab, toTab, macroTab
    }
}
