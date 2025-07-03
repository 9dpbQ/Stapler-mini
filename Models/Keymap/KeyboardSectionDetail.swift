//
//  KeyboardSectionDetail.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class KeyboardSectionDetail: ObservableObject, Codable{
    var section: Devices
    var deviceDetail: DeviceDetail
    
    init(
        _ section: Devices,
        isBuiltInKeyboard: Bool = false,
        product_id: String? = nil,
        vendor_id: String? = nil
    ) {
        self.section = section
        self.deviceDetail = DeviceDetail(section, isBuiltInKeyboard: isBuiltInKeyboard, product_id: product_id, vendor_id: vendor_id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.section = try container.decode(Devices.self, forKey: .section)
        self.deviceDetail = try container.decode(DeviceDetail.self, forKey: .deviceDetail)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(section, forKey: .section)
        try container.encode(deviceDetail, forKey: .deviceDetail)
    }
    
    enum CodingKeys: String, CodingKey {
        case section, deviceDetail
    }
}
