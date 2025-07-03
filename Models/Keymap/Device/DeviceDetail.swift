//
//  DeviceDetail.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class DeviceDetail: ObservableObject, Codable {
    var device_name: String//ルールのdescriptionにつかう
    var is_builtin_keyboard: Bool
    
    var product_id: String
    var is_product_id_Enabled: Bool
    var vendor_id: String
    var is_vendor_id_Enabled: Bool
    var location_id: String
    var is_location_id_Enabled: Bool
    
    init(
        _ section: Devices,
        isBuiltInKeyboard: Bool = false,
        product_id: String? = nil,
        vendor_id: String? = nil
    ) {
        self.device_name = section.displayName
        self.is_builtin_keyboard = isBuiltInKeyboard
        self.product_id = product_id ?? "product_id"
        self.is_product_id_Enabled = (product_id != nil)
        self.vendor_id = vendor_id ?? "vendor_id"
        self.is_vendor_id_Enabled = (vendor_id != nil)
        self.location_id = "location_id"
        self.is_location_id_Enabled = false
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.device_name = try container.decode(String.self, forKey: .device_name)
        self.is_builtin_keyboard = try container.decode(Bool.self, forKey: .is_builtin_keyboard)
        self.product_id = try container.decode(String.self, forKey: .product_id)
        self.is_product_id_Enabled = try container.decode(Bool.self, forKey: .is_product_id_Enabled)
        self.vendor_id = try container.decode(String.self, forKey: .vendor_id)
        self.is_vendor_id_Enabled = try container.decode(Bool.self, forKey: .is_vendor_id_Enabled)
        self.location_id = try container.decode(String.self, forKey: .location_id)
        self.is_location_id_Enabled = try container.decode(Bool.self, forKey: .is_location_id_Enabled)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(device_name, forKey: .device_name)
        try container.encode(is_builtin_keyboard, forKey: .is_builtin_keyboard)
        try container.encode(product_id, forKey: .product_id)
        try container.encode(is_product_id_Enabled, forKey: .is_product_id_Enabled)
        try container.encode(vendor_id, forKey: .vendor_id)
        try container.encode(is_vendor_id_Enabled, forKey: .is_vendor_id_Enabled)
        try container.encode(location_id, forKey: .location_id)
        try container.encode(is_location_id_Enabled, forKey: .is_location_id_Enabled)
    }
    enum CodingKeys: String, CodingKey {
        case device_name
        case is_builtin_keyboard
        case product_id, is_product_id_Enabled
        case vendor_id, is_vendor_id_Enabled
        case location_id, is_location_id_Enabled
    }
}
