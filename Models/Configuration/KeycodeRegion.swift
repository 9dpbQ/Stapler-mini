//
//  KeycodeRegion.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

enum KeycodeRegion: String, CaseIterable, Codable {
    case JIS
    case ANSI
    case ISO
    func layoutName() -> String {
        switch self {
        case .JIS:
            "JIS"
        case .ANSI:
            "US"
        case .ISO:
            "UK"
        }
    }
    
}
