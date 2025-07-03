//
//  OutputAndDisplay.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class OutputAndDisplay: Identifiable, ObservableObject, Codable {
    var output: ToKeycode
    var display: String
    var isSFSymbol: Bool
    var layerKey: Layer
    
    init(output: ToKeycode, display: String, isSFSymbol: Bool = false, layerKey: Layer = .layer0) {
        self.output = output
        self.display = display
        self.isSFSymbol = isSFSymbol
        self.layerKey = layerKey
    }
    init() {
        self.output = .not_customized_key(.not_customized)
        self.display = "none"
        self.isSFSymbol = false
        self.layerKey = .layer0
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.output =  try container.decodeIfPresent(ToKeycode.self, forKey: .output) ?? .not_customized_key(.not_customized)
        self.display =  try container.decode(String.self, forKey: .display)
        self.isSFSymbol =  try container.decodeIfPresent(Bool.self, forKey: .isSFSymbol) ?? false
        self.layerKey =  try container.decodeIfPresent(Layer.self, forKey: .layerKey) ?? .layer0
    }
}
extension OutputAndDisplay {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if output != .not_customized_key(.not_customized) { try container.encode(output, forKey: .output) }
        try container.encode(display, forKey: .display)
        if isSFSymbol { try container.encode(isSFSymbol, forKey: .isSFSymbol) }
        if layerKey != .layer0 { try container.encode(layerKey, forKey: .layerKey) }
    }
    enum CodingKeys: String, CodingKey {
        case output, display, isSFSymbol, layerKey
    }
    func applyOutputDisplay(_ oad: OutputAndDisplay) {
        self.output = oad.output
        self.display = oad.display
        self.isSFSymbol = oad.isSFSymbol
        self.layerKey = oad.layerKey
        
    }
}
