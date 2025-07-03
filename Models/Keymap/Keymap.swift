//
//  Keymap.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/08.
//
import SwiftData
import SwiftUI

/// SwiftDataでは子クラスの配列をビューで呼び出すと
/// 順序が崩れてしまう仕様？があるため
/// UUIDの配列でソートし直してあげることが必要
/// そのためクラスの配列が入るクラスには
/// 全てUUIDの配列が格納されています

///KeyboardKeyをRowごとに格納しているKeymapクラス
///3つのデバイスのidなどの情報と、KeyboardKeyの配列を持つRowsクラスを持っている
@Model
final class Keymap: ObservableObject, Codable {
    var other: DeviceRows
    var main: DeviceRows
    var mouse: DeviceRows
    var validSections: DeviceSections
    var keycodeRegion: KeycodeRegion //最終的に出力するキーコード:ANSI・JIS・ISO

    init(
        other: DeviceRows = DeviceRows(section: .other),
        main: DeviceRows = DeviceRows(section: .main),
        mouse: DeviceRows = DeviceRows(section: .mouse),
        region: KeycodeRegion = .ANSI,
        validSections: DeviceSections = DeviceSections(sections: [.main])
    ) {
        self.other = other
        self.main = main
        self.mouse = mouse
        self.validSections = validSections
        self.keycodeRegion = region
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.other = try container.decode(DeviceRows.self, forKey: .other)
        self.main = try container.decode(DeviceRows.self, forKey: .main)
        self.mouse = try container.decode(DeviceRows.self, forKey: .mouse)
        self.validSections = try container.decode(DeviceSections.self, forKey: .validSections)
        self.keycodeRegion = try container.decode(KeycodeRegion.self, forKey: .keycodeRegion)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(other, forKey: .other)
        try container.encode(main, forKey: .main)
        try container.encode(mouse, forKey: .mouse)
        try container.encode(validSections, forKey: .validSections)
        try container.encode(keycodeRegion, forKey: .keycodeRegion)
    }

    enum CodingKeys: String, CodingKey {
        case other, main, mouse
        case validSections, keycodeRegion
    }
}

extension Keymap {
    func deviceNames() -> String {
        var oaie: [String] = []
        if validSections.containsSection(.other) {
            oaie.append(other.sectionDetail.deviceDetail.device_name)
        }
        if validSections.containsSection(.main) {
            oaie.append(main.sectionDetail.deviceDetail.device_name)
        }
        if validSections.containsSection(.mouse) {
            oaie.append(mouse.sectionDetail.deviceDetail.device_name)
        }
        
        return oaie.joined(separator: ", ")
    }
    
    var allKeyboardKeys: [KeyboardKey] {
        var keys: [KeyboardKey] = []
        // セクションを確認し、対応する Rows の全キーを収集
        if validSections.containsSection(.other) {
            keys.append(contentsOf: other.allKeyboardKeys())
        }
        if validSections.containsSection(.main) {
            keys.append(contentsOf: main.allKeyboardKeys())
        }

        if validSections.containsSection(.mouse) {
            keys.append(contentsOf: mouse.allKeyboardKeys())
        }
        return keys
    }
    
    var allKeyboardKeys_omittingSpacer: [KeyboardKey] {
        var keys: [KeyboardKey] = []
        // セクションを確認し、対応する Rows のスペーサーをのぞくキーを収集
        if validSections.containsSection(.other) {
            keys.append(contentsOf: other.allKeyboardKeys_omittingSpacer())
        }
        if validSections.containsSection(.main) {
            keys.append(contentsOf: main.allKeyboardKeys_omittingSpacer())
        }

        if validSections.containsSection(.mouse) {
            keys.append(contentsOf: mouse.allKeyboardKeys_omittingSpacer())
        }
        return keys
    }
    
    func getBindingDeviceRows_bySection(_ section: Devices) -> Binding<DeviceRows> {
        switch section {
        case .other:
            return Binding(
                get: { self.other },
                set: { newValue in
                    self.other = newValue
                }
            )
        case .main:
            return Binding(
                get: { self.main },
                set: { newValue in
                    self.main = newValue
                }
            )
        case .mouse:
            return Binding(
                get: { self.mouse },
                set: { newValue in
                    self.mouse = newValue
                }
            )
        }
    }
    
    func getBindingSectionDetail(_ section: Devices) -> Binding<KeyboardSectionDetail> {
        switch section {
        case .other:
            return Binding(
                get: { self.other.sectionDetail },
                set: { newValue in
                    self.other.sectionDetail = newValue
                }
            )
        case .main:
            return Binding(
                get: { self.main.sectionDetail },
                set: { newValue in
                    self.main.sectionDetail = newValue
                }
            )
        case .mouse:
            return Binding(
                get: { self.mouse.sectionDetail },
                set: { newValue in
                    self.mouse.sectionDetail = newValue
                }
            )
        }
    }
    
    func getFromDetail_omittingSpacer(by uuid: UUID) -> FromDetail? {
        if let key = allKeyboardKeys_omittingSpacer.first(where: { $0.id == uuid }) {
            return key.fromDetail
        }
        return nil
    }
  
    
    func getNextKeyboardKey(by uuid: UUID?) -> KeyboardKey? {
        if let id = uuid,
        // 現在のキーが含まれる行を探索
           let currentIndex = allKeyboardKeys_omittingSpacer.firstIndex(where: { $0.id == id }) {
            // 次のキーが存在すれば返す
            if currentIndex + 1 < allKeyboardKeys_omittingSpacer.count {
                return allKeyboardKeys_omittingSpacer[currentIndex + 1]
            }
        }
        // 次のキーがない場合はnilを返す
        return nil
    }
    
    func getKeyboardKey(by uuid: UUID) -> KeyboardKey? {
        return allKeyboardKeys.first { $0.id == uuid }
    }
    func getKeyboardKey_omittingSpacer(by uuid: UUID) -> KeyboardKey? {
        return allKeyboardKeys_omittingSpacer.first { $0.id == uuid }
    }
    
    func getSectionDetail(by uuid: UUID?) -> KeyboardSectionDetail? {
        if uuid != nil {
            // 各セクションのDeviceRowsを配列にまとめる
            let allSections: [DeviceRows] = [other, main, mouse]
            
            // 指定のUUIDを持つKeyboardKeyを持つDevice Rowsを見つけ、そのsectionDetailを返す
            return allSections.first { deviceRows in
                var allKeyboardKeys: [KeyboardKey] = []
                allKeyboardKeys.append(contentsOf: deviceRows.allKeyboardKeys())
                
                return allKeyboardKeys.contains { $0.id == uuid }
                
            }?.sectionDetail
        } else {
            return nil
        }
    }
    func getDeviceRows_byID(by uuid: UUID?) -> Binding<DeviceRows>? {
        if let id = uuid {
            if let section = getSectionDetail(by: id)?.section {
                return getBindingDeviceRows_bySection(section)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func maxFrameHeight(_ keyMetrics: KeyMetrics) -> CGFloat {
        var maxFrameHeight: CGFloat = 100
        if self.validSections.containsSection(.main) && (maxFrameHeight < main.deviceFrame(keyMetrics).height) {
            maxFrameHeight = main.deviceFrame(keyMetrics).height
        }
        
        if self.validSections.containsSection(.other) && (maxFrameHeight < other.deviceFrame(keyMetrics).height) {
            maxFrameHeight = other.deviceFrame(keyMetrics).height
        }
        
        if self.validSections.containsSection(.mouse) && (maxFrameHeight < mouse.deviceFrame(keyMetrics).height) {
            maxFrameHeight = mouse.deviceFrame(keyMetrics).height
        }
        
        return maxFrameHeight
    }
}




enum RowIndex: CaseIterable, Codable {
    case row1
    case row2
    case row3
    case row4
    case row5
    case row6
    
    func indexValue() -> Int {
        switch self {
        case .row1: return 0
        case .row2: return 1
        case .row3: return 2
        case .row4: return 3
        case .row5: return 4
        case .row6: return 5

        }
    }
    func nextRow() -> RowIndex {
        switch self {
        case .row1: .row2
        case .row2: .row3
        case .row3: .row4
        case .row4: .row5
        case .row5: .row6
        case .row6: .row6
        }
    }
}








