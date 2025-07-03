//
//  FromDetail.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class FromDetail: Identifiable, ObservableObject, Codable {
    var id: UUID
    
    var output: FromKeycode
    var display: String
    var isSFSymbol: Bool
    
    init(output: FromKeycode, display: String? = nil, isSFSymbol: Bool? = nil, region: KeycodeRegion = .ANSI) {
        self.id = UUID()
        self.output = output
        self.display = display ?? output.defaultDisplayString(region).display
        self.isSFSymbol = isSFSymbol ?? output.defaultDisplayString(region).isSFSymbol
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.output = try container.decode(FromKeycode.self, forKey: .output)
        self.display = try container.decode(String.self, forKey: .display)
        self.isSFSymbol = try container.decodeIfPresent(Bool.self, forKey: .isSFSymbol) ?? false
    }
}
extension FromDetail {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(output, forKey: .output)
        try container.encode(display, forKey: .display)
        if isSFSymbol { try container.encode(isSFSymbol, forKey: .isSFSymbol) }
    }
    enum CodingKeys: String, CodingKey {
        case id, output, display, isSFSymbol
    }
}
