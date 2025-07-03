//
//  StoredMacros.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2025/01/09.
//

import SwiftUI

enum KeyboardSize: CaseIterable {
    case fullSize
    case tenkeyLessSize
    case builtinSize
    
    func displayString() -> String {
        switch self {
        case .fullSize:
            "FullSize"
        case .tenkeyLessSize:
            "TenkeyLess"
        case .builtinSize:
            "Builtin"
        }
    }
    func deviceSections() -> (main: Bool, sub: Bool, tenkey: Bool) {
        switch self {
        case .fullSize:
            return (true, true, true)
        case .tenkeyLessSize:
            return (true, true, false)
        case .builtinSize:
            return (true, false, false)
        }
    }
}

enum KeyboardProduct: CaseIterable {
    
    case basic
    case builtin_keyboard
    case scratch
    
    // ここに安くて良いキーボードの実際のプロダクト名とかを入れていく
    //    case Anker_A7726 // Anker ウルトラスリム
    //    case Elecom_TK_FBP102SV // Elecom Bluetoothミニキーボード
    //    case Keychron_B1_Pro // Keychron B1 Pro
    
    
    
    func displayString() -> String {
        switch self {
        case .basic:
            "Basic"
        case .builtin_keyboard:
            "MacBook Builtin Keyboard"
        case .scratch:
            "Totally from scratch"
            
        }
    }
    func name() -> String {
        switch self {
        case .basic:
            "Basic Config"
        case .builtin_keyboard:
            "MacBook Config"
        case .scratch:
            "Scratch Config"
        }
    }
    func getKeymap(fnRow: Bool, keyboardSize: KeyboardSize, region: KeycodeRegion) -> Keymap {
        switch self {
        case .basic:
            return KeyboardFactory.makeBasicKeymap(region: region, isIncludeFnRow: fnRow, keyboardSize: keyboardSize)
        case .builtin_keyboard:
            return KeyboardFactory.makeBuiltInKeymap(region: region, isIncludeFnRow: fnRow, keyboardSize: keyboardSize)
        case .scratch:
            return KeyboardFactory.makeScratchKeymap()
        }
    }
    
}

struct KeyboardFactory {
    
    // スクラッチ用のKeymap
    static func makeScratchKeymap() -> Keymap {
        return Keymap(
            other: DeviceRows(section: .other, mainRows: Rows( row2: [], row3: [], row4: [], row5: [], row6: [])),
            main: DeviceRows(section: .main, mainRows: Rows(row2: [], row3: [], row4: [], row5: [], row6: [])),
            mouse: DeviceRows(section: .mouse, mainRows: Rows(row2: [], row3: [], row4: [], row5: [], row6: []))
            )
    }
     
    // 本体キーボード用のKeymapマップ
    static func makeBuiltInKeymap(region: KeycodeRegion, isIncludeFnRow: Bool, keyboardSize: KeyboardSize) -> Keymap {
        switch region {
        case .JIS:
            return Keymap(
                other: DeviceRows(
                    section: .other,
                    mainRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: true),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: true),
                    keyboardSize: keyboardSize
                ),
                main: DeviceRows(
                    section: .main,
                    mainRows: self.makeJISRow(isIncludeFnRow: isIncludeFnRow, keyboardSize: keyboardSize),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: true),
                    isBuiltInKeyboard: true
                ),
                mouse: DeviceRows(
                    section: .mouse,
                    mainRows: self.makeMouseRows()
                ),
                region: .JIS
            )
        case .ANSI:
            return Keymap(
                other: DeviceRows(
                    section: .other,
                    mainRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false)
                ),
                main: DeviceRows(
                    section: .main,
                    mainRows: self.makeUSRows(isIncludeFnRow: isIncludeFnRow, keyboardSize: keyboardSize),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    keyboardSize: keyboardSize,
                    isBuiltInKeyboard: true

                ),
                mouse: DeviceRows(
                    section: .mouse,
                    mainRows: self.makeMouseRows()
                ),
                region: .ANSI
            )
            
        case .ISO:
            return Keymap(
                other: DeviceRows(
                    section: .other,
                    mainRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false)
                ),
                main: DeviceRows(
                    section: .main,
                    mainRows: self.makeUKRows(isIncludeFnRow: isIncludeFnRow, keyboardSize: keyboardSize),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    keyboardSize: keyboardSize,
                    isBuiltInKeyboard: true
                ),
                mouse: DeviceRows(
                    section: .mouse,
                    mainRows: self.makeMouseRows()
                ),
                region: .ISO
            )
        }
    }
    
    
    // ConditionでIDなどの制約がないもの
    static func makeBasicKeymap(region: KeycodeRegion, isIncludeFnRow: Bool, keyboardSize: KeyboardSize) -> Keymap {
        switch region {
        case .JIS:
            return Keymap(
                other: DeviceRows(
                    section: .other,
                    mainRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: true),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: true),
                    keyboardSize: keyboardSize
                ),
                main: DeviceRows(
                    section: .main,
                    mainRows: self.makeJISRow(isIncludeFnRow: isIncludeFnRow, keyboardSize: keyboardSize),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: true)
                ),
                mouse: DeviceRows(
                    section: .mouse,
                    mainRows: self.makeMouseRows()
                ),
                region: .JIS
            )
        case .ANSI:
            return Keymap(
                other: DeviceRows(
                    section: .other,
                    mainRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false)
                ),
                main: DeviceRows(
                    section: .main,
                    mainRows: self.makeUSRows(isIncludeFnRow: isIncludeFnRow, keyboardSize: keyboardSize),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    keyboardSize: keyboardSize

                ),
                mouse: DeviceRows(
                    section: .mouse,
                    mainRows: self.makeMouseRows()
                ),
                region: .ANSI
            )
            
        case .ISO:
            return Keymap(
                other: DeviceRows(
                    section: .other,
                    mainRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false)
                ),
                main: DeviceRows(
                    section: .main,
                    mainRows: self.makeUKRows(isIncludeFnRow: isIncludeFnRow, keyboardSize: keyboardSize),
                    subRows: self.makeSubRows(isIncludeFnRow: isIncludeFnRow),
                    tenkeyRows: self.makeTenkeyRows(isIncludeFnRow: isIncludeFnRow, isJIS: false),
                    keyboardSize: keyboardSize
                ),
                mouse: DeviceRows(
                    section: .mouse,
                    mainRows: self.makeMouseRows()
                ),
                region: .ISO
            )
        }
    }
    static func makeMouseRows() -> Rows {
        Rows(
            row1: [
                KeyboardKey(output: .mouse_buttons(.button1)),
                KeyboardKey(output: .mouse_buttons(.button2)),
            ],
            row2: [
                KeyboardKey(output: .letter_keys(.a), unitSize: 0.5, isSpacer: true),
                KeyboardKey(output: .mouse_buttons(.button3))
            ],
            row3: [
                KeyboardKey(output: .letter_keys(.a), isSpacer: true)
            ],
            row4: [
                KeyboardKey(output: .letter_keys(.a), isSpacer: true)
            ],
            row5: [],
            row6: []
        )
    }
    static let fnRows: [KeyboardKey] = [
        KeyboardKey(output: .controls_and_symbols(.escape), unitSize: 1.5),
        KeyboardKey(output: .function_keys(.f1)),
        KeyboardKey(output: .function_keys(.f2)),
        KeyboardKey(output: .function_keys(.f3)),
        KeyboardKey(output: .function_keys(.f4)),
        KeyboardKey(output: .function_keys(.f5)),
        KeyboardKey(output: .function_keys(.f6)),
        KeyboardKey(output: .function_keys(.f7)),
        KeyboardKey(output: .function_keys(.f8)),
        KeyboardKey(output: .function_keys(.f9)),
        KeyboardKey(output: .function_keys(.f10)),
        KeyboardKey(output: .function_keys(.f11)),
        KeyboardKey(output: .function_keys(.f12)),
    ]
    
    // 必要な引数を渡して、JISのRows(ビルトイン〜フルサイズ)を返すような関数
    static func makeJISRow(isIncludeFnRow: Bool, keyboardSize: KeyboardSize) -> Rows {
        let main: Rows
        if isIncludeFnRow {//FunctionKey有り
            main = Rows(
                row1: [
                    KeyboardKey(output: .controls_and_symbols(.escape), unitSize: 1.5),
                    KeyboardKey(output: .function_keys(.f1)),
                    KeyboardKey(output: .function_keys(.f2)),
                    KeyboardKey(output: .function_keys(.f3)),
                    KeyboardKey(output: .function_keys(.f4)),
                    KeyboardKey(output: .function_keys(.f5)),
                    KeyboardKey(output: .function_keys(.f6)),
                    KeyboardKey(output: .function_keys(.f7)),
                    KeyboardKey(output: .function_keys(.f8)),
                    KeyboardKey(output: .function_keys(.f9)),
                    KeyboardKey(output: .function_keys(.f10)),
                    KeyboardKey(output: .function_keys(.f11)),
                    KeyboardKey(output: .function_keys(.f12)),
                ],
                row2: [
                    KeyboardKey(output: .number_keys(.one), unitSize: 1.25),
                    KeyboardKey(output: .number_keys(.two)),
                    KeyboardKey(output: .number_keys(.three)),
                    KeyboardKey(output: .number_keys(.four)),
                    KeyboardKey(output: .number_keys(.five)),
                    KeyboardKey(output: .number_keys(.six)),
                    KeyboardKey(output: .number_keys(.seven)),
                    KeyboardKey(output: .number_keys(.eight)),
                    KeyboardKey(output: .number_keys(.nine)),
                    KeyboardKey(output: .number_keys(.zero)),
                    KeyboardKey(output: .controls_and_symbols(.hyphen), region: .JIS),
                    KeyboardKey(output: .controls_and_symbols(.equal_sign_or_caret), region: .JIS),
                    KeyboardKey(output: .international_keys(.international3), region: .JIS),
                    KeyboardKey(output: .controls_and_symbols(.delete_or_backspace), unitSize: 1.25),
                ],
                row3: [
                    KeyboardKey(output: .controls_and_symbols(.tab)),
                    KeyboardKey(output: .letter_keys(.q)),
                    KeyboardKey(output: .letter_keys(.w)),
                    KeyboardKey(output: .letter_keys(.e)),
                    KeyboardKey(output: .letter_keys(.r)),
                    KeyboardKey(output: .letter_keys(.t)),
                    KeyboardKey(output: .letter_keys(.y)),
                    KeyboardKey(output: .letter_keys(.u)),
                    KeyboardKey(output: .letter_keys(.i)),
                    KeyboardKey(output: .letter_keys(.o)),
                    KeyboardKey(output: .letter_keys(.p)),
                    KeyboardKey(output: .controls_and_symbols(.commercial_at_jis)),
                    KeyboardKey(output: .controls_and_symbols(.open_square_bracket_jis)),
                    KeyboardKey(output: .controls_and_symbols(.return_or_enter), unitSize: 1.5, keyShape: .enter_JIS),
                ],
                row4: [
                    KeyboardKey(output: .modifier_keys(.left_control), unitSize: 1.25),
                    KeyboardKey(output: .letter_keys(.a)),
                    KeyboardKey(output: .letter_keys(.s)),
                    KeyboardKey(output: .letter_keys(.d)),
                    KeyboardKey(output: .letter_keys(.f)),
                    KeyboardKey(output: .letter_keys(.g)),
                    KeyboardKey(output: .letter_keys(.h)),
                    KeyboardKey(output: .letter_keys(.j)),
                    KeyboardKey(output: .letter_keys(.k)),
                    KeyboardKey(output: .letter_keys(.l)),
                    KeyboardKey(output: .controls_and_symbols(.semicolon)),
                    KeyboardKey(output: .controls_and_symbols(.single_quotation_or_colon), region: .JIS),
                    KeyboardKey(output: .controls_and_symbols(.close_square_bracket_jis)),
                ],
                row5: [
                    KeyboardKey(output: .modifier_keys(.left_shift), unitSize: 1.75),
                    KeyboardKey(output: .letter_keys(.z)),
                    KeyboardKey(output: .letter_keys(.x)),
                    KeyboardKey(output: .letter_keys(.c)),
                    KeyboardKey(output: .letter_keys(.v)),
                    KeyboardKey(output: .letter_keys(.b)),
                    KeyboardKey(output: .letter_keys(.n)),
                    KeyboardKey(output: .letter_keys(.m)),
                    KeyboardKey(output: .controls_and_symbols(.comma)),
                    KeyboardKey(output: .controls_and_symbols(.period)),
                    KeyboardKey(output: .controls_and_symbols(.slash)),
                    KeyboardKey(output: .international_keys(.international1)),
                    KeyboardKey(output: .modifier_keys(.right_shift), unitSize: 1.75),

                ],
                row6:
                    keyboardSize != .builtinSize
                ? [
                    KeyboardKey(output: .modifier_keys(.caps_lock)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .japanese(.eisuu), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 3.5),
                    KeyboardKey(output: .japanese(.kana), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_option), unitSize: 1.5),
                    KeyboardKey(output: .modifier_keys(.right_control), unitSize: 1.5),
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                ]
                : [
                    KeyboardKey(output: .modifier_keys(.caps_lock)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .japanese(.eisuu), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 3.5),
                    KeyboardKey(output: .japanese(.kana), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                ],
                enableArrowKeys: keyboardSize == .builtinSize,
                rowIndex_arrow: .row6
            )
        } else {//FunctionKeyなし
            main = Rows(
                row1: [
                    KeyboardKey(output: .number_keys(.one), unitSize: 1.25),
                    KeyboardKey(output: .number_keys(.two)),
                    KeyboardKey(output: .number_keys(.three)),
                    KeyboardKey(output: .number_keys(.four)),
                    KeyboardKey(output: .number_keys(.five)),
                    KeyboardKey(output: .number_keys(.six)),
                    KeyboardKey(output: .number_keys(.seven)),
                    KeyboardKey(output: .number_keys(.eight)),
                    KeyboardKey(output: .number_keys(.nine)),
                    KeyboardKey(output: .number_keys(.zero)),
                    KeyboardKey(output: .controls_and_symbols(.hyphen), region: .JIS),
                    KeyboardKey(output: .controls_and_symbols(.equal_sign_or_caret), region: .JIS),
                    KeyboardKey(output: .controls_and_symbols(.backslash_or_yen), region: .JIS),
                    KeyboardKey(output: .controls_and_symbols(.delete_or_backspace), unitSize: 1.25),
                ],
                row2: [
                    KeyboardKey(output: .controls_and_symbols(.tab)),
                    KeyboardKey(output: .letter_keys(.q)),
                    KeyboardKey(output: .letter_keys(.w)),
                    KeyboardKey(output: .letter_keys(.e)),
                    KeyboardKey(output: .letter_keys(.r)),
                    KeyboardKey(output: .letter_keys(.t)),
                    KeyboardKey(output: .letter_keys(.y)),
                    KeyboardKey(output: .letter_keys(.u)),
                    KeyboardKey(output: .letter_keys(.i)),
                    KeyboardKey(output: .letter_keys(.o)),
                    KeyboardKey(output: .letter_keys(.p)),
                    KeyboardKey(output: .controls_and_symbols(.commercial_at_jis)),
                    KeyboardKey(output: .controls_and_symbols(.open_square_bracket_jis)),
                    KeyboardKey(output: .controls_and_symbols(.return_or_enter), unitSize: 1.5, keyShape: .enter_JIS),
                ],
                row3: [
                    KeyboardKey(output: .modifier_keys(.left_control), unitSize: 1.25),
                    KeyboardKey(output: .letter_keys(.a)),
                    KeyboardKey(output: .letter_keys(.s)),
                    KeyboardKey(output: .letter_keys(.d)),
                    KeyboardKey(output: .letter_keys(.f)),
                    KeyboardKey(output: .letter_keys(.g)),
                    KeyboardKey(output: .letter_keys(.h)),
                    KeyboardKey(output: .letter_keys(.j)),
                    KeyboardKey(output: .letter_keys(.k)),
                    KeyboardKey(output: .letter_keys(.l)),
                    KeyboardKey(output: .controls_and_symbols(.semicolon)),
                    KeyboardKey(output: .controls_and_symbols(.single_quotation_or_colon), region: .JIS),
                    KeyboardKey(output: .controls_and_symbols(.close_square_bracket_jis)),
                ],
                row4: [
                    KeyboardKey(output: .modifier_keys(.left_shift), unitSize: 1.75),
                    KeyboardKey(output: .letter_keys(.z)),
                    KeyboardKey(output: .letter_keys(.x)),
                    KeyboardKey(output: .letter_keys(.c)),
                    KeyboardKey(output: .letter_keys(.v)),
                    KeyboardKey(output: .letter_keys(.b)),
                    KeyboardKey(output: .letter_keys(.n)),
                    KeyboardKey(output: .letter_keys(.m)),
                    KeyboardKey(output: .controls_and_symbols(.comma)),
                    KeyboardKey(output: .controls_and_symbols(.period)),
                    KeyboardKey(output: .controls_and_symbols(.slash)),
                    KeyboardKey(output: .international_keys(.international1)),
                    KeyboardKey(output: .modifier_keys(.right_shift), unitSize: 1.75),
                ],
                row5: [
                    KeyboardKey(output: .modifier_keys(.caps_lock)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .japanese(.eisuu), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 3.5),
                    KeyboardKey(output: .japanese(.kana), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                ],
                row6: [],
                enableArrowKeys: true,
                rowIndex_arrow: .row5
            )
        }
        return main
    }
    
    
    static func makeUKRows(isIncludeFnRow: Bool, keyboardSize: KeyboardSize) -> Rows {
        let main: Rows
        if isIncludeFnRow {//FunctionKey有り
            main = Rows(
                row1: [
                    KeyboardKey(output: .controls_and_symbols(.escape), unitSize: 1.5),
                    KeyboardKey(output: .function_keys(.f1)),
                    KeyboardKey(output: .function_keys(.f2)),
                    KeyboardKey(output: .function_keys(.f3)),
                    KeyboardKey(output: .function_keys(.f4)),
                    KeyboardKey(output: .function_keys(.f5)),
                    KeyboardKey(output: .function_keys(.f6)),
                    KeyboardKey(output: .function_keys(.f7)),
                    KeyboardKey(output: .function_keys(.f8)),
                    KeyboardKey(output: .function_keys(.f9)),
                    KeyboardKey(output: .function_keys(.f10)),
                    KeyboardKey(output: .function_keys(.f11)),
                    KeyboardKey(output: .function_keys(.f12)),
                ],
                row2: [
                    KeyboardKey(output: .controls_and_symbols(.section)),
                    KeyboardKey(output: .number_keys(.one)),
                    KeyboardKey(output: .number_keys(.two)),
                    KeyboardKey(output: .number_keys(.three)),
                    KeyboardKey(output: .number_keys(.four)),
                    KeyboardKey(output: .number_keys(.five)),
                    KeyboardKey(output: .number_keys(.six)),
                    KeyboardKey(output: .number_keys(.seven)),
                    KeyboardKey(output: .number_keys(.eight)),
                    KeyboardKey(output: .number_keys(.nine)),
                    KeyboardKey(output: .number_keys(.zero)),
                    KeyboardKey(output: .controls_and_symbols(.hyphen)),
                    KeyboardKey(output: .controls_and_symbols(.equal_sign_or_caret)),
                    KeyboardKey(output: .controls_and_symbols(.delete_or_backspace), unitSize: 1.5),
                ],
                row3: [
                    KeyboardKey(output: .controls_and_symbols(.tab), unitSize: 1.5),
                    KeyboardKey(output: .letter_keys(.q)),
                    KeyboardKey(output: .letter_keys(.w)),
                    KeyboardKey(output: .letter_keys(.e)),
                    KeyboardKey(output: .letter_keys(.r)),
                    KeyboardKey(output: .letter_keys(.t)),
                    KeyboardKey(output: .letter_keys(.y)),
                    KeyboardKey(output: .letter_keys(.u)),
                    KeyboardKey(output: .letter_keys(.i)),
                    KeyboardKey(output: .letter_keys(.o)),
                    KeyboardKey(output: .letter_keys(.p)),
                    KeyboardKey(output: .controls_and_symbols(.open_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.close_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.return_or_enter), unitSize: 1.0, keyShape: .enter_UK),
                ],
                row4: [
                    KeyboardKey(output: .modifier_keys(.caps_lock), unitSize: 1.75),
                    KeyboardKey(output: .letter_keys(.a)),
                    KeyboardKey(output: .letter_keys(.s)),
                    KeyboardKey(output: .letter_keys(.d)),
                    KeyboardKey(output: .letter_keys(.f)),
                    KeyboardKey(output: .letter_keys(.g)),
                    KeyboardKey(output: .letter_keys(.h)),
                    KeyboardKey(output: .letter_keys(.j)),
                    KeyboardKey(output: .letter_keys(.k)),
                    KeyboardKey(output: .letter_keys(.l)),
                    KeyboardKey(output: .controls_and_symbols(.semicolon)),
                    KeyboardKey(output: .controls_and_symbols(.single_quotation_or_colon)),
                    KeyboardKey(output: .controls_and_symbols(.backslash_or_yen)),
                ],
                row5: [
                    KeyboardKey(output: .modifier_keys(.left_shift), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.grave_accent)),
                    KeyboardKey(output: .letter_keys(.z)),
                    KeyboardKey(output: .letter_keys(.x)),
                    KeyboardKey(output: .letter_keys(.c)),
                    KeyboardKey(output: .letter_keys(.v)),
                    KeyboardKey(output: .letter_keys(.b)),
                    KeyboardKey(output: .letter_keys(.n)),
                    KeyboardKey(output: .letter_keys(.m)),
                    KeyboardKey(output: .controls_and_symbols(.comma)),
                    KeyboardKey(output: .controls_and_symbols(.period)),
                    KeyboardKey(output: .controls_and_symbols(.slash)),
                    KeyboardKey(output: .modifier_keys(.right_shift), unitSize: 2.25),

                ],
                row6:
                    keyboardSize != .builtinSize
                ? [
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                    KeyboardKey(output: .modifier_keys(.left_control)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 6),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.5),
                    KeyboardKey(output: .modifier_keys(.right_option), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_control), unitSize: 1.5),
                ]
                : [
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                    KeyboardKey(output: .modifier_keys(.left_control)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 5),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_option)),
                ]
                ,
                enableArrowKeys: keyboardSize == .builtinSize,
                rowIndex_arrow: .row6
            )
        } else {//FunctionKeyなし
            main = Rows(
                row1: [
                    KeyboardKey(output: .controls_and_symbols(.section)),
                    KeyboardKey(output: .number_keys(.one)),
                    KeyboardKey(output: .number_keys(.two)),
                    KeyboardKey(output: .number_keys(.three)),
                    KeyboardKey(output: .number_keys(.four)),
                    KeyboardKey(output: .number_keys(.five)),
                    KeyboardKey(output: .number_keys(.six)),
                    KeyboardKey(output: .number_keys(.seven)),
                    KeyboardKey(output: .number_keys(.eight)),
                    KeyboardKey(output: .number_keys(.nine)),
                    KeyboardKey(output: .number_keys(.zero)),
                    KeyboardKey(output: .controls_and_symbols(.hyphen)),
                    KeyboardKey(output: .controls_and_symbols(.equal_sign_or_caret)),
                    KeyboardKey(output: .controls_and_symbols(.delete_or_backspace), unitSize: 1.5),
                ],
                row2: [
                    KeyboardKey(output: .controls_and_symbols(.tab), unitSize: 1.5),
                    KeyboardKey(output: .letter_keys(.q)),
                    KeyboardKey(output: .letter_keys(.w)),
                    KeyboardKey(output: .letter_keys(.e)),
                    KeyboardKey(output: .letter_keys(.r)),
                    KeyboardKey(output: .letter_keys(.t)),
                    KeyboardKey(output: .letter_keys(.y)),
                    KeyboardKey(output: .letter_keys(.u)),
                    KeyboardKey(output: .letter_keys(.i)),
                    KeyboardKey(output: .letter_keys(.o)),
                    KeyboardKey(output: .letter_keys(.p)),
                    KeyboardKey(output: .controls_and_symbols(.open_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.close_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.return_or_enter), unitSize: 1.0, keyShape: .enter_UK),
                ],
                row3: [
                    KeyboardKey(output: .modifier_keys(.caps_lock), unitSize: 1.75),
                    KeyboardKey(output: .letter_keys(.a)),
                    KeyboardKey(output: .letter_keys(.s)),
                    KeyboardKey(output: .letter_keys(.d)),
                    KeyboardKey(output: .letter_keys(.f)),
                    KeyboardKey(output: .letter_keys(.g)),
                    KeyboardKey(output: .letter_keys(.h)),
                    KeyboardKey(output: .letter_keys(.j)),
                    KeyboardKey(output: .letter_keys(.k)),
                    KeyboardKey(output: .letter_keys(.l)),
                    KeyboardKey(output: .controls_and_symbols(.semicolon)),
                    KeyboardKey(output: .controls_and_symbols(.single_quotation_or_colon)),
                    KeyboardKey(output: .controls_and_symbols(.backslash_or_yen)),
                ],
                row4: [
                    KeyboardKey(output: .modifier_keys(.left_shift), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.grave_accent)),
                    KeyboardKey(output: .letter_keys(.z)),
                    KeyboardKey(output: .letter_keys(.x)),
                    KeyboardKey(output: .letter_keys(.c)),
                    KeyboardKey(output: .letter_keys(.v)),
                    KeyboardKey(output: .letter_keys(.b)),
                    KeyboardKey(output: .letter_keys(.n)),
                    KeyboardKey(output: .letter_keys(.m)),
                    KeyboardKey(output: .controls_and_symbols(.comma)),
                    KeyboardKey(output: .controls_and_symbols(.period)),
                    KeyboardKey(output: .controls_and_symbols(.slash)),
                    KeyboardKey(output: .modifier_keys(.right_shift), unitSize: 2.25),
                ],
                row5: [
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                    KeyboardKey(output: .modifier_keys(.left_control)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 5),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_option)),
                ],
                row6: [],
                enableArrowKeys: true,
                rowIndex_arrow: .row5
            )
        }
        return main
    }
    
    static func makeUSRows(isIncludeFnRow: Bool, keyboardSize: KeyboardSize) -> Rows {
        let main: Rows
        if isIncludeFnRow {//FunctionKey有り
            main = Rows(
                row1: [
                    KeyboardKey(output: .controls_and_symbols(.escape), unitSize: 1.5),
                    KeyboardKey(output: .function_keys(.f1)),
                    KeyboardKey(output: .function_keys(.f2)),
                    KeyboardKey(output: .function_keys(.f3)),
                    KeyboardKey(output: .function_keys(.f4)),
                    KeyboardKey(output: .function_keys(.f5)),
                    KeyboardKey(output: .function_keys(.f6)),
                    KeyboardKey(output: .function_keys(.f7)),
                    KeyboardKey(output: .function_keys(.f8)),
                    KeyboardKey(output: .function_keys(.f9)),
                    KeyboardKey(output: .function_keys(.f10)),
                    KeyboardKey(output: .function_keys(.f11)),
                    KeyboardKey(output: .function_keys(.f12)),
                ],
                row2: [
                    KeyboardKey(output: .controls_and_symbols(.grave_accent)),
                    KeyboardKey(output: .number_keys(.one)),
                    KeyboardKey(output: .number_keys(.two)),
                    KeyboardKey(output: .number_keys(.three)),
                    KeyboardKey(output: .number_keys(.four)),
                    KeyboardKey(output: .number_keys(.five)),
                    KeyboardKey(output: .number_keys(.six)),
                    KeyboardKey(output: .number_keys(.seven)),
                    KeyboardKey(output: .number_keys(.eight)),
                    KeyboardKey(output: .number_keys(.nine)),
                    KeyboardKey(output: .number_keys(.zero)),
                    KeyboardKey(output: .controls_and_symbols(.hyphen)),
                    KeyboardKey(output: .controls_and_symbols(.equal_sign_or_caret)),
                    KeyboardKey(output: .controls_and_symbols(.delete_or_backspace), unitSize: 1.5),//USはSF Symbolではないみたい
                    
                ],
                row3: [
                    KeyboardKey(output: .controls_and_symbols(.tab), unitSize: 1.5),
                    KeyboardKey(output: .letter_keys(.q)),
                    KeyboardKey(output: .letter_keys(.w)),
                    KeyboardKey(output: .letter_keys(.e)),
                    KeyboardKey(output: .letter_keys(.r)),
                    KeyboardKey(output: .letter_keys(.t)),
                    KeyboardKey(output: .letter_keys(.y)),
                    KeyboardKey(output: .letter_keys(.u)),
                    KeyboardKey(output: .letter_keys(.i)),
                    KeyboardKey(output: .letter_keys(.o)),
                    KeyboardKey(output: .letter_keys(.p)),
                    KeyboardKey(output: .controls_and_symbols(.open_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.close_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.backslash_or_yen)),
                ],
                row4: [
                    KeyboardKey(output: .modifier_keys(.caps_lock), unitSize: 1.75),
                    KeyboardKey(output: .letter_keys(.a)),
                    KeyboardKey(output: .letter_keys(.s)),
                    KeyboardKey(output: .letter_keys(.d)),
                    KeyboardKey(output: .letter_keys(.f)),
                    KeyboardKey(output: .letter_keys(.g)),
                    KeyboardKey(output: .letter_keys(.h)),
                    KeyboardKey(output: .letter_keys(.j)),
                    KeyboardKey(output: .letter_keys(.k)),
                    KeyboardKey(output: .letter_keys(.l)),
                    KeyboardKey(output: .controls_and_symbols(.semicolon)),
                    KeyboardKey(output: .controls_and_symbols(.single_quotation_or_colon)),
                    KeyboardKey(output: .controls_and_symbols(.return_or_enter), unitSize: 1.75),
                    
                ],
                row5: [
                    KeyboardKey(output: .modifier_keys(.left_shift), unitSize: 2.25),
                    KeyboardKey(output: .letter_keys(.z)),
                    KeyboardKey(output: .letter_keys(.x)),
                    KeyboardKey(output: .letter_keys(.c)),
                    KeyboardKey(output: .letter_keys(.v)),
                    KeyboardKey(output: .letter_keys(.b)),
                    KeyboardKey(output: .letter_keys(.n)),
                    KeyboardKey(output: .letter_keys(.m)),
                    KeyboardKey(output: .controls_and_symbols(.comma)),
                    KeyboardKey(output: .controls_and_symbols(.period)),
                    KeyboardKey(output: .controls_and_symbols(.slash)),
                    KeyboardKey(output: .modifier_keys(.right_shift), unitSize: 2.25),

                ],
                row6:
                    keyboardSize != .builtinSize
                ? [
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                    KeyboardKey(output: .modifier_keys(.left_control)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 6),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.5),
                    KeyboardKey(output: .modifier_keys(.right_option), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_control), unitSize: 1.5),
                ]
                : [
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                    KeyboardKey(output: .modifier_keys(.left_control)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 5),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_option)),
                ],
                enableArrowKeys: keyboardSize == .builtinSize,
                rowIndex_arrow: .row6
            )
        } else { //FunctionKeyなし
            main = Rows(
                row1: [
                    KeyboardKey(output: .controls_and_symbols(.grave_accent)),
                    KeyboardKey(output: .number_keys(.one)),
                    KeyboardKey(output: .number_keys(.two)),
                    KeyboardKey(output: .number_keys(.three)),
                    KeyboardKey(output: .number_keys(.four)),
                    KeyboardKey(output: .number_keys(.five)),
                    KeyboardKey(output: .number_keys(.six)),
                    KeyboardKey(output: .number_keys(.seven)),
                    KeyboardKey(output: .number_keys(.eight)),
                    KeyboardKey(output: .number_keys(.nine)),
                    KeyboardKey(output: .number_keys(.zero)),
                    KeyboardKey(output: .controls_and_symbols(.hyphen)),
                    KeyboardKey(output: .controls_and_symbols(.equal_sign_or_caret)),
                    KeyboardKey(output: .controls_and_symbols(.delete_or_backspace), unitSize: 1.5),
                ],
                row2: [
                    KeyboardKey(output: .controls_and_symbols(.tab), unitSize: 1.5),
                    KeyboardKey(output: .letter_keys(.q)),
                    KeyboardKey(output: .letter_keys(.w)),
                    KeyboardKey(output: .letter_keys(.e)),
                    KeyboardKey(output: .letter_keys(.r)),
                    KeyboardKey(output: .letter_keys(.t)),
                    KeyboardKey(output: .letter_keys(.y)),
                    KeyboardKey(output: .letter_keys(.u)),
                    KeyboardKey(output: .letter_keys(.i)),
                    KeyboardKey(output: .letter_keys(.o)),
                    KeyboardKey(output: .letter_keys(.p)),
                    KeyboardKey(output: .controls_and_symbols(.open_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.close_square_bracket)),
                    KeyboardKey(output: .controls_and_symbols(.backslash_or_yen)),
                ],
                row3: [
                    KeyboardKey(output: .modifier_keys(.caps_lock), unitSize: 1.75),
                    KeyboardKey(output: .letter_keys(.a)),
                    KeyboardKey(output: .letter_keys(.s)),
                    KeyboardKey(output: .letter_keys(.d)),
                    KeyboardKey(output: .letter_keys(.f)),
                    KeyboardKey(output: .letter_keys(.g)),
                    KeyboardKey(output: .letter_keys(.h)),
                    KeyboardKey(output: .letter_keys(.j)),
                    KeyboardKey(output: .letter_keys(.k)),
                    KeyboardKey(output: .letter_keys(.l)),
                    KeyboardKey(output: .controls_and_symbols(.semicolon)),
                    KeyboardKey(output: .controls_and_symbols(.single_quotation_or_colon)),
                    KeyboardKey(output: .controls_and_symbols(.return_or_enter), unitSize: 1.75),
                ],
                row4: [
                    KeyboardKey(output: .modifier_keys(.left_shift), unitSize: 2.25),
                    KeyboardKey(output: .letter_keys(.z)),
                    KeyboardKey(output: .letter_keys(.x)),
                    KeyboardKey(output: .letter_keys(.c)),
                    KeyboardKey(output: .letter_keys(.v)),
                    KeyboardKey(output: .letter_keys(.b)),
                    KeyboardKey(output: .letter_keys(.n)),
                    KeyboardKey(output: .letter_keys(.m)),
                    KeyboardKey(output: .controls_and_symbols(.comma)),
                    KeyboardKey(output: .controls_and_symbols(.period)),
                    KeyboardKey(output: .controls_and_symbols(.slash)),
                    KeyboardKey(output: .modifier_keys(.right_shift), unitSize: 2.25),
                ],
                row5: [
                    KeyboardKey(output: .modifier_keys(.keyboard_fn)),
                    KeyboardKey(output: .modifier_keys(.left_control)),
                    KeyboardKey(output: .modifier_keys(.left_option)),
                    KeyboardKey(output: .modifier_keys(.left_command), unitSize: 1.25),
                    KeyboardKey(output: .controls_and_symbols(.spacebar), unitSize: 5),
                    KeyboardKey(output: .modifier_keys(.right_command), unitSize: 1.25),
                    KeyboardKey(output: .modifier_keys(.right_option)),
                ],
                row6: [],
                enableArrowKeys: true,
                rowIndex_arrow: .row5
            )
        }
        return main
    }
    
    static func makeSubRows(isIncludeFnRow: Bool) -> Rows {
        let sub: Rows
        if isIncludeFnRow {
            sub = Rows(
                row1: [
                    KeyboardKey(output: .function_keys(.f13)),
                    KeyboardKey(output: .function_keys(.f14)),
                    KeyboardKey(output: .function_keys(.f15)),
                ],
                row2: [
                    KeyboardKey(output: .keys_in_pc_keyboards(.insert)),
                    KeyboardKey(output: .arrow_keys(.home)),
                    KeyboardKey(output: .arrow_keys(.page_up)),
                ],
                row3: [
                    KeyboardKey(output: .controls_and_symbols(.delete_forward)),
                    KeyboardKey(output: .arrow_keys(.end)),
                    KeyboardKey(output: .arrow_keys(.page_down)),
                ],
                row4: [],
                row5: [
                    KeyboardKey(output: .letter_keys(.a), isSpacer: true),
                    KeyboardKey(output: .arrow_keys(.up_arrow)),
                ],
                row6: [
                    KeyboardKey(output: .arrow_keys(.left_arrow)),
                    KeyboardKey(output: .arrow_keys(.down_arrow)),
                    KeyboardKey(output: .arrow_keys(.right_arrow)),
                ]
            )
        } else {
            sub = Rows(
                row1: [
                    KeyboardKey(output: .keys_in_pc_keyboards(.insert)),
                    KeyboardKey(output: .arrow_keys(.home)),
                    KeyboardKey(output: .arrow_keys(.page_up)),
                ],
                row2: [
                    KeyboardKey(output: .controls_and_symbols(.delete_forward)),
                    KeyboardKey(output: .arrow_keys(.end)),
                    KeyboardKey(output: .arrow_keys(.page_down)),
                ],
                row3: [],
                row4: [
                    KeyboardKey(output: .letter_keys(.a), isSpacer: false),
                    KeyboardKey(output: .arrow_keys(.up_arrow)),
                    KeyboardKey(output: .letter_keys(.a), isSpacer: false),
                ],
                row5: [
                    KeyboardKey(output: .arrow_keys(.left_arrow)),
                    KeyboardKey(output: .arrow_keys(.down_arrow)),
                    KeyboardKey(output: .arrow_keys(.right_arrow)),
                ],
                row6: []
            )
        }
        return sub
    }
    
    static func makeTenkeyRows(isIncludeFnRow: Bool, isJIS: Bool) -> Rows {
        let tenkey: Rows
        if isIncludeFnRow {
            tenkey = Rows(
                row1: [
                    KeyboardKey(output: .function_keys(.f16)),
                    KeyboardKey(output: .function_keys(.f17)),
                    KeyboardKey(output: .function_keys(.f18)),
                    KeyboardKey(output: .function_keys(.f19)),
                ],
                row2: [
                    KeyboardKey(output: .others(.clear)),
                    KeyboardKey(output: .keypad_keys(.keypad_equal_sign)),
                    KeyboardKey(output: .keypad_keys(.keypad_slash)),
                    KeyboardKey(output: .keypad_keys(.keypad_asterisk))
                ],
                row3: [
                    KeyboardKey(output: .keypad_keys(.keypad_7)),
                    KeyboardKey(output: .keypad_keys(.keypad_8)),
                    KeyboardKey(output: .keypad_keys(.keypad_9)),
                    KeyboardKey(output: .keypad_keys(.keypad_hyphen)),
                ],
                row4: [
                    KeyboardKey(output: .keypad_keys(.keypad_4)),
                    KeyboardKey(output: .keypad_keys(.keypad_5)),
                    KeyboardKey(output: .keypad_keys(.keypad_6)),
                    KeyboardKey(output: .keypad_keys(.keypad_plus)),
                ],
                row5: [
                    KeyboardKey(output: .keypad_keys(.keypad_1)),
                    KeyboardKey(output: .keypad_keys(.keypad_2)),
                    KeyboardKey(output: .keypad_keys(.keypad_3)),
                    KeyboardKey(output: .keypad_keys(.keypad_enter), keyShape: .enter_Tenkey),
                ],
                row6:
                    isJIS
                ? [
                    KeyboardKey(output: .keypad_keys(.keypad_0)),
                    KeyboardKey(output: .keypad_keys(.keypad_comma)),
                    KeyboardKey(output: .keypad_keys(.keypad_period)),
                ]
                : [
                    KeyboardKey(output: .keypad_keys(.keypad_0), unitSize: 2),
                    KeyboardKey(output: .keypad_keys(.keypad_period)),
                ]
            )
        } else {
            tenkey = Rows(
                row1: [
                    KeyboardKey(output: .others(.clear)),
                    KeyboardKey(output: .keypad_keys(.keypad_equal_sign)),
                    KeyboardKey(output: .keypad_keys(.keypad_slash)),
                    KeyboardKey(output: .keypad_keys(.keypad_asterisk))
                ],
                row2: [
                    KeyboardKey(output: .keypad_keys(.keypad_7)),
                    KeyboardKey(output: .keypad_keys(.keypad_8)),
                    KeyboardKey(output: .keypad_keys(.keypad_9)),
                    KeyboardKey(output: .keypad_keys(.keypad_hyphen)),
                ],
                row3: [
                    KeyboardKey(output: .keypad_keys(.keypad_4)),
                    KeyboardKey(output: .keypad_keys(.keypad_5)),
                    KeyboardKey(output: .keypad_keys(.keypad_6)),
                    KeyboardKey(output: .keypad_keys(.keypad_plus)),
                ],
                row4: [
                    KeyboardKey(output: .keypad_keys(.keypad_1)),
                    KeyboardKey(output: .keypad_keys(.keypad_2)),
                    KeyboardKey(output: .keypad_keys(.keypad_3)),
                    KeyboardKey(output: .keypad_keys(.keypad_enter), keyShape: .enter_Tenkey),
                ],
                row5:
                    isJIS
                ? [
                    KeyboardKey(output: .keypad_keys(.keypad_0)),
                    KeyboardKey(output: .keypad_keys(.keypad_comma)),
                    KeyboardKey(output: .keypad_keys(.keypad_period)),
                ]
                : [
                    KeyboardKey(output: .keypad_keys(.keypad_0), unitSize: 2),
                    KeyboardKey(output: .keypad_keys(.keypad_period)),
                ],
                row6: []
            )
        }
        return tenkey
    }
}

