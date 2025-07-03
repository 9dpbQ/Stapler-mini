//
//  ConditionType.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

enum ConditionType: String, CaseIterable, Codable {
    case appllication = "Application"
    case input_source = "InputSource"
    case finger_count = "FingerCount"
    
    var textFieldDescription: String {
        switch self {
        case .appllication:
            return "identifier:"
        case .input_source:
            return "language:"
        case .finger_count:
            return "value:"
        }
    }
    var placeholder: String {
        switch self {
        case .appllication:
            return "com.company.App"
        case .input_source:
            return "ja"
        case .finger_count:
            return "2"
        }
    }
    var placeholderText: Text {
        switch self {
        case .appllication:
            return Text("com.company.App").foregroundColor(.gray)
        case .input_source:
            return Text("ja").foregroundColor(.gray)
        case .finger_count:
            return Text("2").foregroundColor(.gray)
        }
    }
    func helpText() -> String {
        switch self {
        case .appllication:
            "Modify keycode if the bundle identifier matches the frontmost application."
        case .input_source:
            "Modify keycode if the input source language matches the current one."
        case .finger_count:
            "Modify keycode if the count equals to the number of fingers touching the trackpad."
        }
    }
}
