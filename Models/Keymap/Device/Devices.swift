//
//  Devices.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

enum Devices: CaseIterable, Codable, Hashable {
    case other
    case main
    case mouse
    
    var displayName: String {
        switch self {
        case .other:
            "otherDevice"
        case .main:
            "mainKeyboard"
        case .mouse:
            "mouse"
        }
    }
}
