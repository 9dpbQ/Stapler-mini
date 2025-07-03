//
//  KeyEventList.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/17.
//

import Foundation

struct KeyEventList {
    
    
    //これさぁ、リージョンごとのリストが必要なんじゃないのか？
    static let fromKeycodeList: [UInt16: FromKeycode] = [
        53: .controls_and_symbols(.escape),
        18: .number_keys(.one),
        19: .number_keys(.two),
        20: .number_keys(.three),
        21: .number_keys(.four),
        23: .number_keys(.five),
        22: .number_keys(.six),
        26: .number_keys(.seven),
        28: .number_keys(.eight),
        25: .number_keys(.nine),
        29: .number_keys(.zero),
        27: .controls_and_symbols(.hyphen),
        24: .controls_and_symbols(.equal_sign_or_caret),
        
        51: .controls_and_symbols(.delete_or_backspace),

        
        48: .controls_and_symbols(.tab),
        12: .letter_keys(.q),
        13: .letter_keys(.w),
        14: .letter_keys(.e),
        15: .letter_keys(.r),
        17: .letter_keys(.t),
        16: .letter_keys(.y),
        31: .letter_keys(.o),
        32: .letter_keys(.u),
        34: .letter_keys(.i),
        35: .letter_keys(.p),
        33: .controls_and_symbols(.open_square_bracket),
        30: .controls_and_symbols(.close_square_bracket),
        42: .controls_and_symbols(.backslash_or_yen),
        

        0: .letter_keys(.a),
        1: .letter_keys(.s),
        2: .letter_keys(.d),
        3: .letter_keys(.f),
        4: .letter_keys(.h),
        5: .letter_keys(.g),
        37: .letter_keys(.l),
        38: .letter_keys(.j),
        40: .letter_keys(.k),
        41: .controls_and_symbols(.semicolon),
        39: .controls_and_symbols(.single_quotation_or_colon),
        36: .controls_and_symbols(.return_or_enter),

        10: .controls_and_symbols(.section),
        6: .letter_keys(.z),
        7: .letter_keys(.x),
        8: .letter_keys(.c),
        9: .letter_keys(.v),
        11: .letter_keys(.b),
        45: .letter_keys(.n),
        46: .letter_keys(.m),
        43: .controls_and_symbols(.comma),
        47: .controls_and_symbols(.period),
        44: .controls_and_symbols(.slash),
        
        
        50: .controls_and_symbols(.grave_accent),
        49: .controls_and_symbols(.spacebar),

        117:.controls_and_symbols(.delete_forward),
        
        71: .keypad_keys(.keypad_num_lock),
        75: .keypad_keys(.keypad_slash),
        67: .keypad_keys(.keypad_asterisk),
        78: .keypad_keys(.keypad_hyphen),
        69: .keypad_keys(.keypad_plus),
        76: .keypad_keys(.keypad_enter),
        83: .keypad_keys(.keypad_1),
        84: .keypad_keys(.keypad_2),
        85: .keypad_keys(.keypad_3),
        86: .keypad_keys(.keypad_4),
        87: .keypad_keys(.keypad_5),
        88: .keypad_keys(.keypad_6),
        89: .keypad_keys(.keypad_7),
        91: .keypad_keys(.keypad_8),
        92: .keypad_keys(.keypad_9),
        82: .keypad_keys(.keypad_0),
        65: .keypad_keys(.keypad_period),
        81: .keypad_keys(.keypad_equal_sign),
        95: .keypad_keys(.keypad_comma),

        105: .keys_in_pc_keyboards(.print_screen),
        114: .keys_in_pc_keyboards(.insert),
        110: .keys_in_pc_keyboards(.application),
//        114: OutputAndDisplay(output: "help", display: "help"),//???
        94: .international_keys(.international1),
        93: .international_keys(.international3),
        104: .international_keys(.lang1),
        102: .international_keys(.lang2),
        
        115: .arrow_keys(.home),
        119: .arrow_keys(.end),
        116: .arrow_keys(.page_up),
        121: .arrow_keys(.page_down),
        
        123: .arrow_keys(.left_arrow),
        124: .arrow_keys(.right_arrow),
        125: .arrow_keys(.down_arrow),
        126: .arrow_keys(.up_arrow),
    ]

    
    static let toKeycodeList: [UInt16: OutputAndDisplay] = [
        53: OutputAndDisplay(output: .controls_and_symbols(.escape), display: "Esc"),
        18: OutputAndDisplay(output: .number_keys(.one), display: "1"),
        19: OutputAndDisplay(output: .number_keys(.two), display: "2"),
        20: OutputAndDisplay(output: .number_keys(.three), display: "3"),
        21: OutputAndDisplay(output: .number_keys(.four), display: "4"),
        23: OutputAndDisplay(output: .number_keys(.five), display: "5"),
        22: OutputAndDisplay(output: .number_keys(.six), display: "6"),
        26: OutputAndDisplay(output: .number_keys(.seven), display: "7"),
        28: OutputAndDisplay(output: .number_keys(.eight), display: "8"),
        25: OutputAndDisplay(output: .number_keys(.nine), display: "9"),
        29: OutputAndDisplay(output: .number_keys(.zero), display: "0"),
        27: OutputAndDisplay(output: .controls_and_symbols(.hyphen), display: "-"),
        24: OutputAndDisplay(output: .controls_and_symbols(.equal_sign), display: "="),
        
        51: OutputAndDisplay(output: .controls_and_symbols(.delete_or_backspace), display: "delete.left", isSFSymbol: true),

        
        48: OutputAndDisplay(output: .controls_and_symbols(.tab), display: "arrow.right.to.line", isSFSymbol: true),
        12: OutputAndDisplay(output: .letter_keys(.q), display: "Q"),
        13: OutputAndDisplay(output: .letter_keys(.w), display: "W"),
        14: OutputAndDisplay(output: .letter_keys(.e), display: "E"),
        15: OutputAndDisplay(output: .letter_keys(.r), display: "R"),
        17: OutputAndDisplay(output: .letter_keys(.t), display: "T"),
        16: OutputAndDisplay(output: .letter_keys(.y), display: "Y"),
        31: OutputAndDisplay(output: .letter_keys(.o), display: "O"),
        32: OutputAndDisplay(output: .letter_keys(.u), display: "U"),
        34: OutputAndDisplay(output: .letter_keys(.i), display: "I"),
        35: OutputAndDisplay(output: .letter_keys(.p), display: "P"),
        33: OutputAndDisplay(output: .controls_and_symbols(.open_square_bracket), display: "["),
        30: OutputAndDisplay(output: .controls_and_symbols(.close_square_bracket), display: "]"),
        42: OutputAndDisplay(output: .controls_and_symbols(.backslash), display: "\\"),
        

        0: OutputAndDisplay(output: .letter_keys(.a), display: "A"),
        1: OutputAndDisplay(output: .letter_keys(.s), display: "S"),
        2: OutputAndDisplay(output: .letter_keys(.d), display: "D"),
        3: OutputAndDisplay(output: .letter_keys(.f), display: "F"),
        4: OutputAndDisplay(output: .letter_keys(.h), display: "H"),
        5: OutputAndDisplay(output: .letter_keys(.g), display: "G"),
        37: OutputAndDisplay(output: .letter_keys(.l), display: "L"),
        38: OutputAndDisplay(output: .letter_keys(.j), display: "J"),
        40: OutputAndDisplay(output: .letter_keys(.k), display: "K"),
        41: OutputAndDisplay(output: .controls_and_symbols(.semicolon), display: ";"),
        39: OutputAndDisplay(output: .controls_and_symbols(.single_quotation), display: "'"),
        36: OutputAndDisplay(output: .controls_and_symbols(.return_or_enter), display: "return", isSFSymbol: true),

        10: OutputAndDisplay(output: .controls_and_symbols(.section), display: "§"),//non_us_back_slash
        6: OutputAndDisplay(output: .letter_keys(.z), display: "Z"),
        7: OutputAndDisplay(output: .letter_keys(.x), display: "X"),
        8: OutputAndDisplay(output: .letter_keys(.c), display: "C"),
        9: OutputAndDisplay(output: .letter_keys(.v), display: "V"),
        11: OutputAndDisplay(output: .letter_keys(.b), display: "B"),
        45: OutputAndDisplay(output: .letter_keys(.n), display: "N"),
        46: OutputAndDisplay(output: .letter_keys(.m), display: "M"),
        43: OutputAndDisplay(output: .controls_and_symbols(.comma), display: ","),
        47: OutputAndDisplay(output: .controls_and_symbols(.period), display: "."),
        44: OutputAndDisplay(output: .controls_and_symbols(.slash), display: "/"),
        
        
        50: OutputAndDisplay(output: .controls_and_symbols(.grave_accent), display: "`"),
        49: OutputAndDisplay(output: .controls_and_symbols(.spacebar), display: "␣"),

        117: OutputAndDisplay(output: .controls_and_symbols(.delete_forward), display: "delete.right", isSFSymbol: true),
        
        71: OutputAndDisplay(output: .keypad_keys(.keypad_num_lock), display: "NumLock"),
        75: OutputAndDisplay(output: .keypad_keys(.keypad_slash), display: "k/"),
        67: OutputAndDisplay(output: .keypad_keys(.keypad_asterisk), display: "k*"),
        78: OutputAndDisplay(output: .keypad_keys(.keypad_hyphen), display: "k-"),
        69: OutputAndDisplay(output: .keypad_keys(.keypad_plus), display: "k+"),
        76: OutputAndDisplay(output: .keypad_keys(.keypad_enter), display: "k enter"),
        83: OutputAndDisplay(output: .keypad_keys(.keypad_1), display: "k1"),
        84: OutputAndDisplay(output: .keypad_keys(.keypad_2), display: "k2"),
        85: OutputAndDisplay(output: .keypad_keys(.keypad_3), display: "k3"),
        86: OutputAndDisplay(output: .keypad_keys(.keypad_4), display: "k4"),
        87: OutputAndDisplay(output: .keypad_keys(.keypad_5), display: "k5"),
        88: OutputAndDisplay(output: .keypad_keys(.keypad_6), display: "k6"),
        89: OutputAndDisplay(output: .keypad_keys(.keypad_7), display: "k7"),
        91: OutputAndDisplay(output: .keypad_keys(.keypad_8), display: "k8"),
        92: OutputAndDisplay(output: .keypad_keys(.keypad_9), display: "k9"),
        82: OutputAndDisplay(output: .keypad_keys(.keypad_0), display: "k0"),
        65: OutputAndDisplay(output: .keypad_keys(.keypad_period), display: "k."),
        81: OutputAndDisplay(output: .keypad_keys(.keypad_equal_sign), display: "k="),
        95: OutputAndDisplay(output: .keypad_keys(.keypad_comma), display: "k,"),

        105: OutputAndDisplay(output: .keys_in_pc_keyboards(.print_screen), display: "printscreen"),
        114: OutputAndDisplay(output: .keys_in_pc_keyboards(.insert), display: "insert"),
        110: OutputAndDisplay(output: .keys_in_pc_keyboards(.application), display: "application"),
//        114: OutputAndDisplay(output: "help", display: "help"),//???
        94: OutputAndDisplay(output: .international_keys(.international1), display: "international1"),
        93: OutputAndDisplay(output: .international_keys(.international3), display: "international3"),
        104: OutputAndDisplay(output: .international_keys(.lang1), display: "lang1"),
        102: OutputAndDisplay(output: .international_keys(.lang2), display: "lang2"),
        
        115: OutputAndDisplay(output: .arrow_keys(.home), display: "arrow.up.to.line", isSFSymbol: true),
        119: OutputAndDisplay(output: .arrow_keys(.end), display: "arrow.down.to.line", isSFSymbol: true),
        116: OutputAndDisplay(output: .arrow_keys(.page_up), display: "arrow,up", isSFSymbol: true),
        121: OutputAndDisplay(output: .arrow_keys(.page_down), display: "arrow,down", isSFSymbol: true),
        
        123: OutputAndDisplay(output: .arrow_keys(.left_arrow), display: "arrowtriangle.left.fill", isSFSymbol: true),
        124: OutputAndDisplay(output: .arrow_keys(.right_arrow), display: "arrowtriangle.right.fill", isSFSymbol: true),
        125: OutputAndDisplay(output: .arrow_keys(.down_arrow), display: "arrowtriangle.down.fill", isSFSymbol: true),
        126: OutputAndDisplay(output: .arrow_keys(.up_arrow), display: "arrowtriangle.up.fill", isSFSymbol: true),
        
    ]
    static func getOutputAndDisplay(from int: UInt16) -> OutputAndDisplay? {
        return KeyEventList.toKeycodeList[int]
    }
    static func getFromKeycode(from int: UInt16) -> FromKeycode? {
        return KeyEventList.fromKeycodeList[int]
    }
}
