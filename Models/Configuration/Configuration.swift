//
//  Model.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/07.
//

import SwiftUI
import SwiftData

@Model
final class Configuration: Identifiable, ObservableObject, Codable {
    var id: UUID
    var name: String
    var conditionDetailCollection: ConditionDetailCollection
    var displayKeySize: CGFloat//表示するキーボードキーのサイズ
    var selections: Selections
    
    //  具体的なカスタムの内容
    var keymap: Keymap  //DeviceDetail,SectionとそのkeyboardKeyの配列、keyboardKeyの中には各レイヤー、アプリごとの書き換え
    var comboCollection: ComboForEachCondition  //各アプリ・レイヤーごとのコンボ書き換え配列
    var macroCollection: MacroCollection //PresetごとにMacroCollectionを持つ
    
    init(name: String, keymap: Keymap = Keymap()) {
        self.id = UUID()
        self.name = name
        self.conditionDetailCollection = ConditionDetailCollection()
        self.displayKeySize = 65.0
        self.selections = Selections()

        self.keymap = keymap
        self.comboCollection = ComboForEachCondition()
        self.macroCollection = MacroCollection()
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID() // UUIDは新規で生成して、重複を防ぐ
        self.name = try container.decode(String.self, forKey: .name)

        self.conditionDetailCollection = try container.decode(ConditionDetailCollection.self, forKey: .conditionDetailCollection)
        self.displayKeySize = try container.decode(CGFloat.self, forKey: .displayKeySize)
        self.selections = try container.decode(Selections.self, forKey: .selections)
        
        self.keymap = try container.decode(Keymap.self, forKey: .keymap)
        self.comboCollection = try container.decode(ComboForEachCondition.self, forKey: .comboCollection)
        self.macroCollection = try container.decode(MacroCollection.self, forKey: .macroCollection)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
//        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(conditionDetailCollection, forKey: .conditionDetailCollection)
        try container.encode(displayKeySize, forKey: .displayKeySize)
        try container.encode(selections, forKey: .selections)
        
        try container.encode(keymap, forKey: .keymap)
        try container.encode(comboCollection, forKey: .comboCollection)
        try container.encode(macroCollection, forKey: .macroCollection)
    }
    enum CodingKeys: String, CodingKey {
        case id, name, conditionDetailCollection, displayKeySize, selections
        case keymap, comboCollection, macroCollection
    }
}

extension Configuration {//ビュー関連
    var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: self.displayKeySize)
    }
    
    var isKeyboardKeySelected: Bool {
        self.selections.keyboardKey != .initialKey
    }
    var selectedKeyboardkey: Binding<KeyboardKey> {
        Binding {
            self.selections.keyboardKey
        } set: { newValue in
            self.selections.keyboardKey = newValue
        }
    }
    
    var currentComboArray: Binding<[Combo]> {
        self.comboCollection.bindingForCondition(
            selectedCondition: self.selections.condition,
            selectedLayer: self.selections.layer
        )
    }
    var isComboSelected: Bool {
        self.selections.combo != .initialCombo
    }
    var selectedCombo: Binding<Combo> {
        Binding {
            self.selections.combo
        } set: { newValue in
            self.selections.combo = newValue
        }
    }
    
    var isMacroSelected: Bool {
        self.selections.macro != .initialMacro
    }
    var selectedMacro: Binding<Macro> {
        Binding {
            self.selections.macro
        } set: { newValue in
            self.selections.macro = newValue
        }
    }
    
    var isToDetail_macroSelected: Bool {
        self.selections.toDetail_macro != .initialToDetail_macro
    }
    var selectedToDetail_macro: Binding<ToDetail_macro> {
        Binding {
            self.selections.toDetail_macro
        } set: { newValue in
            self.selections.toDetail_macro = newValue
        }
    }

    static let initialConfig = Configuration(name: "wtf", keymap: Keymap())
}
