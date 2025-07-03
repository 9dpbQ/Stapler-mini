//
//  StoredMacroDictionary.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/01/20.
//

import Foundation


struct StoredMacroDictionary {
    
    static var allMacros: [String: Macro] {
        let macroGroups: [[String: Macro]] = [kanaMacros] + [programingMacros] + [symbolsAndArrowMacros]
        
        return macroGroups.reduce(into: [:]) { result, macros in
            result.merge(macros) { (current, new) in
                print("Conflict for key '\(current.name)'. Keeping existing value.")
                return current // 重複時には前に入っていたものが採用される
            }
        }
    }
    static func makeDictionaryEntry(key: String, keycodeArray: [ToKeycode]) -> (String, Macro) {
        return (key, Macro(
            name: key,
            dictionary_key: key,
            toDetailCollection: ToDetail_macroCollection(
                collection: keycodeArray.map { ToDetail_macro(output: $0) }
            )
        ))
    }

    static func makeDictionary(entries: [(String, [ToKeycode])]) -> [String: Macro] {
        var dictionary: [String: Macro] = [:]
        
        for (key, keycodeArray) in entries {
            if dictionary.keys.contains(key) {
                print("Warning: Duplicate key detected - '\(key)' was already added. Skipping this entry.")
                continue
            }
            
            dictionary[key] = Macro(
                name: key,
                dictionary_key: key,
                toDetailCollection: ToDetail_macroCollection(
                    collection: keycodeArray.map { ToDetail_macro(output: $0) }
                )
            )
        }
        return dictionary
    }
    
    static let symbolsAndArrowMacros: [String: Macro] = makeDictionary(entries: [
        ("[]", [.controls_and_symbols(.open_square_bracket), .controls_and_symbols(.close_square_bracket), .arrow_keys(.left_arrow)]),
        ("{}", [.shift_symbols(.open_curly_bracket), .shift_symbols(.close_curly_bracket), .arrow_keys(.left_arrow)]),
        ("()", [.shift_symbols(.open_parenthesis), .shift_symbols(.close_parenthesis), .arrow_keys(.left_arrow)]),

        ("''", [.controls_and_symbols(.single_quotation), .controls_and_symbols(.single_quotation), .arrow_keys(.left_arrow)]),
        ("\"\"", [.shift_symbols(.double_quotation), .shift_symbols(.double_quotation), .arrow_keys(.left_arrow)]),
    ])
    
    static let programingMacros: [String: Macro] = makeDictionary(entries: [
        ("+=", [.shift_symbols(.plus), .controls_and_symbols(.equal_sign)]),
        ("-=", [.controls_and_symbols(.hyphen), .controls_and_symbols(.equal_sign)]),
        ("*=", [.shift_symbols(.asterisk), .controls_and_symbols(.equal_sign)]),
        ("/=", [.controls_and_symbols(.slash), .controls_and_symbols(.equal_sign)]),
        ("%=", [.shift_symbols(.percent), .controls_and_symbols(.equal_sign)]),
        
        ("==", [.controls_and_symbols(.equal_sign), .controls_and_symbols(.equal_sign)]),
        ("!=", [.shift_symbols(.exclamation), .controls_and_symbols(.equal_sign)]),
        (">=", [.shift_symbols(.greater_than), .controls_and_symbols(.equal_sign)]),
        ("<=", [.shift_symbols(.less_than), .controls_and_symbols(.equal_sign)]),
        
        ("&&", [.shift_symbols(.ampersand), .shift_symbols(.ampersand)]),
        ("||", [.shift_symbols(.vertical_bar), .shift_symbols(.vertical_bar)]),
        
        ("->", [.controls_and_symbols(.hyphen), .shift_symbols(.greater_than)]),
        ("<-", [ .shift_symbols(.less_than), .controls_and_symbols(.hyphen)]),
    ])

    
    static let kanaMacros: [String: Macro] = makeDictionary(entries: [
        ("あ", [.letter_keys(.a)]),
        ("い", [.letter_keys(.i)]),
        ("う", [.letter_keys(.u)]),
        ("え", [.letter_keys(.e)]),
        ("お", [.letter_keys(.o)]),
        
        ("か", [.letter_keys(.k), .letter_keys(.a)]),
        ("き", [.letter_keys(.k), .letter_keys(.i)]),
        ("く", [.letter_keys(.k), .letter_keys(.u)]),
        ("け", [.letter_keys(.k), .letter_keys(.e)]),
        ("こ", [.letter_keys(.k), .letter_keys(.o)]),
        
        ("さ", [.letter_keys(.s), .letter_keys(.a)]),
        ("し", [.letter_keys(.s), .letter_keys(.i)]),
        ("す", [.letter_keys(.s), .letter_keys(.u)]),
        ("せ", [.letter_keys(.s), .letter_keys(.e)]),
        ("そ", [.letter_keys(.s), .letter_keys(.o)]),
        
        ("た", [.letter_keys(.t), .letter_keys(.a)]),
        ("ち", [.letter_keys(.t), .letter_keys(.i)]),
        ("つ", [.letter_keys(.t), .letter_keys(.u)]),
        ("て", [.letter_keys(.t), .letter_keys(.e)]),
        ("と", [.letter_keys(.t), .letter_keys(.o)]),
        
        ("な", [.letter_keys(.n), .letter_keys(.a)]),
        ("に", [.letter_keys(.n), .letter_keys(.i)]),
        ("ぬ", [.letter_keys(.n), .letter_keys(.u)]),
        ("ね", [.letter_keys(.n), .letter_keys(.e)]),
        ("の", [.letter_keys(.n), .letter_keys(.o)]),
        
        ("は", [.letter_keys(.h), .letter_keys(.a)]),
        ("ひ", [.letter_keys(.h), .letter_keys(.i)]),
        ("ふ", [.letter_keys(.h), .letter_keys(.u)]),
        ("へ", [.letter_keys(.h), .letter_keys(.e)]),
        ("ほ", [.letter_keys(.h), .letter_keys(.o)]),
        
        ("ま", [.letter_keys(.m), .letter_keys(.a)]),
        ("み", [.letter_keys(.m), .letter_keys(.i)]),
        ("む", [.letter_keys(.m), .letter_keys(.u)]),
        ("め", [.letter_keys(.m), .letter_keys(.e)]),
        ("も", [.letter_keys(.m), .letter_keys(.o)]),
        
        ("や", [.letter_keys(.y), .letter_keys(.a)]),
        ("ゆ", [.letter_keys(.y), .letter_keys(.u)]),
        ("よ", [.letter_keys(.y), .letter_keys(.o)]),
        
        ("ら", [.letter_keys(.r), .letter_keys(.a)]),
        ("り", [.letter_keys(.r), .letter_keys(.i)]),
        ("る", [.letter_keys(.r), .letter_keys(.u)]),
        ("れ", [.letter_keys(.r), .letter_keys(.e)]),
        ("ろ", [.letter_keys(.r), .letter_keys(.o)]),
        
        ("わ", [.letter_keys(.w), .letter_keys(.a)]),
        ("を", [.letter_keys(.w), .letter_keys(.o)]),
        ("ん", [.letter_keys(.n), .letter_keys(.n)]),
        
        ("ぁ", [.letter_keys(.x), .letter_keys(.a)]),
        ("ぃ", [.letter_keys(.x), .letter_keys(.i)]),
        ("ぅ", [.letter_keys(.x), .letter_keys(.u)]),
        ("ぇ", [.letter_keys(.x), .letter_keys(.e)]),
        ("ぉ", [.letter_keys(.x), .letter_keys(.o)]),
        
        
        ("ゃ", [.letter_keys(.x), .letter_keys(.y), .letter_keys(.a)]),
        ("ゅ", [.letter_keys(.x), .letter_keys(.y), .letter_keys(.u)]),
        ("ょ", [.letter_keys(.x), .letter_keys(.y), .letter_keys(.o)]),
        
        ("っ", [.letter_keys(.x), .letter_keys(.t), .letter_keys(.u)]),

        
        ("ゔぁ", [.letter_keys(.v), .letter_keys(.a)]),
        ("ゔぃ", [.letter_keys(.v), .letter_keys(.i)]),
        ("ゔ", [.letter_keys(.v), .letter_keys(.u)]),
        ("ゔぇ", [.letter_keys(.v), .letter_keys(.e)]),
        ("ゔぉ", [.letter_keys(.v), .letter_keys(.o)]),
        
        ("が", [.letter_keys(.g), .letter_keys(.a)]),
        ("ぎ", [.letter_keys(.g), .letter_keys(.i)]),
        ("ぐ", [.letter_keys(.g), .letter_keys(.u)]),
        ("げ", [.letter_keys(.g), .letter_keys(.e)]),
        ("ご", [.letter_keys(.g), .letter_keys(.o)]),
        
        ("ざ", [.letter_keys(.z), .letter_keys(.a)]),
        ("じ", [.letter_keys(.z), .letter_keys(.i)]),
        ("ず", [.letter_keys(.z), .letter_keys(.u)]),
        ("ぜ", [.letter_keys(.z), .letter_keys(.e)]),
        ("ぞ", [.letter_keys(.z), .letter_keys(.o)]),
        
        ("だ", [.letter_keys(.d), .letter_keys(.a)]),
        ("ぢ", [.letter_keys(.d), .letter_keys(.i)]),
        ("づ", [.letter_keys(.d), .letter_keys(.u)]),
        ("で", [.letter_keys(.d), .letter_keys(.e)]),
        ("ど", [.letter_keys(.d), .letter_keys(.o)]),
        
        ("ば", [.letter_keys(.b), .letter_keys(.a)]),
        ("び", [.letter_keys(.b), .letter_keys(.i)]),
        ("ぶ", [.letter_keys(.b), .letter_keys(.u)]),
        ("べ", [.letter_keys(.b), .letter_keys(.e)]),
        ("ぼ", [.letter_keys(.b), .letter_keys(.o)]),
        
        ("ぱ", [.letter_keys(.p), .letter_keys(.a)]),
        ("ぴ", [.letter_keys(.p), .letter_keys(.i)]),
        ("ぷ", [.letter_keys(.p), .letter_keys(.u)]),
        ("ぺ", [.letter_keys(.p), .letter_keys(.e)]),
        ("ぽ", [.letter_keys(.p), .letter_keys(.o)]),
        
        
        ("ゔゅ", [.letter_keys(.v), .letter_keys(.y), .letter_keys(.u)]),
        ("ゔょ", [.letter_keys(.v), .letter_keys(.y), .letter_keys(.o)]),
        
        ("うぃ", [.letter_keys(.w), .letter_keys(.h), .letter_keys(.i)]),
        ("うぇ", [.letter_keys(.w), .letter_keys(.h), .letter_keys(.e)]),
        ("うぉ", [.letter_keys(.w), .letter_keys(.h), .letter_keys(.o)]),
        
        ("きゃ", [.letter_keys(.k), .letter_keys(.y), .letter_keys(.a)]),
        ("きゅ", [.letter_keys(.k), .letter_keys(.y), .letter_keys(.u)]),
        ("きょ", [.letter_keys(.k), .letter_keys(.y), .letter_keys(.o)]),
        
        ("ぎゃ", [.letter_keys(.g), .letter_keys(.y), .letter_keys(.a)]),
        ("ぎゅ", [.letter_keys(.g), .letter_keys(.y), .letter_keys(.u)]),
        ("ぎょ", [.letter_keys(.g), .letter_keys(.y), .letter_keys(.o)]),
        
        ("しゃ", [.letter_keys(.s), .letter_keys(.y), .letter_keys(.a)]),
        ("しゅ", [.letter_keys(.s), .letter_keys(.y), .letter_keys(.u)]),
        ("しょ", [.letter_keys(.s), .letter_keys(.y), .letter_keys(.o)]),
        
        ("じゃ", [.letter_keys(.z), .letter_keys(.y), .letter_keys(.a)]),
        ("じゅ", [.letter_keys(.z), .letter_keys(.y), .letter_keys(.u)]),
        ("じょ", [.letter_keys(.z), .letter_keys(.y), .letter_keys(.o)]),
        
        ("ちゃ", [.letter_keys(.t), .letter_keys(.y), .letter_keys(.a)]),
        ("ちゅ", [.letter_keys(.t), .letter_keys(.y), .letter_keys(.u)]),
        ("ちょ", [.letter_keys(.t), .letter_keys(.y), .letter_keys(.o)]),
        
        ("ぢゃ", [.letter_keys(.d), .letter_keys(.y), .letter_keys(.a)]),
        ("ぢゅ", [.letter_keys(.d), .letter_keys(.y), .letter_keys(.u)]),
        ("ぢょ", [.letter_keys(.d), .letter_keys(.y), .letter_keys(.o)]),
        
        
        ("とぅ", [.letter_keys(.t), .letter_keys(.w), .letter_keys(.u)]),
        ("てぃ", [.letter_keys(.t), .letter_keys(.h), .letter_keys(.i)]),
        ("てゅ", [.letter_keys(.t), .letter_keys(.h), .letter_keys(.u)]),
        ("てぇ", [.letter_keys(.t), .letter_keys(.h), .letter_keys(.e)]),
        ("てょ", [.letter_keys(.t), .letter_keys(.h), .letter_keys(.o)]),
        
        ("どぅ", [.letter_keys(.d), .letter_keys(.w), .letter_keys(.u)]),
        ("でぃ", [.letter_keys(.d), .letter_keys(.h), .letter_keys(.i)]),
        ("でゅ", [.letter_keys(.d), .letter_keys(.h), .letter_keys(.u)]),
        ("でぇ", [.letter_keys(.d), .letter_keys(.h), .letter_keys(.e)]),
        
        ("にゃ", [.letter_keys(.n), .letter_keys(.y), .letter_keys(.a)]),
        ("にゅ", [.letter_keys(.n), .letter_keys(.y), .letter_keys(.u)]),
        ("にょ", [.letter_keys(.n), .letter_keys(.y), .letter_keys(.o)]),
        
        ("ひゃ", [.letter_keys(.h), .letter_keys(.y), .letter_keys(.a)]),
        ("ひゅ", [.letter_keys(.h), .letter_keys(.y), .letter_keys(.u)]),
        ("ひょ", [.letter_keys(.h), .letter_keys(.y), .letter_keys(.o)]),
        
        ("ふぁ", [.letter_keys(.f), .letter_keys(.a)]),
        ("ふぃ", [.letter_keys(.f), .letter_keys(.i)]),
        ("ふぇ", [.letter_keys(.f), .letter_keys(.e)]),
        ("ふぉ", [.letter_keys(.f), .letter_keys(.o)]),
        
        ("びゃ", [.letter_keys(.b), .letter_keys(.y), .letter_keys(.a)]),
        ("びゅ", [.letter_keys(.b), .letter_keys(.y), .letter_keys(.u)]),
        ("びょ", [.letter_keys(.b), .letter_keys(.y), .letter_keys(.o)]),
        
        ("ぴゃ", [.letter_keys(.b), .letter_keys(.y), .letter_keys(.a)]),
        ("ぴゅ", [.letter_keys(.b), .letter_keys(.y), .letter_keys(.u)]),
        ("ぴょ", [.letter_keys(.b), .letter_keys(.y), .letter_keys(.o)]),
        
        ("みゃ", [.letter_keys(.m), .letter_keys(.y), .letter_keys(.a)]),
        ("みゅ", [.letter_keys(.m), .letter_keys(.y), .letter_keys(.u)]),
        ("みょ", [.letter_keys(.m), .letter_keys(.y), .letter_keys(.o)]),
        
        ("りゃ", [.letter_keys(.r), .letter_keys(.y), .letter_keys(.a)]),
        ("りゅ", [.letter_keys(.r), .letter_keys(.y), .letter_keys(.u)]),
        ("りょ", [.letter_keys(.r), .letter_keys(.y), .letter_keys(.o)]),
    ])
    
    
}

