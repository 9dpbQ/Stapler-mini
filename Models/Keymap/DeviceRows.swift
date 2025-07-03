//
//  DeviceRows.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

/// DeviceRows
/// 一つのデバイス分のKeyboardKeyを持つ
/// main, sub, tenkeyセクションごとにRowsとそれぞれのオンオフの状態を持つ
@Model
final class DeviceRows: ObservableObject, Codable {
    var sectionDetail: KeyboardSectionDetail
    
    var mainRows: Rows
    var isEnableMain: Bool
    
    var subRows: Rows
    var isEnableSub: Bool
    
    var tenkeyRows: Rows
    var isEnableTenkey: Bool
    
    
    init(
        section: Devices,
        mainRows: Rows = Rows(),
        subRows: Rows = Rows(),
        tenkeyRows: Rows = Rows(),
        keyboardSize: KeyboardSize = .builtinSize,
        isBuiltInKeyboard: Bool = false,
        product_id: String? = nil,
        vendor_id: String? = nil
    ) {
        let oaie = keyboardSize.deviceSections()
        self.sectionDetail = KeyboardSectionDetail(section, isBuiltInKeyboard: isBuiltInKeyboard, product_id: product_id, vendor_id: vendor_id)
        self.mainRows = mainRows
        self.isEnableMain = oaie.main
        self.subRows = subRows
        self.isEnableSub = oaie.sub
        self.tenkeyRows = tenkeyRows
        self.isEnableTenkey = oaie.tenkey
        
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sectionDetail = try container.decode(KeyboardSectionDetail.self, forKey: .sectionDetail)
        self.mainRows = try container.decode(Rows.self, forKey: .mainRows)
        self.isEnableMain = try container.decode(Bool.self, forKey: .isEnableMain)
        self.subRows = try container.decode(Rows.self, forKey: .subRows)
        self.isEnableSub = try container.decode(Bool.self, forKey: .isEnableSub)
        self.tenkeyRows = try container.decode(Rows.self, forKey: .tenkeyRows)
        self.isEnableTenkey = try container.decode(Bool.self, forKey: .isEnableTenkey)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sectionDetail, forKey: .sectionDetail)
        try container.encode(mainRows, forKey: .mainRows)
        try container.encode(isEnableMain, forKey: .isEnableMain)
        try container.encode(subRows, forKey: .subRows)
        try container.encode(isEnableSub, forKey: .isEnableSub)
        try container.encode(tenkeyRows, forKey: .tenkeyRows)
        try container.encode(isEnableTenkey, forKey: .isEnableTenkey)
    }
    enum CodingKeys: String, CodingKey {
        case sectionDetail
        case mainRows, isEnableMain
        case subRows, isEnableSub
        case tenkeyRows, isEnableTenkey
    }
    
    func allKeyboardKeys_omittingSpacer() -> [KeyboardKey] {
        var keyboardKeys: [[KeyboardKey]] = []
        if isEnableMain {
            keyboardKeys.append(mainRows.allRows_omittingSpacer())
        }
        if isEnableSub {
            keyboardKeys.append(subRows.allRows_omittingSpacer())
        }
        if isEnableTenkey {
            keyboardKeys.append(tenkeyRows.allRows_omittingSpacer())
        }
        return keyboardKeys.flatMap { $0 }
    }
    func allKeyboardKeys() -> [KeyboardKey] {
        var rows: [KeyboardKey] = []
        if isEnableMain {
            rows.append(contentsOf: mainRows.allKeyboardKeys())
        }
        if isEnableSub {
            rows.append(contentsOf: subRows.allKeyboardKeys())
        }
        if isEnableTenkey {
            rows.append(contentsOf: tenkeyRows.allKeyboardKeys())
        }
        return rows
    }
    
    func maximumVerticalUnitSize() -> CGFloat {
        var verticalUnitSize: CGFloat = 0
        if isEnableMain {
            let currentSize = mainRows.verticalUnitSize()
            if verticalUnitSize < currentSize {
                verticalUnitSize = currentSize
            }
        }
        if isEnableSub {
            let currentSize = subRows.verticalUnitSize()
            if verticalUnitSize < currentSize {
                verticalUnitSize = currentSize
            }
        }
        if isEnableTenkey {
            let currentSize = tenkeyRows.verticalUnitSize()
            if verticalUnitSize < currentSize {
                verticalUnitSize = currentSize
            }
        }
        
        return verticalUnitSize
    }
    
    func deviceFrame(_ keyMetrics: KeyMetrics) -> (width: CGFloat, height: CGFloat) {
        // 縦のUnitSizeとkeyMetricsのheightを掛け合わせてFrame heightを出す
        let verticalUnitSize = maximumVerticalUnitSize()
        let frameHeight = (verticalUnitSize * keyMetrics.frameHeight) + keyMetrics.padding_body * 2

        // セクションごとに横の最大UnitSizeを出してKey Metricsのwidthを掛け合わせたあと、
        // 有効なセクションの数に応じてSection paddingを足したFrame Widthを出す
        var frameWidth: CGFloat = keyMetrics.padding_body * 2
        var sectionNum: CGFloat = 0
        if isEnableMain {
            frameWidth += mainRows.maximumUnitSize_horizontal() * keyMetrics.baseSizeX
            sectionNum += 1
        }
        if isEnableSub {
            frameWidth += subRows.maximumUnitSize_horizontal() * keyMetrics.baseSizeX
            sectionNum += 1
        }
        if isEnableTenkey {
            frameWidth += tenkeyRows.maximumUnitSize_horizontal() * keyMetrics.baseSizeX
            sectionNum += 1
        }
        if sectionNum != 0 {
            frameWidth += (sectionNum - 1) * keyMetrics.padding_section
        }
        return (frameWidth, frameHeight)
    }
}
