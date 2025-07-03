//
//  JSONExporter.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/11.
//

import SwiftUI
import Foundation

enum ExportError: Error {
    case invalidKeycodeList_from(fromDetail: FromDetail)
    case invalidKeycodeList_tap(toDetail: ToDetail)
    case invalidKeycodeList_hold(toDetail: ToDetail)
    case invalidKeycodeList_multiAction(oad: OutputAndDisplay)
    case invalidMicroAction(toDetail_macro: ToDetail_macro)
    case invalidMacroInMacroCollection
    case emptyMacroAction
    case invalidIDinKeymap
    case shortageOfSimultaneous
    //etc...
    case emptyPreset

    var localizedDescription: String {
        switch self {
        case .invalidKeycodeList_from(let fromDetail):
            return "The 'from' key does not exist in the key code list. Output: \(fromDetail.output), Display: \(fromDetail.display)"
            
        case .invalidKeycodeList_tap(let toDetail):
            return "A key used in the 'tap' action does not exist in the key code list. Output: \(toDetail.outputAndDisplay_tap.output), Display: \(toDetail.outputAndDisplay_tap.display)"
            
        case .invalidKeycodeList_hold(let toDetail):
            return "A key used in the 'hold' action does not exist in the key code list. Output: \(toDetail.outputAndDisplay_hold.output), Display: \(toDetail.outputAndDisplay_hold.display)"
            
        case .invalidKeycodeList_multiAction(let oad):
            return "A key used in the multi-action does not exist in the key code list. Output: \(oad.output), Display: \(oad.display)"
            
        case .invalidMicroAction(let toDetail_macro):
            return "A key used in the micro action does not exist in the key code list. Output: \(toDetail_macro.outputAndDisplay.output), Display: \(toDetail_macro.outputAndDisplay.display)"
            
        case .invalidMacroInMacroCollection:
            return "The assigned macro could not be found. It may have been deleted."
            
        case .emptyMacroAction:
            return "The assigned macro is empty and contains no actions."
            
        case .shortageOfSimultaneous:
            return "A combo must include at least two simultaneous key presses."
            
        case .invalidIDinKeymap:
            return "A key assigned to the combo could not be found on the keyboard."
            
        case .emptyPreset:
            return "This preset does not contain any customizations."
        }
    }

}

///　Presetを引数にとってKarabiner-Elementsで使えるJSONのテキストを返す関数群
struct JSONExporter {
    
    /// コンディションとレイヤーを指定の上でToDetail一つ分の書き換えを行う
    func singleModification_keyboardkey(
        fromDetail: FromDetail,
        toDetail: ToDetail,
        layer: Layer,
        condition: SpecificCondition,
        conditionDetail: ConditionDetail,
        deviceDetail: DeviceDetail,
        keycodeRegion: KeycodeRegion,
        macroCollection: MacroCollection,
        forUserCustomJSON: Bool = false // ビューでトグルで呼び出す時はtrueにする
    ) throws -> String? {
        if !forUserCustomJSON && toDetail.isUserCustomJSONEnabled {
            // UserCustomJSONが有効ならそれを返す
            // ビューでトグルで呼び出した時はここは実行されない
            return toDetail.userJSONEContent
        }
        
        //MARK: まずタップホールド両方がカスタマイズされていない場合nilを返す
        if (!toDetail.isCustomized_tap && !toDetail.isCustomized_hold) {
            print("タップホールド両方カスタマイズされていない")
            return nil
        }
        
        if !conditionDetail.isEnabled {//アプリが有効化されていない場合nilを返す
            print("アプリが有効化されていない")
            return nil
        }
        
        //MARK: conditionsのテキスト
        let conditions = con(
            deviceDetail: deviceDetail,
            layer: layer,
            condition: condition,
            conditionDetail: conditionDetail
        )
        
        var json: String?

        let fromKeycodeInfo: KeycodeInfo = fromDetail.output.keycodeInfo(keycodeRegion)

        
        
        let to_tap: String
        let to_hold: String
        let parameters: String?
        do {
            (to_tap, to_hold, parameters) = try toString_TapHoldParameters(toDetail: toDetail, macroCollection: macroCollection, keycodeRegion: keycodeRegion)
        } catch {
            throw error
        }
        
        //MARK: 次にタップホールドが有効かどうかで大きく処理を分ける
        
        if !toDetail.isTapHoldEnabled {
            
            //MARK: タップのみの処理
            
            if toDetail.isMultiTapHoldEnabled {
                do {
                    if let multiTapJson = try multiTap(
                        fromKeycodeInfo: fromKeycodeInfo,
                        toDetail: toDetail,
                        conditions: conditions,
                        keycodeRegion: keycodeRegion,
                        macroCollection: macroCollection
                    ) {
                        return multiTapJson
                    } else {
                        print("multi Action is enabled but there is no valid Modification")
                        //このまま普通のタップの処理を続ける
                    }
                } catch {
                    throw error
                }
            }
                json = """
                {
                                    "type": "basic", 
                                    "from": {"\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }},
                                    "conditions": [
                                        \(conditions ?? "")
                                    ],
                                    "to": [\(to_tap)]
                                }
                """
                return json
                        
        } else {
            //MARK: タップホールドの処理
            
            switch toDetail.tapHoldType {
            case .chord:
                //MARK: -タップホールドタイプで大きく処理を分ける .chord
                if !toDetail.is_repeat {
                    //通常のChordタイプの書き換え
                    
                    json = """
                    {
                                        "type": "basic",
                                        "from": {"\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }},
                                        "conditions": [
                                            \(conditions ?? "")
                                        ],
                                        "parameters": {
                                            \(parameters ?? "")
                                        },
                                        "to_if_alone": [
                                            \(to_tap)
                                        ],
                                        "to": [
                                            \(to_hold)
                                        ]
                                    }
                    """
                } else {
                    //Repeatの時
                    
                    json = """
                    {
                                        "type": "basic",
                                        "from": {"\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }},
                                        "conditions": [
                                            {"type": "variable_if","name": "repeat2_\(toDetail.id)","value": 1}\(conditions == nil ? "" : ",")
                                            \(conditions ?? "")
                                        ],
                                        "to": [
                                            {"set_variable": {"name": "repeat1_\(toDetail.id)","value": 1}},
                                            \(to_tap)
                                        ],
                                        "to_delayed_action": {
                                            "to_if_invoked": [
                                                {"set_variable": {"name": "repeat1_\(toDetail.id)","value": 0}}
                                            ],
                                            "to_if_canceled": [
                                                {"set_variable": {"name": "repeat1_\(toDetail.id)","value": 0}}
                                            ]
                                        }
                                    },
                                    {
                                        "type": "basic",
                                        "from": {"\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }},
                                        "conditions": [
                                            {"type": "variable_if","name": "repeat1_\(toDetail.id)","value": 1}\(conditions == nil ? "" : ",")
                                            \(conditions ?? "")
                                        ],
                                        "to": [
                                            {"set_variable": {"name": "repeat2_\(toDetail.id)","value": 1}},
                                            \(to_tap)
                                        ],
                                        "to_delayed_action": {
                                            "to_if_invoked": [
                                                {"set_variable": {"name": "repeat2_\(toDetail.id)","value": 0}}
                                            ],
                                            "to_if_canceled": [
                                                {"set_variable": {"name": "repeat2_\(toDetail.id)","value": 0}}
                                            ]
                                        }
                                    },
                                    {
                                        "type": "basic",
                                        "from": {"\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }},
                                        "conditions": [
                                            \(conditions ?? "")
                                        ],
                                        "parameters": {
                                            \(parameters ?? "")
                                        },
                                        "to_if_alone": [
                                            \(to_tap)
                                        ],
                                        "to": [
                                            {"set_variable": {"name": "repeat1_\(toDetail.id)","value": 1}},
                                            \(to_hold)
                                        ],
                                        "to_delayed_action": {
                                            "to_if_invoked": [
                                                {"set_variable": {"name": "repeat1_\(toDetail.id)","value": 0}}
                                            ],
                                            "to_if_canceled": [
                                                {"set_variable": {"name": "repeat1_\(toDetail.id)","value": 0}}
                                            ]
                                        }
                                    }
                    """
                }
                
            case .duration://MARK: -タップホールドタイプで大きく処理を分ける .duration
                
                if toDetail.isMultiTapHoldEnabled {
                    do {
                        if let multiTapHoldJson = try multiTapHold(
                            fromKeycodeInfo: fromKeycodeInfo,
                            toDetail: toDetail,
                            conditions: conditions,
                            keycodeRegion: keycodeRegion,
                            macroCollection: macroCollection
                        ) {
                            return multiTapHoldJson
                        } else {
                            print("multi Action is enabled but there is no valid Modification")
                            //このまま普通のタップの処理を続ける
                        }
                    } catch {
                        throw error
                    }
                }
                
                json = """
                {
                                    "type": "basic",
                                    "conditions": [
                                        \(conditions ?? "")
                                    ],
                                    "from": {"\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }},
                                    "parameters": {
                                        \(parameters ?? "")
                                    },
                                    "to_if_alone": [
                                        \(to_tap)
                                    ],
                                    "to_delayed_action": {
                                        "to_if_canceled": [\(to_tap)]
                                    },
                                    "to_if_held_down": [
                                        \(to_hold)
                                    ]
                                }
                """
            }
            return json
        }
    }
    
    //MARK: - ToDetail Specific Condition and its layers
    // Specific Condition一つ分の書き換えを行う
    func appAndItsLayers_keyboardKey(
        conditionDetail: ConditionDetail,
        condition: SpecificCondition,
        keymap: Keymap,
        macroCollection: MacroCollection,
        keycodeRegion: KeycodeRegion,
        deviceSections: DeviceSections,
        selections: Selections
    ) throws -> String? {
        if !conditionDetail.isEnabled {
            return nil
        }
        //layer1...8 → 0の順番
        var singleModArray = [String]()
        for layer in Layer.processingOrder {
            if deviceSections.containsSection(.other) {
                for keyboardKey in keymap.other.allKeyboardKeys_omittingSpacer() {
                    do {
                        if let singleMod = try singleModification_keyboardkey(
                            fromDetail: keyboardKey.fromDetail,
                            toDetail: keyboardKey.getToDetail(condition,layer: layer),
                            layer: layer,
                            condition: condition,
                            conditionDetail: conditionDetail,
                            deviceDetail: keymap.other.sectionDetail.deviceDetail,
                            keycodeRegion: keycodeRegion,
                            macroCollection: macroCollection
                        ) {
                            singleModArray.append(singleMod)
                        }
                    } catch {
                        selections.keyboardKey = keyboardKey
                        selections.layer = layer
                        selections.condition = condition
                        throw error
                    }
                }
            }
            if deviceSections.containsSection(.main) {
                for keyboardKey in keymap.main.allKeyboardKeys_omittingSpacer() {
                    do {
                        if let singleMod = try singleModification_keyboardkey(
                            fromDetail: keyboardKey.fromDetail,
                            toDetail: keyboardKey.getToDetail(condition,layer: layer),
                            layer: layer,
                            condition: condition,
                            conditionDetail: conditionDetail,
                            deviceDetail: keymap.main.sectionDetail.deviceDetail,
                            keycodeRegion: keycodeRegion,
                            macroCollection: macroCollection
                        ) {
                            singleModArray.append(singleMod)
                        }
                    } catch {
                        selections.keyboardKey = keyboardKey
                        selections.layer = layer
                        selections.condition = condition
                        throw error
                    }
                }
            }
            
            if deviceSections.containsSection(.mouse) {
                for keyboardKey in keymap.mouse.allKeyboardKeys_omittingSpacer() {
                    do {
                        if let singleMod = try singleModification_keyboardkey(
                            fromDetail: keyboardKey.fromDetail,
                            toDetail: keyboardKey.getToDetail(condition,layer: layer),
                            layer: layer,
                            condition: condition,
                            conditionDetail: conditionDetail,
                            deviceDetail: keymap.mouse.sectionDetail.deviceDetail,
                            keycodeRegion: keycodeRegion,
                            macroCollection: macroCollection
                        ) {
                            singleModArray.append(singleMod)
                        }
                    } catch {
                        selections.keyboardKey = keyboardKey
                        selections.layer = layer
                        selections.condition = condition
                        throw error
                    }
                }
            }
        }
        
        if singleModArray.isEmpty {//カスタマイズが何もない時はnilを返す
            print("return nil")
            return nil
        }
        
        let singleMods = singleModArray.joined(separator: ",\n                ")
        
        return singleMods
//
//        let description: String
//        if condition == .condition0 {
//            description = "Keymap Layer1...8 and Default"
//        } else {
//            description = "Keymap Layer1...8 and Default in \(conditionDetail.name)"
//        }
//        
//        let json = """
//            {
//                "description": "\(description)",
//                "manipulators": [
//                    \(singleMods)
//                ]
//            }
//        """
//        
//        return json
    }
    
    //MARK: - Combo
    //コンボ一つ分の書き換えを行う
    func singleModification_combo(
        combo: Combo,
        layer: Layer,
        condition: SpecificCondition,
        conditionDetail: ConditionDetail,
        keycodeRegion: KeycodeRegion,
        macroCollection: MacroCollection,
        keymap: Keymap,
        deviceSections: DeviceSections,
        forUserCustomJSON: Bool = false // ビューでトグルで呼び出す時はtrueにする
    ) throws -> String? {
        if !forUserCustomJSON && combo.toDetail.isUserCustomJSONEnabled {
            // UserCustomJSONが有効ならそれを返す
            // ビューでトグルで呼び出す際にはここは実行されない
            return combo.toDetail.userJSONEContent
        }
        
        //MARK: nilを返す条件
        //1.タップホールド両方がカスタマイズされてない時
        //2.アプリが有効化されてない時
        if (!combo.toDetail.isCustomized_tap && !combo.toDetail.isCustomized_hold) || !conditionDetail.isEnabled {
            return nil
        }
        let simultaneous_options = simultaneous_options(combo)
        let conditions = con_combo(simultaneouses: combo.simultaneouses, deviceSections: deviceSections, keymap: keymap, layer: layer, condition: condition, conditionDetail: conditionDetail)
        let simultaneous: String
        do {
            let simultan = try simul(simultaneouses: combo.simultaneouses, keymap: keymap, keycodeRegion: keycodeRegion, deviceSections: deviceSections)
            simultaneous = simultan
            
        } catch {
            combo.toDetail.error = true
            throw error
        }
        let json: String
        
        let to_tap: String
        let to_hold: String
        let parameters: String?
        do {
            (to_tap, to_hold, parameters) = try toString_TapHoldParameters(
                toDetail: combo.toDetail,
                macroCollection: macroCollection,
                keycodeRegion: keycodeRegion,
                comboThreshold: combo.isThresholdEnabled ? combo.comboThreshold : nil
            )
        } catch {
            throw error
        }

        if !combo.toDetail.isTapHoldEnabled {
            //MARK: タップのみの処理
            
            if combo.toDetail.isMultiTapHoldEnabled {
                do {
                    if let multiTapJSON = try multiTap_combo(
                        simultaneous: simultaneous,
                        combo: combo,
                        conditions: conditions,
                        keycodeRegion: keycodeRegion,
                        macroCollection: macroCollection
                    ) {
                        return multiTapJSON
                    } else {
                        print("multi Action is enabled but there is no valid Modification")
                        //このまま普通のタップの処理を続ける
                    }
                }
            }
            
            json = """
            {   
                                "type": "basic",
                                "conditions": [
                                    \(conditions)
                                ],
                                "parameters": {
                                    \(parameters ?? "")
                                },
                                "from": {
                                    "simultaneous_options": {
                                        \(simultaneous_options ?? "")
                                    },
                                    "simultaneous": [
                                        \(simultaneous)
                                    ],
                                    "modifiers": { "optional": ["any"] }
                                },
                                "to": [
                                    \(to_tap)
                                ]
                            }
            """
            
        } else {
            //MARK: タップホールドの処理
            
            //MARK: タップホールドタイプで大きく処理を分ける

            switch combo.toDetail.tapHoldType {
            case .chord:
                if !combo.toDetail.is_repeat {
                    //通常のchordタイプの書き換え
                    
                    json = """
                    {
                                        "type": "basic",
                                        "conditions": [
                                            \(conditions)
                                        ],
                                        "parameters": {
                                            \(parameters ?? "")
                                        },
                                        "from": {
                                            "simultaneous_options": {
                                                \(simultaneous_options ?? "")
                                            },
                                            "simultaneous": [
                                                \(simultaneous)
                                            ],
                                            "modifiers": { "optional": ["any"] }
                                        },
                                        "to_if_alone": [
                                            \(to_tap)
                                        ],
                                        "to": [
                                            \(to_hold)
                                        ]
                                    }
                    """
                } else {
                    //Repeatの時
                    
                    json = """
                    {
                                        "type": "basic",
                                        "from": {
                                            "simultaneous_options": {
                                                \(simultaneous_options ?? "")
                                            },
                                            "simultaneous": [
                                                \(simultaneous)
                                            ],
                                            "modifiers": { "optional": ["any"] }
                                        },
                                        "parameters": {
                                            \(parameters ?? "")
                                        },
                                        "conditions": [
                                            {"type": "variable_if","name": "repeat2_\(combo.toDetail.id)","value": 1}\(conditions == "" ? "": ",")
                                            \(conditions)
                                        ],
                                        "to": [
                                            {"set_variable": {"name": "repeat1_\(combo.toDetail.id)","value": 1}},
                                            \(to_tap)
                                        ],
                                        "to_delayed_action": {
                                            "to_if_invoked": [
                                                {"set_variable": {"name": "repeat1_\(combo.toDetail.id)","value": 0}}
                                            ],
                                            "to_if_canceled": [
                                                {"set_variable": {"name": "repeat1_\(combo.toDetail.id)","value": 0}}
                                            ]
                                        }
                                    },
                                    {
                                        "type": "basic",
                                        "from": {
                                            "simultaneous_options": {
                                                \(simultaneous_options ?? "")
                                            },
                                            "simultaneous": [
                                                \(simultaneous)
                                            ],
                                            "modifiers": { "optional": ["any"] }
                                        },
                                        "parameters": {
                                            \(parameters ?? "")
                                        },
                                        "conditions": [
                                            {"type": "variable_if","name": "repeat1_\(combo.toDetail.id)","value": 1}\(conditions == "" ? "": ",")
                                            \(conditions)
                                        ],
                                        "to": [
                                            {"set_variable": {"name": "repeat2_\(combo.toDetail.id)","value": 1}},
                                            \(to_tap)
                                        ],
                                        "to_delayed_action": {
                                            "to_if_invoked": [
                                                {"set_variable": {"name": "repeat2_\(combo.toDetail.id)","value": 0}}
                                            ],
                                            "to_if_canceled": [
                                                {"set_variable": {"name": "repeat2_\(combo.toDetail.id)","value": 0}}
                                            ]
                                        }
                                    },
                                    {
                                        "type": "basic",
                                        "from": {
                                            "simultaneous_options": {
                                                \(simultaneous_options ?? "")
                                            },
                                            "simultaneous": [
                                                \(simultaneous)
                                            ],
                                            "modifiers": { "optional": ["any"] }
                                        },
                                        "conditions": [
                                            \(conditions)
                                        ],
                                        "parameters": {
                                            \(parameters ?? "")
                                        },
                                        "to_if_alone": [
                                            \(to_tap)
                                        ],
                                        "to": [
                                            {"set_variable": {"name": "repeat1_\(combo.toDetail.id)","value": 1}},
                                            \(to_hold)
                                        ],
                                        "to_delayed_action": {
                                            "to_if_invoked": [
                                                {"set_variable": {"name": "repeat1_\(combo.toDetail.id)","value": 0}}
                                            ],
                                            "to_if_canceled": [
                                                {"set_variable": {"name": "repeat1_\(combo.toDetail.id)","value": 0}}
                                            ]
                                        }
                                    }
                    """
                }
                
            case .duration:
                
                if combo.toDetail.isMultiTapHoldEnabled {
                    do {
                        if let multiTapHoldJSON = try multiTapHold_combo(
                            simultaneous: simultaneous,
                            combo: combo,
                            conditions: conditions,
                            keycodeRegion: keycodeRegion,
                            macroCollection: macroCollection
                        ) {
                            return multiTapHoldJSON
                        } else {
                            print("multi Action is enabled but there is no valid Modification")
                            //このまま普通のタップの処理を続ける
                        }
                    }
                }
                json = """
                {
                                    "type": "basic",
                                    "conditions": [
                                        \(conditions)
                                    ],
                                    "from": {
                                        "simultaneous_options": {
                                            \(simultaneous_options ?? "")
                                        },
                                        "simultaneous": [
                                            \(simultaneous)
                                        ],
                                        "modifiers": { "optional": ["any"] }
                                    },
                                    "parameters": {
                                        \(parameters ?? "")
                                    },
                                    "to_if_alone": {
                                        \(to_tap)
                                    },
                                    "to_delayed_action": {
                                        "to_if_canceled": [\(to_tap)]
                                    },
                                    "to_if_held_down": {
                                        \(to_hold)
                                    }
                                }
                """
            }
        }
        return json
    }
    
    //MARK: - ComboCollection
    /// Specific Condition一つ分のComboの書き換え
    func appAndItsLayers_Combo(
        comboCollection: ComboForEachCondition,
        conditionDetail: ConditionDetail,
        condition: SpecificCondition,
        keymap: Keymap,
        macroCollection: MacroCollection,
        keycodeRegion: KeycodeRegion,
        deviceSections: DeviceSections,
        selections: Selections
    ) throws -> String? {
        var singleModArray = [String]()
        for layer in Layer.processingOrder {
            for combo in comboCollection.getComboArray(
                condition: condition,
                layer: layer
            ).array.sorted(
                by: { $0.simultaneouses.count > $1.simultaneouses.count }
            ) {
                do {
                    
                    if let singleMod = try singleModification_combo(
                        combo: combo,
                        layer: layer,
                        condition: condition,
                        conditionDetail: conditionDetail,
                        keycodeRegion: keycodeRegion,
                        macroCollection: macroCollection,
                        keymap: keymap,
                        deviceSections: deviceSections
                    ) {
                        print(singleMod)
                        singleModArray.append(singleMod)
                    }
                } catch {
                    combo.toDetail.error = true
                    selections.combo = combo
                    selections.layer = layer
                    selections.condition = condition
                    throw error
                }
            }
        }
        if singleModArray.isEmpty {
            return nil
        }
        
        let singleMods = singleModArray.joined(separator: ",\n                ")
        return singleMods
        
//        let description: String
//        if condition == .condition0 {
//            description = "Combo Layer1...8 and Default"
//        } else {
//            description = "Combo Layer1...8 and Default in \(conditionDetail.name)"
//        }
//        
//        let json = """
//                {
//                    "description": "\(description)",
//                    "manipulators": [
//                        \(singleMods)
//                    ]
//                }
//        """
//        
//        return json
    }

    
    //MARK: -
    /// 全てのアプリのKeyboardKey＆Comboの書き換え
    func keymapAndCombo_allApp(
        configuration: Configuration
    ) throws -> String {
        print("Start keymapAndCombo_allApp function")
        var appModArray = [String]()
        for speCon in SpecificCondition.processingOrder {
            print("now \(speCon.rawValue) in SpecificCondition.allCases")
            
            if configuration.conditionDetailCollection.getConditionDetail(speCon).isEnabled {
                do {
                    if let appMod_combo = try appAndItsLayers_Combo(
                        comboCollection: configuration.comboCollection,
                        conditionDetail: configuration.conditionDetailCollection.getConditionDetail(speCon),
                        condition: speCon,
                        keymap: configuration.keymap,
                        macroCollection: configuration.macroCollection,
                        keycodeRegion: configuration.keymap.keycodeRegion,
                        deviceSections: configuration.keymap.validSections,
                        selections: configuration.selections
                    ) {
                        appModArray.append(appMod_combo)
                    }
                } catch {
                    throw error
                }
                
                do {
                    if let appMod_keymap = try appAndItsLayers_keyboardKey(
                        conditionDetail: configuration.conditionDetailCollection.getConditionDetail(speCon),
                        condition: speCon,
                        keymap: configuration.keymap,
                        macroCollection: configuration.macroCollection,
                        keycodeRegion: configuration.keymap.keycodeRegion,
                        deviceSections: configuration.keymap.validSections,
                        selections: configuration.selections
                    ) {
                        appModArray.append(appMod_keymap)
                    }
                } catch {
                    throw error
                }
                
            }
        }
        
        if appModArray.isEmpty {
            throw ExportError.emptyPreset
        }
        
        let appMods = appModArray.joined(separator: ",\n\t\t\t\t")
        let title: String
        let date = Date()
        
        title = "\(date.toStringWithCurrentLocale())_\(configuration.name)"
        
        let description = "\(configuration.name)(\(configuration.keymap.deviceNames()))_(\(date.toStringWithCurrentLocale()))"
        let json = """
        {
            "title": "\(title)",
            "rules": [
                {
                    "description": "\(description)",
                    "manipulators": [
                        \(appMods)
                    ]
                }
            ]
        }
        """
        return json
    }
    
    //MARK: - 実際にjsonファイルとして出力する関数
    
    static func exportPresetAsJSON(
        _ configuration: Configuration,
        showingAlert: Binding<Bool>,
        alertMessage: Binding<String>
    ) {
        let exporter = JSONExporter()
        
        do {
            let json = try exporter.keymapAndCombo_allApp(configuration: configuration)
            let savePanel = NSSavePanel()
            savePanel.allowedContentTypes = [.json]
            savePanel.nameFieldStringValue = "\(configuration.name).json"

            savePanel.begin { result in
                if result == .OK {
                    guard let url = savePanel.url else {
                        showAlert(message: "保存先URLの取得に失敗しました。", showingAlert: showingAlert, alertMessage: alertMessage)
                        return
                    }
                    
                    do {
                        try json.write(to: url, atomically: true, encoding: .utf8)
                        print("JSONファイルが正常にエクスポートされました。")
                        
                        NSWorkspace.shared.activateFileViewerSelecting([url])//Finderで出力したファイルを開く
                        // 成功時にシェルスクリプトを実行
                        let process = Process()
                        process.launchPath = "/usr/bin/open"
                        process.arguments = ["karabiner://karabiner/assets/complex_modifications/import?url=file:\(url.path)"]
                        process.launch()
                    } catch {
                        showAlert(message: "JSONのエクスポート中にエラーが発生しました: \(error.localizedDescription)", showingAlert: showingAlert, alertMessage: alertMessage)
                    }
                }
            }

        } catch let error as ExportError {
            // ExportError の場合はrawValueを使ってエラーメッセージを表示
            showAlert(message: error.localizedDescription, showingAlert: showingAlert, alertMessage: alertMessage)

        } catch {
            // その他のエラーは localizedDescription を表示
            showAlert(message: "JSONのエクスポート中に不明なエラーが発生しました: \(error.localizedDescription)", showingAlert: showingAlert, alertMessage: alertMessage)
        }
        
    }
    private static func showAlert(message: String, showingAlert: Binding<Bool>, alertMessage: Binding<String>) {
        alertMessage.wrappedValue = message
        showingAlert.wrappedValue = true
    }
}

extension Date {

    func toStringWithCurrentLocale() -> String {

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return formatter.string(from: self)
    }

}

extension JSONExporter {
    
    private func multiTap(
        fromKeycodeInfo: KeycodeInfo,
        toDetail: ToDetail,
        // Conditionsに手を入れる必要があるので以下の情報も必要
        conditions: String?,
        keycodeRegion: KeycodeRegion,
        macroCollection: MacroCollection
    ) throws -> String? {
        //マルチの処理＿タップのみ
        
        //　まずは配列の中の有効なやつをカウントしてそこから何連打かを決めるかんじ
        
        var modifiCount: Int = 0
        for multiAction in toDetail.multiTapHoldCollection.collection {
            if multiAction.isCustomized_tap {
                modifiCount += 1//有効なものをカウント
            } else {
                continue//カスタマイズが無効なものはカウントしない
            }
        }
        //Fromの情報
        let from = """
        "\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }
        """
        
        let parameters = para(toDetail)
        
        var modifieArray = [String]()//ここに一つ分の書き換えが入る

        if modifiCount > 0 {
            //マルチタップ処理
            
            var indexCount: Int = modifiCount
            //配列に対して最後の要素から処理を行う
            for multiAction in toDetail.multiTapHoldCollection.collection.reversed() {
                //まずは有効なカスマイズがされているかの確認
                if !multiAction.isCustomized_tap {
                    //無効なら次
                    continue
                } else {
                    if indexCount == modifiCount {
                        // 最終連打目なら最後の処理
                        
                        let to_string: String
                        let parameters_multi: String?
                        do {
                            (to_string, _, parameters_multi) = try toString_TapHoldParameters_multi(
                                toDetail: toDetail,
                                toDetail_multi: multiAction,
                                macroCollection: macroCollection,
                                keycodeRegion: keycodeRegion,
                                indexCount_optional: nil
                            )
                        } catch {
                            throw error
                        }
                        
                        let json = """
                        {
                                            "type": "basic",
                                            "from": { \(from) },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }\(conditions == nil ? "" : ",")
                                                \(conditions ?? "")
                                            ],
                                            "parameters": {
                                                \(parameters_multi ?? "")
                                            },
                                            "to": [
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount)", "value": false } },
                                                \(to_string)
                                            ]                 
                                        }
                        """
                        modifieArray.append(json)
                        
                        indexCount -= 1
                        
                    } else {// 中間連打目
                        
                        let to_string: String
                        let parameters_multi: String?

                        do {
                            (to_string, _, parameters_multi) = try toString_TapHoldParameters_multi(
                                toDetail: toDetail,
                                toDetail_multi: multiAction,
                                macroCollection: macroCollection,
                                keycodeRegion: keycodeRegion,
                                indexCount_optional: indexCount + 1
                            )
                            
                        } catch {
                            throw error
                        }
                        
                        let json = """
                        {
                                            "type": "basic",
                                            "from": { \(from) },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }\(conditions == nil ? "" : ",")
                                                \(conditions ?? "")
                                            ],
                                            "parameters": {
                                                \(parameters_multi ?? "")
                                            },
                                        "to": [
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount)", "value": false } },
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": true } }
                                            ],
                                            "to_delayed_action": {
                                                "to_if_invoked": [
                                                    \(to_string),
                                                    { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ],
                                                "to_if_canceled": [
                                                    \(to_string),
                                                    { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ]
                                            }
                                        }
                        """
                        modifieArray.append(json)
                        
                        indexCount -= 1
                        
                    }
                }
            }
            
            
        } else {
            //有効なマルチタップがカスタマイズされていないので従来の書き換え関数へ行く
            return nil
        }
        
        // 1打目の情報
        
        
        
        let to_string: String
        
        if toDetail.isMacro_tap {
            do {
                to_string = try getMicroActions_multi(macroCollection, uuid_or_key: toDetail.macro_id_tap, keycodeRegion: keycodeRegion, toDetail_id: toDetail.id, indexCount: 1)
            } catch {
                throw error
            }
        } else {
            var toArray = [String]()//keycode, modifierなどが入る
            
            let toKeycodeInfo: KeycodeInfo
            do {
                (toKeycodeInfo, _) = try getKeycodeInfo_TapHold(toDetail: toDetail, keycodeRegion: keycodeRegion)
            } catch {
                toDetail.error = true
                throw error
            }
            
            let toKeycode: String = functionTypeAndKeycode(toKeycodeInfo: toKeycodeInfo)
            
            toArray.append(toKeycode)
            
            if let modifiers: String = modi(KeycodeInfo: toKeycodeInfo, withModifier: toDetail.withModifier_tap) {
                toArray.append(modifiers)
            }
            
            let multiTapCondition = """
            "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_1", "value": true }]
            """
            toArray.append(multiTapCondition)
            
            to_string = "{\(toArray.joined(separator: ", "))}"
        }
        
        
        
        let firstMod = """
        {
                            "type": "basic",
                            "from": {
                                \(from)
                            },
                            "conditions": [
                                \(conditions ?? "")
                            ],
                            "parameters": {
                                \(parameters ?? "")
                            },
                            "to": [{ "set_variable": { "name": "\(toDetail.id)_1", "value": true } }],
                            "to_delayed_action": {
                                "to_if_invoked": [
                                    \(to_string),
                                    { "set_variable": { "name": "\(toDetail.id)_1", "value": false } }
                                ],
                                "to_if_canceled": [
                                    \(to_string),
                                    { "set_variable": { "name": "\(toDetail.id)_1", "value": false } }
                                ]
                            }
                        }
        """
        modifieArray.append(firstMod)
        let json = modifieArray.joined(separator: ",\n\t\t\t\t")
        
        return json
    }
    
    private func multiTapHold(
        fromKeycodeInfo: KeycodeInfo,
        toDetail: ToDetail,
        // Conditionsに手を入れる必要があるので以下の情報も必要
        conditions: String?,
        keycodeRegion: KeycodeRegion,
        macroCollection: MacroCollection
    ) throws -> String? {
        //マルチの処理＿TapHold version
        //　まずは配列の中の有効なやつをカウントしてそこから何連打かを決めるかんじ
        
        var modifiCount: Int = 0
        for multiAction in toDetail.multiTapHoldCollection.collection {
            if (multiAction.isCustomized_tap || multiAction.isCustomized_hold) {
                //TapかHoldがカスタマイズされていればカウント
                modifiCount += 1
            } else {
                continue//カスタマイズが無効なものはカウントしない
            }
        }
        //Fromの情報
        let from = """
        "\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)", "modifiers": { "optional": ["any"] }
        """
        
        
        var modifieArray = [String]()//ここに一つ分の書き換えが入る

        if modifiCount > 0 {
            //マルチタップホールド処理
            
            var indexCount: Int = modifiCount
            //配列に対して最後の要素から処理を行う
            for multiAction in toDetail.multiTapHoldCollection.collection.reversed() {
                //まずは有効なカスマイズがされているかの確認
                if !(multiAction.isCustomized_tap || multiAction.isCustomized_hold) {
                    //tapかHoldがカスタマイズされていればカウント
                    //無効なら次
                    continue
                } else {
                    let to_string_tap: String
                    let to_string_hold: String
                    let parameters: String?
                    do {
                        (to_string_tap, to_string_hold, parameters) = try toString_TapHoldParameters_multi(
                            toDetail: toDetail,
                            toDetail_multi: multiAction,
                            macroCollection: macroCollection,
                            keycodeRegion: keycodeRegion,
                            indexCount_optional: indexCount + 1
                        )
                    } catch {
                        throw error
                    }
                    
                    if indexCount == modifiCount {
                        // 最終連打目の情報
                                                
                        let json = """
                        {
                                            "type": "basic",
                                            "from": { \(from) },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }\(conditions == nil ? "" : ",")
                                                \(conditions ?? "")
                                            ],
                                            "parameters": {
                                                \(parameters ?? "")
                                            },
                                            "to": [
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount)", "value": false } },
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": true } }
                                            ],
                                            "to_if_held_down": [
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } },
                                                \(to_string_hold)
                                            ],
                                            "to_delayed_action": {
                                                "to_if_invoked": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ],
                                                "to_if_canceled": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ]
                                            }
                                        }
                        """
                        modifieArray.append(json)
                        
                        indexCount -= 1
                        
                    } else { // 中間連打目の処理
                        
                        let json = """
                        {
                                            "type": "basic",
                                            "from": { \(from) },
                                            "parameters": {
                                                \(parameters ?? "")
                                            },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }\(conditions == nil ? "" : ",")
                                                \(conditions ?? "")
                                            ],
                                        "to": [
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount)", "value": false } },
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": true } }
                                            ],
                                            "to_if_held_down": [
                                                { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } },
                                                \(to_string_hold)
                                            ],
                                            "to_delayed_action": {
                                                "to_if_invoked": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ],
                                                "to_if_canceled": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ]
                                            }
                                        }
                        """
                        modifieArray.append(json)
                        
                        indexCount -= 1
                        
                    }
                }
            }
        } else {
            return nil
        }
        
        let to_string_tap: String
        let to_string_hold: String
        let parameters: String?
        do {
            (to_string_tap, to_string_hold, parameters) = try toString_TapHoldParameters(
                toDetail: toDetail,
                macroCollection: macroCollection,
                keycodeRegion: keycodeRegion,
                indexCount_optional: 1
            )
        } catch {
            throw error
        }
        
        
        let firstMod = """
        {
                            "type": "basic",
                            "from": { \(from) },
                            "parameters": {
                                \(parameters ?? "")
                            },
                            "conditions": [
                                \(conditions ?? "")
                            ],
                            "to": [{ "set_variable": { "name": "\(toDetail.id)_1", "value": true } }],
                            "to_if_held_down": [
                                { "set_variable": { "name": "\(toDetail.id)_1", "value": false } },
                                \(to_string_hold)
                            ],
                            "to_delayed_action": {
                                "to_if_invoked": [
                                    \(to_string_tap),
                                    { "set_variable": { "name": "\(toDetail.id)_1", "value": false } }
                                ],
                                "to_if_canceled": [
                                    \(to_string_tap),
                                    { "set_variable": { "name": "\(toDetail.id)_1", "value": false } }
                                ]
                            }
                        }
        """
        modifieArray.append(firstMod)
        let json = modifieArray.joined(separator: ",\n\t\t\t\t")
        
        return json
    }
    
    private func multiTap_combo(
        simultaneous: String,
        combo: Combo,
        // Conditionsに手を入れる必要があるので以下の情報も必要
        conditions: String,
        keycodeRegion: KeycodeRegion,
        macroCollection: MacroCollection
    ) throws -> String? {
        //　まずは配列の中の有効なやつをカウントしてそこから何連打かを決めるかんじ
        
        var modifiCount: Int = 0
        for multiAction in combo.toDetail.multiTapHoldCollection.collection {
            if multiAction.isCustomized_tap {
                modifiCount += 1//有効なものをカウント
            } else {
                continue//カスタマイズが無効なものはカウントしない
            }
        }
        let simultaneous_options = simultaneous_options(combo)
        var modifieArray = [String]()//ここに一つ分の書き換えが入る

        if modifiCount > 0 {
            //マルチタップ処理
            
            var indexCount: Int = modifiCount
            //配列に対して最後の要素から処理を行う
            for multiAction in combo.toDetail.multiTapHoldCollection.collection.reversed() {
                //まずは有効なカスマイズがされているかの確認
                if !multiAction.isCustomized_tap {
                    //無効なら次
                    continue
                } else {
                    if indexCount == modifiCount {
                        // 最終連打目なら最後の処理
                        let to_string: String
                        let parameters_multi: String?
                        do {
                            (to_string, _, parameters_multi) = try toString_TapHoldParameters_multi(
                                toDetail: combo.toDetail,
                                toDetail_multi: multiAction,
                                macroCollection: macroCollection,
                                keycodeRegion: keycodeRegion,
                                indexCount_optional: nil,
                                comboThreshold: combo.isThresholdEnabled ? combo.comboThreshold : nil
                            )
                        } catch {
                            throw error
                        }
                        
                        
                        let json = """
                        {
                                            "type": "basic",
                                            "from": {
                                                "simultaneous_options": { 
                                                    \(simultaneous_options ?? "")
                                                },
                                                "simultaneous": [
                                                    \(simultaneous)
                                                ],
                                                "modifiers": { "optional": ["any"] }
                                            },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(combo.toDetail.id)_\(indexCount)", "value": true }\(conditions == "" ? "" : ",")
                                                \(conditions)
                                            ],
                                            "parameters": {
                                                \(parameters_multi ?? "")
                                            },
                                            "to": [
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount)", "value": false } },
                                                \(to_string)
                                            ]                 
                                        }
                        """
                        modifieArray.append(json)
                        
                        indexCount -= 1
                        
                    } else {
                        
                        // そうじゃないなら中間の処理
                        let to_string: String
                        let parameters_multi: String?

                        do {
                            (to_string, _, parameters_multi) = try toString_TapHoldParameters_multi(
                                toDetail: combo.toDetail,
                                toDetail_multi: multiAction,
                                macroCollection: macroCollection,
                                keycodeRegion: keycodeRegion,
                                indexCount_optional: indexCount + 1,
                                comboThreshold: combo.isThresholdEnabled ? combo.comboThreshold : nil
                            )
                            
                        } catch {
                            throw error
                        }
                        
                        let json = """
                        {
                                            "type": "basic",
                                            "from": {
                                                "simultaneous_options": {
                                                    \(simultaneous_options ?? "")
                                                },
                                                "simultaneous": [
                                                    \(simultaneous)
                                                ],
                                                ,modifiers": { "optional": ["any"] }
                                            },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(combo.toDetail.id)_\(indexCount)", "value": true }\(conditions == "" ? "" : ",")
                                                \(conditions)
                                            ],
                                            "parameters": {
                                                \(parameters_multi ?? "")
                                            },
                                            "to": [
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount)", "value": false } },
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": true } }
                                            ],
                                            "to_delayed_action": {
                                                "to_if_invoked": [
                                                    \(to_string),
                                                    { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ],
                                                "to_if_canceled": [
                                                    \(to_string),
                                                    { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ]
                                            }
                                        }               
                        """
                        modifieArray.append(json)
                        indexCount -= 1
                    }
                }
            }
        } else {
            //有効なマルチタップがカスタマイズされていないので従来の書き換え関数へ行くようにしたいね
            return nil
        }
        
        // 1打目の情報
        let to_string: String
        let parameters: String?
        do {
            (to_string, _, parameters) = try toString_TapHoldParameters(
                toDetail: combo.toDetail,
                macroCollection: macroCollection,
                keycodeRegion: keycodeRegion,
                indexCount_optional: 1,
                comboThreshold: combo.isThresholdEnabled ? combo.comboThreshold : nil
            )
        } catch {
            throw error
        }
        
        let firstMod = """
        {
                            "type": "basic",
                            "from": {
                                "simultaneous_options": {   
                                    \(simultaneous_options ?? "")
                                },
                                "simultaneous": [
                                    \(simultaneous)
                                ],
                                "modifiers": { "optional": ["any"] }
                            },
                            "conditions": [
                                \(conditions)
                            ],
                            "parameters": {
                                \(parameters ?? "")
                            },
                            "to": [{ "set_variable": { "name": "\(combo.toDetail.id)_1", "value": true } }],
                            "to_delayed_action": {
                                "to_if_invoked": [
                                    \(to_string),
                                    { "set_variable": { "name": "\(combo.toDetail.id)_1", "value": false } }
                                ],
                                "to_if_canceled": [
                                    \(to_string),
                                    { "set_variable": { "name": "\(combo.toDetail.id)_1", "value": false } }
                                ]
                            }
                        }
        """
        modifieArray.append(firstMod)
        let json = modifieArray.joined(separator: ",\n\t\t\t\t")
        
        return json
    }
    
    private func multiTapHold_combo(
        simultaneous: String,
        combo: Combo,
        // Conditionsに手を入れる必要があるので以下の情報も必要
        conditions: String,
        keycodeRegion: KeycodeRegion,
        macroCollection: MacroCollection
    ) throws -> String? {
        //マルチの処理＿TapHold version
        //　まずは配列の中の有効なやつをカウントしてそこから何連打かを決めるかんじ
        
        var modifiCount: Int = 0
        for multiAction in combo.toDetail.multiTapHoldCollection.collection {
            if (multiAction.isCustomized_tap || multiAction.isCustomized_hold) {
                //TapかHoldがカスタマイズされていればカウント
                modifiCount += 1
            } else {
                continue//カスタマイズが無効なものはカウントしない
            }
        }
        let simultaneous_options = simultaneous_options(combo)
        var modifieArray = [String]()//ここに一つ分の書き換えが入る

        if modifiCount > 0 {
            //マルチタップホールド処理
            
            var indexCount: Int = modifiCount
            //配列に対して最後の要素から処理を行う
            for multiAction in combo.toDetail.multiTapHoldCollection.collection.reversed() {
                //まずは有効なカスマイズがされているかの確認
                if !(multiAction.isCustomized_tap || multiAction.isCustomized_hold) {
                    //tapかHoldがカスタマイズされていればカウント
                    //無効なら次
                    continue
                } else {
                   
                    if indexCount == modifiCount {
                        // 最終連打目の情報
                        let to_string_tap: String
                        let to_string_hold: String
                        let parameters: String?
                        do {
                            (to_string_tap, to_string_hold, parameters) = try toString_TapHoldParameters_multi(
                                toDetail: combo.toDetail,
                                toDetail_multi: multiAction,
                                macroCollection: macroCollection,
                                keycodeRegion: keycodeRegion,
                                indexCount_optional: indexCount + 1,
                                comboThreshold: combo.isThresholdEnabled ? combo.comboThreshold : nil
                            )
                        } catch {
                            throw error
                        }
                        
                        let json = """
                        {
                                            "type": "basic",
                                            "from": {
                                                "simultaneous_options": { 
                                                    \(simultaneous_options ?? "")
                                                },
                                                "simultaneous": [
                                                    \(simultaneous)
                                                ],
                                                "modifiers": { "optional": ["any"] }
                                            },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(combo.toDetail.id)_\(indexCount)", "value": true }\(conditions == "" ? "" : ",")
                                                \(conditions)
                                            ],
                                            "parameters": {
                                                \(parameters ?? "")
                                            },
                                            "to": [
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount)", "value": false } },
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": true } }
                                            ],
                                            "to_if_held_down": [
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } },
                                                \(to_string_hold)
                                            ],
                                            "to_delayed_action": {
                                                "to_if_invoked": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ],
                                                "to_if_canceled": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ]
                                            }
                                        }
                        """
                        modifieArray.append(json)
                        
                        indexCount -= 1
                        
                    } else {
                        
                        let to_string_tap: String
                        let to_string_hold: String
                        let parameters: String?
                        do {
                            (to_string_tap, to_string_hold, parameters) = try toString_TapHoldParameters_multi(
                                toDetail: combo.toDetail,
                                toDetail_multi: multiAction,
                                macroCollection: macroCollection,
                                keycodeRegion: keycodeRegion,
                                indexCount_optional: indexCount + 1,
                                comboThreshold: combo.isThresholdEnabled ? combo.comboThreshold : nil
                            )
                        } catch {
                            throw error
                        }
                        
                        let json = """
                        {
                                            "type": "basic",
                                            "from": {
                                                "simultaneous_options": {   
                                                    \(simultaneous_options ?? "")
                                                },
                                                "simultaneous": [
                                                    \(simultaneous)
                                                ],
                                                "modifiers": { "optional": ["any"] }
                                            },
                                            "parameters": {
                                                \(parameters ?? "")
                                            },
                                            "conditions": [
                                                { "type": "variable_if", "name": "\(combo.toDetail.id)_\(indexCount)", "value": true }\(conditions == "" ? "" : ",")
                                                \(conditions)
                                            ],
                                            "to": [
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount)", "value": false } },
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": true } }
                                            ],
                                            "to_if_held_down": [
                                                { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } },
                                                \(to_string_hold)
                                            ],
                                            "to_delayed_action": {
                                                "to_if_invoked": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ],
                                                "to_if_canceled": [
                                                    \(to_string_tap),
                                                    { "set_variable": { "name": "\(combo.toDetail.id)_\(indexCount + 1)", "value": false } }
                                                ]
                                            }
                                        }
                        """
                        modifieArray.append(json)
                        
                        indexCount -= 1
                        
                    }
                }
            }
        } else {
            return nil
        }
        
        let to_string_tap: String
        let to_string_hold: String
        let parameters: String?
        do {
            (to_string_tap, to_string_hold, parameters) = try toString_TapHoldParameters(
                toDetail: combo.toDetail,
                macroCollection: macroCollection,
                keycodeRegion: keycodeRegion,
                indexCount_optional: 1,
                comboThreshold: combo.isThresholdEnabled ? combo.comboThreshold : nil
            )
        } catch {
            throw error
        }
        
        let firstMod = """
        {
                            "type": "basic",
                            "from": {
                                "simultaneous_options": {   
                                    \(simultaneous_options ?? "")
                                },
                                "simultaneous": [
                                    \(simultaneous)
                                ],
                                "modifiers": { "optional": ["any"] }
                            },
                            "conditions": [
                                \(conditions)
                            ],
                            "parameters": {
                                \(parameters ?? "")
                            },
                            "to": [{ "set_variable": { "name": "\(combo.toDetail.id)_1", "value": true } }],
                            "to_if_held_down": [
                                { "set_variable": { "name": "\(combo.toDetail.id)_1)", "value": false } },
                                \(to_string_hold)
                            ],
                            "to_delayed_action": {
                                "to_if_invoked": [
                                    \(to_string_tap),
                                    { "set_variable": { "name": "\(combo.toDetail.id)_1", "value": false } }
                                ],
                                "to_if_canceled": [
                                    \(to_string_tap),
                                    { "set_variable": { "name": "\(combo.toDetail.id)_1", "value": false } }
                                ]
                            }
                        }
        """
        modifieArray.append(firstMod)
        let json = modifieArray.joined(separator: ",\n\t\t\t\t")
        
        return json
    }
    
    
    private func simul(
        simultaneouses: [CustomUUID],
        keymap: Keymap,
        keycodeRegion: KeycodeRegion,
        deviceSections: DeviceSections
    ) throws -> String {
        //{"pointing_button": "button1"},{"pointing_button": "button2"}
        //みたいなやつを返す
        if !(simultaneouses.count >= 2) {
            throw ExportError.shortageOfSimultaneous
        }
        
        print(simultaneouses.count)
        var simultaneousArray = [String]()
        
        for customUUID in simultaneouses {
            let fromDetail: FromDetail
            if let from = keymap.getFromDetail_omittingSpacer(by: customUUID.id) {
                fromDetail = from
            } else {
                throw ExportError.invalidIDinKeymap
            }
            let fromKeycodeInfo = fromDetail.output.keycodeInfo(keycodeRegion)
            
            simultaneousArray.append("""
            {"\(fromKeycodeInfo.functionType.rawValue)": "\(fromKeycodeInfo.keyCodeString)"}
            """
            )
        }
        
        
        let json: String = simultaneousArray.joined(separator: ",\n\t\t\t\t\t")
        
        return json
    }
    
   
    private func getKeycodeInfo(
        outputAndDisplay: OutputAndDisplay,
        keycodeRegion: KeycodeRegion,
        error: Error
    ) throws -> KeycodeInfo {
        
        guard let to: KeycodeInfo = outputAndDisplay.output.keycodeInfo(keycodeRegion) else {
            throw error
        }
        return to
    }
    
    func getKeycodeInfo_TapHold(
        toDetail: ToDetail,
        keycodeRegion: KeycodeRegion
    ) throws -> (toKeycodeInfo_tap: KeycodeInfo, toKeycodeInfo_hold: KeycodeInfo) {
        
        
        if !toDetail.isTapHoldEnabled {
            /////KeycodeListの確認
            ///タップホールドが無効なら
            ///ホールドにもタップの値を入れて返す
            
            let to_tap: KeycodeInfo
            
            if toDetail.isMacro_tap {
                to_tap = KeycodeInfo(keyCodeString: "this message should not exist in json")
            } else {
                guard let info = toDetail.outputAndDisplay_tap.output.keycodeInfo(keycodeRegion) else {
                    throw ExportError.invalidKeycodeList_tap(toDetail: toDetail)
                }
                to_tap = info
            }
            return (toKeycodeInfo_tap: to_tap, toKeycodeInfo_hold: to_tap)
        } else {
            /// タップホールドの処理
            ///両方カスタマイズされているなら
            ///両方を確認
            
            let to_tap: KeycodeInfo
            let to_hold: KeycodeInfo
            
            if toDetail.isCustomized_tap && toDetail.isCustomized_hold {
                // 両方カスタマイズされている場合
                // TODO: マクロの状態に基づいて処理を分岐する
                
                if toDetail.isMacro_tap {
                    to_tap = KeycodeInfo(keyCodeString: "this message should not exist in json")
                } else {
                    guard let info_tap = toDetail.outputAndDisplay_tap.output.keycodeInfo(keycodeRegion) else {
                        throw ExportError.invalidKeycodeList_tap(toDetail: toDetail)
                    }
                    to_tap = info_tap
                }
                
                if toDetail.isMacro_hold {
                    to_hold = KeycodeInfo(keyCodeString: "this message should not exist in json")
                } else {
                    guard let info_hold = toDetail.outputAndDisplay_hold.output.keycodeInfo(keycodeRegion) else {
                        throw ExportError.invalidKeycodeList_hold(toDetail: toDetail)
                    }
                    to_hold = info_hold
                }
                
                return (toKeycodeInfo_tap: to_tap, toKeycodeInfo_hold: to_hold)
                
            } else if toDetail.isCustomized_tap {
                /// ドロップし忘れでタップのみカスタマイズされている場合
                ///ホールドにもタップの情報を入れてあげる
                
                if toDetail.isMacro_tap {
                    to_tap = KeycodeInfo(keyCodeString: "this message should not exist in json")
                } else {
                    guard let info_tap = toDetail.outputAndDisplay_tap.output.keycodeInfo(keycodeRegion) else {
                        throw ExportError.invalidKeycodeList_tap(toDetail: toDetail)
                    }
                    to_tap = info_tap
                }
                
                return (toKeycodeInfo_tap: to_tap, toKeycodeInfo_hold: to_tap)
                
            } else if toDetail.isCustomized_hold {
                // ホールドのみカスタマイズ
                ///タップにもホールドの情報を入れてあげる
                
                if toDetail.isMacro_hold {
                    to_hold = KeycodeInfo(keyCodeString: "this message should not exist in json")
                } else {
                    guard let info_hold = toDetail.outputAndDisplay_hold.output.keycodeInfo(keycodeRegion) else {
                        throw ExportError.invalidKeycodeList_hold(toDetail: toDetail)
                    }
                    to_hold = info_hold
                }
                
                return (toKeycodeInfo_tap: to_hold, toKeycodeInfo_hold: to_hold)
            }
        }
        // デフォルトケース（通常は到達しない）
        fatalError("Error in getKeycodeInfo_TapHold")
    }
    
    func getKeycodeInfo_TapHold_Multi(
        toDetail_multi: ToDetail_multi,
        keycodeRegion: KeycodeRegion
    ) throws -> (toKeycodeInfo_tap: KeycodeInfo, toKeycodeInfo_hold: KeycodeInfo) {
        
        /// タップホールドの処理
        ///両方カスタマイズされているなら
        ///両方を確認
        if toDetail_multi.isCustomized_tap && toDetail_multi.isCustomized_hold {
            // 両方カスタマイズされている場合
            
            let to_tap: KeycodeInfo
            let to_hold: KeycodeInfo
            
            if toDetail_multi.isMacro_tap {
                to_tap = KeycodeInfo(keyCodeString: "this message must not exist in json. Error in getKeycodeInfo_TapHold_Multi TapHold section")
            } else {
                guard let info_tap = toDetail_multi.outputAndDisplay_tap.output.keycodeInfo(keycodeRegion) else {
                    throw ExportError.invalidKeycodeList_multiAction(oad: toDetail_multi.outputAndDisplay_tap)
                }
                to_tap = info_tap
            }
            
            if toDetail_multi.isMacro_hold {
                to_hold = KeycodeInfo(keyCodeString: "this message must not exist in json. Error in getKeycodeInfo_TapHold_Multi TapHold section")
            } else {
                guard let info_hold = toDetail_multi.outputAndDisplay_hold.output.keycodeInfo(keycodeRegion) else {
                    throw ExportError.invalidKeycodeList_multiAction(oad: toDetail_multi.outputAndDisplay_hold)
                }
                to_hold = info_hold
            }
            
            return (toKeycodeInfo_tap: to_tap, toKeycodeInfo_hold: to_hold)
            
        } else if toDetail_multi.isCustomized_tap {
            /// ドロップし忘れでタップのみカスタマイズされている場合
            ///ホールドにもタップの情報を入れてあげる
            let to_tap: KeycodeInfo
            
            if toDetail_multi.isMacro_tap {
                to_tap = KeycodeInfo(keyCodeString: "this message must not exist in json. Error in getKeycodeInfo_TapHold_Multi tap section")
            } else {
                guard let info_tap = toDetail_multi.outputAndDisplay_tap.output.keycodeInfo(keycodeRegion) else {
                    throw ExportError.invalidKeycodeList_multiAction(oad: toDetail_multi.outputAndDisplay_tap)
                }
                to_tap = info_tap
            }
            
            return (toKeycodeInfo_tap: to_tap, toKeycodeInfo_hold: to_tap)
            
        } else if toDetail_multi.isCustomized_hold {
            // ホールドのみカスタマイズ
            ///タップにもホールドの情報を入れてあげる
            let to_hold: KeycodeInfo
            
            if toDetail_multi.isMacro_hold {
                to_hold = KeycodeInfo(keyCodeString: "this message must not exist in json. Error in getKeycodeInfo_TapHold_Multi hold section")
            } else {
                guard let info_hold = toDetail_multi.outputAndDisplay_hold.output.keycodeInfo(keycodeRegion) else {
                    throw ExportError.invalidKeycodeList_multiAction(oad: toDetail_multi.outputAndDisplay_hold)
                }
                to_hold = info_hold
            }
            return (toKeycodeInfo_tap: to_hold, toKeycodeInfo_hold: to_hold)
        }
        fatalError("Error in getKeycodeInfo_TapHold_Multi")
    }
    
    ///MacroCollectionとUUIDを受け取り
    ///指定のMacroを探してそのキーコードの連なりを返す関数
    private func getMicroActions(
        _ macroCollection: MacroCollection,
        uuid_or_key: String,
        keycodeRegion: KeycodeRegion,
        hold: Bool = false
    ) throws -> String{
        
        
        let json: String
        
        if let macro = macroCollection.getMacro_includeStoredMacros(uuid_or_key) {
            do {
                json = try microActions(macro, keycodeRegion: keycodeRegion, hold: hold)
            } catch {
                throw error
            }
        } else {
            throw ExportError.invalidMacroInMacroCollection
        }
        
        return json
    }
    
    private func microActions(
        _ macro: Macro,
        keycodeRegion: KeycodeRegion,
        hold: Bool = false
    ) throws -> String {
        ///Macroを受け取って
        ///{"keycode":　"a"}, {"keycode":　"a"}, {"keycode":　"a"}, {"keycode":　"a"}, {"keycode":　"a"}
        ///みたいなキーコードの連なりを返す関数
        
        let json: String
        var to_array = [String]()//ここに{"keycode":　"a"}とかがはいる
        
        for toDetail in macro.toDetailCollection.collection {
            var microAction_Array = [String]()//"keycode": "a"とか"modifiers": []がはいる
            if let info = toDetail.outputAndDisplay.output.keycodeInfo(keycodeRegion) {
                if hold {
                    let halt = "\"halt\": true"
                    microAction_Array.append(halt)
                }
                
                microAction_Array.append(functionTypeAndKeycode(toKeycodeInfo: info))
                if let modifiers = modi(KeycodeInfo: info, withModifier: toDetail.withModifier) {
                    microAction_Array.append(modifiers)
                }
                let joined = "{\(microAction_Array.joined(separator: ", "))}"
                to_array.append(joined)
                
            } else {
                toDetail.error = true
                throw ExportError.invalidMicroAction(toDetail_macro: toDetail)
                //Error
            }
            
        }
        
        if !to_array.isEmpty {
            json = to_array.joined(separator: ",\n                        ")
        } else {
            //error?
            json = ""
        }
        return json
    }
    
    private func getMicroActions_multi(
        _ macroCollection: MacroCollection,
        uuid_or_key: String,
        keycodeRegion: KeycodeRegion,
        toDetail_id: UUID,
        indexCount: Int,
        isHold: Bool = false
    ) throws -> String{
        ///MacroCollectionとUUIDを受け取り
        ///指定のMacroを探してそのキーコードの連なりを返す関数
        
        let json: String
        
        if let macro = macroCollection.getMacro_includeStoredMacros(uuid_or_key) {
            do {
                json = try microActions_multi(
                    macro,
                    keycodeRegion: keycodeRegion,
                    toDetail_id: toDetail_id,
                    indexCount: indexCount,
                    isHold: isHold
                )
            } catch {
                throw error
            }
        } else {
            throw ExportError.invalidMacroInMacroCollection
        }
        
        return json
    }
    
    ///Macroを受け取って
    ///{"keycode":　"a"}, {"keycode":　"a"}, {"keycode":　"a"}, {"keycode":　"a"}, {"keycode":　"a"}
    ///みたいなキーコードの連なりを返す関数 MultiAction用のインデックス引数がある
    private func microActions_multi(
        _ macro: Macro,
        keycodeRegion: KeycodeRegion,
        toDetail_id: UUID,
        indexCount: Int,
        isHold: Bool = false
    ) throws -> String {
        
        
        let json: String
        var to_array = [String]()//ここに{"keycode":　"a"}とかがはいる
        
        for toDetail in macro.toDetailCollection.collection {
            var microAction_Array = [String]()//"keycode": "a"とか"modifiers": []がはいる
            
            if let info = toDetail.outputAndDisplay.output.keycodeInfo(keycodeRegion) {
                
                microAction_Array.append(functionTypeAndKeycode(toKeycodeInfo: info))
                
                if let modifiers = modi(KeycodeInfo: info, withModifier: toDetail.withModifier) {
                    microAction_Array.append(modifiers)
                }
                if isHold {
                    let halt = "\"halt\": true"
                    microAction_Array.append(halt)
                }
                let multiTapCondition = """
                "conditions": [{ "type": "variable_if", "name": "\(toDetail_id)_\(indexCount)", "value": true }]
                """
                microAction_Array.append(multiTapCondition)
                let joined = "{\(microAction_Array.joined(separator: ", "))}"
                to_array.append(joined)
                
            } else {
                toDetail.error = true
                throw ExportError.invalidMicroAction(toDetail_macro: toDetail)
                //Error
            }

        }
        
        if !to_array.isEmpty {
            json = to_array.joined(separator: ", ")
        } else {
            throw ExportError.emptyMacroAction
        }
        return json
    }
    //MARK: - 共通関数など
    
    /// Toの中身をタップとホールドそれぞれ、返す関数
    /// (tap, hold, parameters)の形で返す、タップのみでも利用可能
    private func toString_TapHoldParameters(
        toDetail: ToDetail,
        macroCollection: MacroCollection,
        keycodeRegion: KeycodeRegion,
        indexCount_optional: Int? = nil,
        comboThreshold: Double? = nil
    ) throws -> (
        to_tap: String,
        to_hold: String,
        parameters: String?
    ){
        let keycodeInfo_tap: KeycodeInfo
        let keycodeInfo_hold: KeycodeInfo
        do {
            (keycodeInfo_tap, keycodeInfo_hold) = try getKeycodeInfo_TapHold(toDetail: toDetail, keycodeRegion: keycodeRegion)
        } catch {
            throw error
        }
        
        let parameters = para(toDetail)

        if toDetail.isTapHoldEnabled { // TapHold
            
            let to_string_tap: String
            let to_string_hold: String
            
            if toDetail.isCustomized_tap {
                if toDetail.isMacro_tap {
                    // macroの処理
                    if let indexCount: Int = indexCount_optional { // multi
                        do {
                            to_string_tap = try getMicroActions_multi(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_tap,
                                keycodeRegion: keycodeRegion,
                                toDetail_id: toDetail.id,
                                indexCount: indexCount
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    } else {
                        do {
                            to_string_tap = try getMicroActions(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_tap,
                                keycodeRegion: keycodeRegion
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    }
                } else {
                    var toArray_tap = [String]()
                    if let halt = halt(toDetail.tapHoldType) {toArray_tap.append(halt)}
                    let toKeycode_tap: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_tap)
                    toArray_tap.append(toKeycode_tap)
                    if let modifiers_tap = modi(KeycodeInfo: keycodeInfo_tap, withModifier: toDetail.withModifier_tap) {
                        toArray_tap.append(modifiers_tap)
                    }
                    if let indexCount: Int = indexCount_optional {
                        let multiTapCondition = """
                    "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }]
                    """
                        toArray_tap.append(multiTapCondition)
                    }
                    to_string_tap = "{\(toArray_tap.joined(separator: ", "))}"
                }
            } else { // Tap がカスタムされていない時、Holdのキーコードやマクロを代わりに入れる
                if toDetail.isMacro_hold {
                    // macroの処理
                    if let indexCount: Int = indexCount_optional { // multi
                        do {
                            to_string_tap = try getMicroActions_multi(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_hold,
                                keycodeRegion: keycodeRegion,
                                toDetail_id: toDetail.id,
                                indexCount: indexCount
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    } else {
                        do {
                            to_string_tap = try getMicroActions(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_hold,
                                keycodeRegion: keycodeRegion
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    }
                } else {
                    var toArray_tap = [String]()
                    if let halt = halt(toDetail.tapHoldType) {toArray_tap.append(halt)}
                    let toKeycode_tap: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_hold)
                    toArray_tap.append(toKeycode_tap)
                    if let modifiers_tap = modi(KeycodeInfo: keycodeInfo_hold, withModifier: toDetail.withModifier_hold) {
                        toArray_tap.append(modifiers_tap)
                    }
                    if let indexCount: Int = indexCount_optional {
                        let multiTapCondition = """
                    "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }]
                    """
                        toArray_tap.append(multiTapCondition)
                    }
                    to_string_tap = "{\(toArray_tap.joined(separator: ", "))}"
                }
            }
            
            if toDetail.isCustomized_hold {
                if toDetail.isMacro_hold {
                    if let indexCount: Int = indexCount_optional { // multi
                        do {
                            to_string_hold = try getMicroActions_multi(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_hold,
                                keycodeRegion: keycodeRegion,
                                toDetail_id: toDetail.id,
                                indexCount: indexCount,
                                isHold: true
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    } else {
                        do {
                            to_string_hold = try getMicroActions(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_hold,
                                keycodeRegion: keycodeRegion,
                                hold: true
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    }
                } else { // 普通のキーコード
                    
                    var toArray_hold = [String]()
                    if let lazy = lazy(toDetail.is_lazy) {toArray_hold.append(lazy)}
                    if let halt = halt(toDetail.tapHoldType) {toArray_hold.append(halt)}
                    let toKeycode_hold: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_hold)
                    toArray_hold.append(toKeycode_hold)
                    if let modifiers_hold = modi(KeycodeInfo: keycodeInfo_hold, withModifier: toDetail.withModifier_hold) {
                        toArray_hold.append(modifiers_hold)
                    }
                    if let indexCount: Int = indexCount_optional {
                        let multiTapCondition = """
                    "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }]
                    """
                        toArray_hold.append(multiTapCondition)
                    }
                    to_string_hold = "{\(toArray_hold.joined(separator: ", "))}"
                }
            } else { // Holdがカスタマイズされていない場合、Tapのキーコードやマクロを代わりに入れる
                if toDetail.isMacro_tap {
                    if let indexCount: Int = indexCount_optional { // multi
                        do {
                            to_string_hold = try getMicroActions_multi(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_tap,
                                keycodeRegion: keycodeRegion,
                                toDetail_id: toDetail.id,
                                indexCount: indexCount,
                                isHold: true
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    } else {
                        do {
                            to_string_hold = try getMicroActions(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_tap,
                                keycodeRegion: keycodeRegion,
                                hold: true
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    }
                } else {
                    
                    var toArray_hold = [String]()
                    if let lazy = lazy(toDetail.is_lazy) {toArray_hold.append(lazy)}
                    if let halt = halt(toDetail.tapHoldType) {toArray_hold.append(halt)}
                    let toKeycode_hold: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_tap)
                    toArray_hold.append(toKeycode_hold)
                    if let modifiers_hold = modi(KeycodeInfo: keycodeInfo_tap, withModifier: toDetail.withModifier_tap) {
                        toArray_hold.append(modifiers_hold)
                    }
                    if let indexCount: Int = indexCount_optional {
                        let multiTapCondition = """
                    "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }]
                    """
                        toArray_hold.append(multiTapCondition)
                    }
                    to_string_hold = "{\(toArray_hold.joined(separator: ", "))}"
                }
            }
            
            return (to_string_tap, to_string_hold, parameters)

        } else { // tapのみ
            
            let to_string_tap: String
            if toDetail.isCustomized_tap {
                if toDetail.isMacro_tap {
                    // macroの処理
                    if let indexCount: Int = indexCount_optional { // multi
                        do {
                            to_string_tap = try getMicroActions_multi(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_tap,
                                keycodeRegion: keycodeRegion,
                                toDetail_id: toDetail.id,
                                indexCount: indexCount
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    } else {
                        do {
                            to_string_tap = try getMicroActions(
                                macroCollection,
                                uuid_or_key: toDetail.macro_id_tap,
                                keycodeRegion: keycodeRegion
                            )
                        } catch {
                            toDetail.error = true
                            throw error
                        }
                    }
                } else {
                    
                    var toArray_tap = [String]()
                    let toKeycode_tap: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_tap)
                    toArray_tap.append(toKeycode_tap)
                    if let modifiers_tap = modi(KeycodeInfo: keycodeInfo_tap, withModifier: toDetail.withModifier_tap) {
                        toArray_tap.append(modifiers_tap)
                    }
                    if let indexCount: Int = indexCount_optional {
                        let multiTapCondition = """
                    "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_\(indexCount)", "value": true }]
                    """
                        toArray_tap.append(multiTapCondition)
                    }
                    to_string_tap = "{\(toArray_tap.joined(separator: ", "))}"
                }
            } else {
                to_string_tap = "this message should not in json"
            }
            return (to_string_tap, "this message should not exist in json: Error in toString_TapHoldParameters Tap Section", nil)
        }
    }
    
    private func toString_TapHoldParameters_multi(
        toDetail: ToDetail,//parameter用
        toDetail_multi: ToDetail_multi,
        macroCollection: MacroCollection,
        keycodeRegion: KeycodeRegion,
        indexCount_optional: Int?,
        comboThreshold: Double? = nil
    ) throws -> (
        to_tap: String,
        to_hold: String,
        parameters: String?
    ){
        let keycodeInfo_multi_tap: KeycodeInfo
        let keycodeInfo_multi_hold: KeycodeInfo
        
        do {
            (keycodeInfo_multi_tap, keycodeInfo_multi_hold) = try getKeycodeInfo_TapHold_Multi(toDetail_multi: toDetail_multi, keycodeRegion: keycodeRegion)
        } catch {
            throw error
        }
        
        let to_string_tap: String
        let to_string_hold: String
        
        let parameters = para(toDetail, comboThreshold: comboThreshold)
        
        if let index: Int = indexCount_optional { // TapHold
            if toDetail_multi.isCustomized_tap {
                if toDetail_multi.isMacro_tap {
                    do {
                        to_string_tap = try getMicroActions_multi(
                            macroCollection,
                            uuid_or_key: toDetail_multi.macro_id_tap,
                            keycodeRegion: keycodeRegion,
                            toDetail_id: toDetail.id,
                            indexCount: index
                        )
                    } catch {
                        throw error
                    }
                } else {
                    var toArray_tap = [String]()
                    let toKeycode_tap: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_multi_tap)
                    toArray_tap.append(toKeycode_tap)
                    if let modifiers_tap = modi(KeycodeInfo: keycodeInfo_multi_tap, withModifier: toDetail_multi.withModifier_tap) {
                        toArray_tap.append(modifiers_tap)
                    }
                    let multiTapCondition = """
                "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_\(index)", "value": true }]
                """
                    toArray_tap.append(multiTapCondition)
                    
                    to_string_tap = "{ \(toArray_tap.joined(separator: ", ")) }"
                }
            } else { // Holdのキーコードかマクロを代わりに入れる
                
                if toDetail_multi.isMacro_hold {
                    do {
                        to_string_tap = try getMicroActions_multi(
                            macroCollection,
                            uuid_or_key: toDetail_multi.macro_id_hold,
                            keycodeRegion: keycodeRegion,
                            toDetail_id: toDetail.id,
                            indexCount: index
                        )
                    } catch {
                        throw error
                    }
                } else {
                    var toArray_tap = [String]()
                    let toKeycode_tap: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_multi_hold)
                    toArray_tap.append(toKeycode_tap)
                    if let modifiers_tap = modi(KeycodeInfo: keycodeInfo_multi_hold, withModifier: toDetail_multi.withModifier_hold) {
                        toArray_tap.append(modifiers_tap)
                    }
                    let multiTapCondition = """
                "conditions": [{ "type": "variable_if", "name": "\(toDetail.id)_\(index)", "value": true }]
                """
                    toArray_tap.append(multiTapCondition)
                    
                    to_string_tap = "{ \(toArray_tap.joined(separator: ", ")) }"
                }
            }
            
            if toDetail_multi.isCustomized_hold {
                if toDetail_multi.isMacro_hold {
                    do {
                        to_string_hold = try getMicroActions_multi(
                            macroCollection,
                            uuid_or_key: toDetail_multi.macro_id_hold,
                            keycodeRegion: keycodeRegion,
                            toDetail_id: toDetail.id,
                            indexCount: index,
                            isHold: true
                        )
                    } catch {
                        throw error
                    }
                } else {
                    var toArray_hold = [String]()
                    
                    if let lazy = lazy(toDetail.is_lazy) {toArray_hold.append(lazy)}
                    
                    let halt = "\"halt\": true"
                    toArray_hold.append(halt)
                    
                    let toKeycode_hold: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_multi_hold)
                    toArray_hold.append(toKeycode_hold)
                    
                    if let modifiers_hold = modi(KeycodeInfo: keycodeInfo_multi_hold, withModifier: toDetail_multi.withModifier_hold) {
                        toArray_hold.append(modifiers_hold)
                    }
                    
                    to_string_hold = "{ \(toArray_hold.joined(separator: ", ")) }"
                }
            } else { // Tapのキーコードかマクロを代わりにいれる
                if toDetail_multi.isMacro_tap {
                    do {
                        to_string_hold = try getMicroActions_multi(
                            macroCollection,
                            uuid_or_key: toDetail_multi.macro_id_tap,
                            keycodeRegion: keycodeRegion,
                            toDetail_id: toDetail.id,
                            indexCount: index,
                            isHold: true
                        )
                    } catch {
                        throw error
                    }
                } else {
                    var toArray_hold = [String]()
                    
                    if let lazy = lazy(toDetail.is_lazy) {toArray_hold.append(lazy)}
                    
                    let halt = "\"halt\": true"
                    toArray_hold.append(halt)
                    
                    let toKeycode_hold: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_multi_tap)
                    toArray_hold.append(toKeycode_hold)
                    
                    if let modifiers_hold = modi(KeycodeInfo: keycodeInfo_multi_tap, withModifier: toDetail_multi.withModifier_tap) {
                        toArray_hold.append(modifiers_hold)
                    }
                    to_string_hold = "{ \(toArray_hold.joined(separator: ", ")) }"
                }
            }
            
            return (to_string_tap, to_string_hold, parameters)
            
        } else { // TapのみのMulti Tap用
            if toDetail_multi.isMacro_tap {
                do {
                    to_string_tap = try getMicroActions(macroCollection, uuid_or_key: toDetail_multi.macro_id_tap, keycodeRegion: keycodeRegion)
                } catch {
                    throw error
                }
            } else {
                var toArray = [String]()//keycode, modifierなどが入る
                let toKeycode: String = functionTypeAndKeycode(toKeycodeInfo: keycodeInfo_multi_tap)
                
                toArray.append(toKeycode)
                
                if let modifiers: String = modi(KeycodeInfo: keycodeInfo_multi_tap, withModifier: toDetail_multi.withModifier_tap) {
                    toArray.append(modifiers)
                }
                
                to_string_tap = "{ \(toArray.joined(separator: ", ")) }"
            }
            return (to_string_tap, "this message should not be in json", parameters)
        }
    }
    
    private func con(
        deviceDetail: DeviceDetail,
        layer: Layer,
        condition: SpecificCondition,
        conditionDetail: ConditionDetail
    ) -> String? {
        var conditionArray = [String]()
        
        if let layerCondition = layer_variable_if(layer) {
            conditionArray.append(layerCondition)
        }
        if let deviceCondition = device_if_identifiers(deviceDetail) {
            conditionArray.append(deviceCondition)
        }
        if let appCondition = spesificCondition(for: conditionDetail, condition: condition) {
            conditionArray.append(appCondition)
        }
        
        let conditions: String?
        if !conditionArray.isEmpty {
            conditions = conditionArray.joined(separator: ",\n\t\t\t\t\t\t")
        } else {
            conditions = nil
        }
        
        return conditions
    }
    
    private func con_combo(
        simultaneouses: [CustomUUID],
        deviceSections: DeviceSections,
        keymap: Keymap,
        layer: Layer,
        condition: SpecificCondition,
        conditionDetail: ConditionDetail
    ) -> String {
        
        
        var allDeviceDetail: [DeviceDetail] = []

        //sectionに合わせて柔軟にやらないといけないので〜
        let divSec: DeviceSections = DeviceSections(sections: [])//コンボ構成要素のキーがあるセクションをここに入れていく
        
        // Simultaneousesの構成要素が含まれているSection情報をもらってそれを格納する
        for id in simultaneouses {
            if let sectionDetail = keymap.getSectionDetail(by: id.id) {
                if !deviceSections.containsSection(sectionDetail.section) {
                    //構成要素がConfigurationのLayout範囲外にある場合
                    //エラーを吐くのは几帳面すぎる？ミスクリックで含まれたキーによってエラーが出るよりは、
                    //そのキーを含めないコンボにするべき?
                }
                
                if divSec.containsSection(sectionDetail.section) {
                    //すでに入ってるなら次
                    continue
                } else {
                    divSec.addSection(sectionDetail.section)
                    //構成要素のデバイスDetailを入れていく
                    allDeviceDetail.append(sectionDetail.deviceDetail)
                }
            }
        }
        
        var conditionArray = [String]()
        
        if let layerCondition = layer_variable_if(layer) {
            conditionArray.append(layerCondition)
        }
        
        
        if let deviceCondition = device_if_identifiers_combo(allDeviceDetail) {
            conditionArray.append(deviceCondition)
        }
        
        if let appCondition = spesificCondition(for: conditionDetail, condition: condition) {
            conditionArray.append(appCondition)
        }
        
        let conditions: String
        if !conditionArray.isEmpty {
            conditions = conditionArray.joined(separator: ",\n                        ")
        } else {
            conditions = ""
        }
        
        return conditions
    }
    
    private func para(_ toDetail: ToDetail, comboThreshold: Double? = nil) -> String? {
        var parametersArray = [String]()
        
        if let simultaneous: Double = comboThreshold {
            let simultaneousThreshold = """
            "basic.simultaneous_threshold_milliseconds": \(String(Int(simultaneous)))
            """
            parametersArray.append(simultaneousThreshold)
        }
        
        if !toDetail.isTapHoldEnabled {
            if toDetail.isMultiTapThresholdEnabled {
                let delayed_action = """
                "basic.to_delayed_action_delay_milliseconds": \(Int(toDetail.multiTapThreshold))
                """
                parametersArray.append(delayed_action)
            }
        } else {
            switch toDetail.tapHoldType {
            case .chord:
                //chordタイプの時
                
                if toDetail.is_alone_timeout_enabled {
                    let if_alone = "\"basic.to_if_alone_timeout_milliseconds\": \(String(Int(toDetail.to_if_alone_timeout_milliseconds)))"
                    parametersArray.append(if_alone)
                }
                
                if toDetail.is_repeat  {
                    //リピートの時
                    if toDetail.isMultiTapThresholdEnabled {
                        let delayed_action = """
                    "basic.to_delayed_action_delay_milliseconds": \(Int(toDetail.multiTapThreshold))
                    """
                        
                        parametersArray.append(delayed_action)
                    }
                }
                
            case .duration:
                //durationタイプの時
                if toDetail.is_held_down_threshold_enabled {
                    //held_downの値をaloneにも入れる
                    let if_alone = "\"basic.to_if_alone_timeout_milliseconds\": \(String(Int(toDetail.to_if_held_down_threshold_milliseconds)))"
                    let if_held_down = "\"basic.to_if_held_down_threshold_milliseconds\": \(String(Int(toDetail.to_if_held_down_threshold_milliseconds)))"
                    parametersArray.append(if_alone)
                    parametersArray.append(if_held_down)
                }
                if toDetail.isMultiTapThresholdEnabled {
                    let delayed_action = """
                    "basic.to_delayed_action_delay_milliseconds": \(Int(toDetail.multiTapThreshold))
                    """
                    
                    parametersArray.append(delayed_action)
                }
            }
        }
    
        let json: String?

        if !parametersArray.isEmpty {
            json = parametersArray.joined(separator: ", ")
        } else {
            json = nil
        }
        
        return json
    }
    
    private func lazy(_ is_lazy: Bool) -> String? {
        let json: String
        if is_lazy {
            json = "\"lazy\": true"
        } else {
            return nil
        }
        return json
    }
    
    private func halt(_ tapHoldType: TapHoldType) -> String? {
        let json: String
        if tapHoldType == .duration {
            json = "\"halt\": true"
        } else {
            return nil
        }
        return json
    }
    
    private func functionTypeAndKeycode(toKeycodeInfo: KeycodeInfo) -> String {
        let keycode: String
        
        if (toKeycodeInfo.functionType == .setVariable) || (toKeycodeInfo.functionType == .mouse) {
            keycode = toKeycodeInfo.keyCodeString//括らない
        } else {
            keycode = "\"\(toKeycodeInfo.keyCodeString)\""
        }
        
        let json = """
        "\(toKeycodeInfo.functionType.rawValue)": \(keycode)
        """
        
        return json
    }
    
    private func modi(KeycodeInfo: KeycodeInfo, withModifier: WithModifier) -> String? {
        let json: String
        if KeycodeInfo.includeShift || KeycodeInfo.includeControl || KeycodeInfo.includeCommand || KeycodeInfo.includeOption || KeycodeInfo.includeFn || withModifier.isWithModifier {
            var modifiersArray: [String] = []
            if KeycodeInfo.includeShift || withModifier.isWithShift { modifiersArray.append("\"left_shift\"") }
            if KeycodeInfo.includeControl || withModifier.isWithControl { modifiersArray.append("\"left_control\"") }
            if KeycodeInfo.includeCommand || withModifier.isWithCommand { modifiersArray.append("\"left_command\"") }
            if KeycodeInfo.includeOption || withModifier.isWithOption { modifiersArray.append("\"left_option\"") }
            if KeycodeInfo.includeFn || withModifier.isWithFunction { modifiersArray.append("\"fn\"") }
            
            // 修飾キーがない場合とset_variableタイプの場合はnil
            //それ以外の場合は結合して文字列に変換
            if modifiersArray.isEmpty || KeycodeInfo.functionType == .setVariable {
                return nil
            } else {
                let modifiersString = modifiersArray.joined(separator: ", ")
                json = """
                "modifiers": [\(modifiersString)]
                """
            }
        } else {
            return nil // 修飾キーが使われない場合
        }
        
        return json

    }
    private func layer_variable_if(_ layer: Layer) -> String? {
        
        let variable_name: String
        
        switch layer {
        case .layer0:
            return nil
        case .layer1:
            variable_name = "layer1"
        case .layer2:
            variable_name = "layer2"
        case .layer3:
            variable_name = "layer3"
        case .layer4:
            variable_name = "layer4"
        case .layer5:
            variable_name = "layer5"
        case .layer6:
            variable_name = "layer6"
        case .layer7:
            variable_name = "layer7"
        case .layer8:
            variable_name = "layer8"
        }
        let json = """
        { "type": "variable_if", "name": "\(variable_name)", "value": true }
        """
        return json
    }
    private func device_if_identifiers(_ deviceDetail: DeviceDetail) -> String? {
        
        var device_if_array = [String]()
        if deviceDetail.is_builtin_keyboard {
            let builtin_Keyboard = "\"is_built_in_keyboard\": true"
            device_if_array.append(builtin_Keyboard)
        }
        if deviceDetail.is_vendor_id_Enabled {
            let vendor_id_condition = "\"vendor_id\": \(deviceDetail.vendor_id)"
            device_if_array.append(vendor_id_condition)
        }
        if deviceDetail.is_product_id_Enabled {
            let product_id_condition = "\"product_id\": \(deviceDetail.product_id)"
            device_if_array.append(product_id_condition)
        }
        if deviceDetail.is_location_id_Enabled {
            let location_id_condition = "\"location_id\": \(deviceDetail.location_id)"
            device_if_array.append(location_id_condition)
        }
        
        var device_if: String
        
        if device_if_array.isEmpty {
            return nil
        } else {
            device_if = device_if_array.joined(separator: ",\n\t\t\t\t\t")
        }
        
        
        var json: String
        json = """
        { "type": "device_if", "identifiers": [{\(device_if)}] }
        """
        return json
    }
    private func device_if_identifiers_combo(_ deviceDetails: [DeviceDetail]) -> String? { // どうやらここにちゃんとMainキーボードが入ってないっぽい
        print("device count: \(deviceDetails.count)")
        for device in deviceDetails {
            print(device.device_name)
        }
        print()
        var identifiersArray: [String] = []
        if deviceDetails.count > 1 {
            for deviceDetail in deviceDetails {
                if let devCon = device_if_identifiers_onlyIdentifiers(deviceDetail) {
                    identifiersArray.append(devCon)
                }
            }
            let identifiers = identifiersArray.joined(separator: ",\n\t\t\t\t\t\t\t\t")
            let json = """
            { 
                                        "type": "device_if",
                                        "identifiers": [
                                            \(identifiers)
                                        ] 
                                    }
            """
            return json
        } else if deviceDetails.isEmpty {
            //配列がからの場合(起こらないとは思うけど)
            return nil
        } else {
            //配列が一つの場合
            return device_if_identifiers(deviceDetails[0])
        }
    }
    private func device_if_identifiers_onlyIdentifiers(_ deviceDetail: DeviceDetail) -> String? {
        
        var device_if_array = [String]()
        if deviceDetail.is_builtin_keyboard {
            let builtin_Keyboard = "\"is_built_in_keyboard\": true"
            device_if_array.append(builtin_Keyboard)
        }
        if deviceDetail.is_vendor_id_Enabled {
            let vendor_id_condition = "\"vendor_id\": \(deviceDetail.vendor_id)"
            device_if_array.append(vendor_id_condition)
        }
        if deviceDetail.is_product_id_Enabled {
            let product_id_condition = "\"product_id\": \(deviceDetail.product_id)"
            device_if_array.append(product_id_condition)
        }
        if deviceDetail.is_location_id_Enabled {
            let location_id_condition = "\"location_id\": \(deviceDetail.location_id)"
            device_if_array.append(location_id_condition)
        }
        
        var device_if: String?
        
        if device_if_array.isEmpty {
            device_if = nil
        } else {
            device_if = """
            { \(device_if_array.joined(separator: ", ")) }
            """
        }
        return device_if
    }

    
    private func spesificCondition(for conditionDetail: ConditionDetail, condition: SpecificCondition) -> String? {
        if !conditionDetail.isEnabled {
            //有効化されていない場合nilを返す
            return nil
        }
        var json: String
        
        switch condition {
            //allAppの場合は条件をつけないのでnilを返す
        case .condition0:
            return nil
            
        default :
            switch conditionDetail.type {
            case .appllication :
                json = """
                {
                                            "type": "frontmost_application_if",
                                            "description": "in \(conditionDetail.name) (app)",
                                            "bundle_identifiers": ["\(conditionDetail.value)"]
                                        }
                """
            case .input_source :
                json = """
                {
                                            "type": "input_source_if",
                                            "description": "in \(conditionDetail.name) (input source)",
                                            "input_sources": [{ "language": "\(conditionDetail.value)" }]
                                        }
                """
            case .finger_count:
                json = """
                {
                                            "type": "variable_if",
                                            "name": "multitouch_extension_finger_count_total" 
                                            "value": \(conditionDetail.value)    
                                        }
                """
            }
        }
        return json
    }
    
    /// simultaneous_optionsの中身を返す関数
    /// - Returns: e.g: -> "key_up_order": "strict_inverse", "key_up_when": "all"
    private func simultaneous_options(_ combo: Combo) -> String? {
        
        var option_array = [String]()
        
        // 他のキーが途中で入ってもコンボとして書き換えをするかどうか
        if combo.detect_key_down_uninterruptedly {
            let detect = "\"detect_key_down_uninterruptedly\": true"
            option_array.append(detect)
        }
        
        // キーの押下順を厳密に扱うかどうか
        switch combo.key_down_order {
        case .insensitive: break
        case .strict: option_array.append("\"key_down_order\": \"strict\"")
        case .strict_inverse: option_array.append("\"key_down_order\": \"strict_inverse\"")
        }
        
        // キーの開放順を厳密に扱うかどうか
        switch combo.key_up_order {
        case .insensitive: break
        case .strict: option_array.append("\"key_up_order\": \"strict\"")
        case .strict_inverse: option_array.append("\"key_up_order\": \"strict_inverse\"")
        }
        
        // key_upの発火点を全てのキーが解放された時にするかどうか
        if combo.key_up_when_all_keys_up {
            option_array.append("\"key_up_when\": \"all\"")
        }
        if !option_array.isEmpty {
            return option_array.joined(separator: ", ")
        } else {
            return nil
        }
    }
}
