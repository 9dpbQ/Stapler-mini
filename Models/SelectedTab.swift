//
//  SelectedTab.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData   

enum SelectedTab: CaseIterable, Codable{
    case macro
    case deviceEdit//キーの追加削除編集など
    case remap//レイヤー、アプリ別のキーマップカスタマイズ
    case combo
    
    func displayString() -> String {
        switch self {
        case .macro:
            "Macro"
        case .deviceEdit:
            "DeviceEdit"
        case .remap:
            "Remap"
        case .combo:
            "Combo"
        }
    }
    
    func helpText() -> String {
        switch self {
        case .macro:
            "Customize user marco that can be applied in remap or combo."
        case .deviceEdit:
            "Customize from-keycode of the orginal device."
        case .remap:
            "Customize the to-keycode to any keycode you like."
        case .combo:
            "Customize combos that trigger an action when multiple keys are pressed simultaneously."
        }
    }
}
