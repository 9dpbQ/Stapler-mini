//
//  TapHoldType.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

enum TapHoldType: String, CaseIterable, Codable {
    case chord
    case duration
    
    func helpText() -> String {
        switch self {
        case .chord:
            "Chord: This mode outputs different keycodes depending on context. When this key is pressed with other keys, it triggers the HOLD keycode. When pressed individually, it outputs the TAP keycode."
        case .duration:
            "Duration: This mode uses timing to determine output. Presses shorter than the threshold value trigger the TAP keycode, while longer presses trigger the HOLD keycode."
        }
    }
}
