//
//  WithModifier.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class WithModifier: Identifiable, ObservableObject, Codable {
    var isWithModifier: Bool = false
    var isWithShift: Bool = false
    var isWithControl: Bool = false
    var isWithCommand: Bool = false
    var isWithOption: Bool = false
    var isWithFunction: Bool = false
    init() {
        self.isWithModifier = false
        self.isWithShift = false
        self.isWithControl = false
        self.isWithCommand = false
        self.isWithOption = false
        self.isWithFunction = false
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isWithModifier =  try container.decodeIfPresent(Bool.self, forKey: .isWithModifier) ?? false
        self.isWithShift =  try container.decodeIfPresent(Bool.self, forKey: .isWithShift) ?? false
        self.isWithControl =  try container.decodeIfPresent(Bool.self, forKey: .isWithControl) ?? false
        self.isWithCommand =  try container.decodeIfPresent(Bool.self, forKey: .isWithCommand) ?? false
        self.isWithOption =  try container.decodeIfPresent(Bool.self, forKey: .isWithOption) ?? false
        self.isWithFunction =  try container.decodeIfPresent(Bool.self, forKey: .isWithFunction) ?? false
    }
}
extension WithModifier {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if isWithModifier { try container.encode(isWithModifier, forKey: .isWithModifier) }
        if isWithShift { try container.encode(isWithShift, forKey: .isWithShift) }
        if isWithControl { try container.encode(isWithControl, forKey: .isWithControl) }
        if isWithCommand { try container.encode(isWithCommand, forKey: .isWithCommand) }
        if isWithOption { try container.encode(isWithOption, forKey: .isWithOption) }
        if isWithFunction { try container.encode(isWithFunction, forKey: .isWithFunction) }
    }
    enum CodingKeys: String, CodingKey {
        case isWithModifier, isWithShift, isWithControl, isWithCommand, isWithOption, isWithFunction
    }
    func applyWithModifier(_ mod: WithModifier) {
        self.isWithModifier = mod.isWithModifier
        self.isWithShift = mod.isWithShift
        self.isWithControl = mod.isWithControl
        self.isWithCommand = mod.isWithCommand
        self.isWithOption = mod.isWithOption
        self.isWithFunction = mod.isWithFunction
    }
}
