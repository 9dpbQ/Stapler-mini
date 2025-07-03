//
//  KeycodeEnums.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2025/01/14.
//

import Foundation

enum ModifierKeys: String, CaseIterable, Codable {
    case caps_lock
    case left_control
    case left_shift
    case left_option
    case left_command
    case right_control
    case right_shift
    case right_option
    case right_command
    case keyboard_fn
    ///リージョンごとの最終的なキーコード
    func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo{
        switch self {
        case .keyboard_fn: KeycodeInfo(functionType: .appleVendorTopCase, keyCodeString: self.rawValue)
        default: KeycodeInfo(keyCodeString: self.rawValue)
        }
    }
    ///デフォルトのDisplay情報
    func displaySymbol() -> (display: String, isSFSymbol: Bool) {
        switch self {
        case .caps_lock: ("capslock", true)
        case .left_control: ("control", true)
        case .left_shift: ("shift", true)
        case .left_option: ("option", true)
        case .left_command: ("command", true)
        case .right_control: ("control", true)
        case .right_shift: ("shift", true)
        case .right_option: ("option", true)
        case .right_command: ("command", true)
        case .keyboard_fn: ("globe", true)
        }
    }
}


enum LetterKeys: String, CaseIterable, Codable {
    case a, b, c, d, e, f, g
    case h, i, j, k, l, m, n
    case o, p, q, r, s, t, u
    case v, w, x, y, z
    func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
        KeycodeInfo(keyCodeString: self.rawValue)
    }
    func displaySymbol() -> (display: String, isSFSymbol: Bool) {
        (self.rawValue.capitalized, false)
    }
}

enum NumberKeys: String, CaseIterable, Codable {
    case one, two, three, four, five, six, seven, eight, nine, zero
    
    func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
        switch self {
        case .one:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "1")).keycodeInfo(region)
        case .two:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "2")).keycodeInfo(region)
        case .three:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "3")).keycodeInfo(region)
        case .four:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "4")).keycodeInfo(region)
        case .five:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "5")).keycodeInfo(region)
        case .six:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "6")).keycodeInfo(region)
        case .seven:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "7")).keycodeInfo(region)
        case .eight:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "8")).keycodeInfo(region)
        case .nine:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "9")).keycodeInfo(region)
        case .zero:
            KeycodeInfoCollection(KeycodeInfo(keyCodeString: "0")).keycodeInfo(region)
        }
    }
    func displaySymbol() -> (display: String, isSFSymbol: Bool) {
        switch self {
        case .one: ("1", false)
        case .two: ("2", false)
        case .three: ("3", false)
        case .four: ("4", false)
        case .five: ("5", false)
        case .six: ("6", false)
        case .seven: ("7", false)
        case .eight: ("8", false)
        case .nine: ("9", false)
        case .zero: ("0", false)
        }
    }
}

enum KeypadKeys: String, CaseIterable, Codable {
    case keypad_num_lock
    case keypad_slash
    case keypad_asterisk
    case keypad_hyphen
    case keypad_plus
    case keypad_enter
    case keypad_1, keypad_2, keypad_3, keypad_4, keypad_5
    case keypad_6, keypad_7, keypad_8, keypad_9, keypad_0
    case keypad_period
    case keypad_equal_sign
    case keypad_comma
    
    func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
        KeycodeInfo(keyCodeString: self.rawValue)
    }
    func displaySymbol() -> (display: String, isSFSymbol: Bool) {
        switch self {
        case .keypad_num_lock:
            ("num lock", false)
        case .keypad_slash:
            ("/", false)
        case .keypad_asterisk:
            ("*", false)
        case .keypad_hyphen:
            ("-", false)
        case .keypad_plus:
            ("+", false)
        case .keypad_enter:
            ("projective", true)
        case .keypad_1:
            ("1", false)
        case .keypad_2:
            ("2", false)
        case .keypad_3:
            ("3", false)
        case .keypad_4:
            ("4", false)
        case .keypad_5:
            ("5", false)
        case .keypad_6:
            ("6", false)
        case .keypad_7:
            ("7", false)
        case .keypad_8:
            ("8", false)
        case .keypad_9:
            ("9", false)
        case .keypad_0:
            ("0", false)
        case .keypad_period:
            (".", false)
        case .keypad_equal_sign:
            ("=", false)
        case .keypad_comma:
            (",", false)
        }
    }
}
enum MouseButtons: String, CaseIterable, Codable {
    case button1, button2, button3, button4, button5, button6, button7, button8, button9
    case button10, button11, button12, button13, button14, button15, button16, button17, button18, button19
    case button20, button21, button22, button23, button24, button25, button26, button27, button28, button29
    case button30, button31, button32
    //pointingbutton
    func keycodeInfo(_ region: KeycodeRegion) -> KeycodeInfo {
        KeycodeInfo(functionType: .pointing, keyCodeString: self.rawValue)
    }
    
    func displaySymbol() -> (display: String, isSFSymbol: Bool) {
        switch self {
        case .button1:
            ("L click", false)
        case .button2:
            ("R click", false)
        case .button3:
            ("M click", false)
        default:
            (self.rawValue, false)
        }
    }
    
}

