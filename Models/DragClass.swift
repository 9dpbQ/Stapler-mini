//
//  CustomizeKey.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/07.
//

import SwiftUI
import UniformTypeIdentifiers

struct DragClass: Codable, Transferable {
    
    var customizeKey: CustomizeKey_to? = nil
    var customizeKey_from: CustomizeKey_from? = nil

    var macro: Macro? = nil
    var toDetail: ToDetail? = nil
    var fromDetail: FromDetail? = nil
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: DragClass.self, contentType: .dragclass)
    }
}


extension UTType {
    static var dragclass: UTType { UTType(exportedAs: "com.staplermini.dragclass")}
}

//書き換えデータをドラッグしていく元のキー,
// From と To　の二種類が必要かな
final class CustomizeKey_from: Codable, Transferable, Identifiable {
    let id: UUID
    let isCustomized: Bool
    let unitSize: CGFloat
    let keyShape: KeyShape
    let output: FromKeycode//出力
    let display: String//表示シンボル
    let isUsingSFSymbol: Bool
    let helpText: String?
    
    init(
        output: FromKeycode,
        display: String? = nil,
        isUsingSFSymbol:Bool? = nil,
        unitSize: CGFloat = 1.0,
        keyShape: KeyShape = .square,
        helpText: String? = nil,
        layerKeyNumber: Layer? = nil,
        region: KeycodeRegion? = nil
    ) {
        self.id = UUID()
        self.isCustomized = true
        self.unitSize = unitSize
        self.keyShape = keyShape
        self.output = output
        self.display = display ?? output.defaultDisplayString(.ANSI).display
        self.isUsingSFSymbol = isUsingSFSymbol ?? output.defaultDisplayString(region ?? .ANSI).isSFSymbol
        self.helpText = helpText
    }
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: CustomizeKey_from.self, contentType: .customizekey_from)
    }
}

extension UTType {
    static var customizekey_from: UTType { UTType(exportedAs: "com.staplermini.customizekey_from")}
}

//書き換えデータをドラッグしていく元のキー。レイヤーキーなどもここに入るはず。
final class CustomizeKey_to: Codable, Identifiable {
    let id: UUID
    let isCustomized: Bool
    let unitSize: CGFloat
    let keyShape: KeyShape
    let output: ToKeycode//出力
    let display: String//表示シンボル
    let isUsingSFSymbol: Bool
    let layerKeyNumber: Layer?// レイヤー遷移キーにはそのレイヤーを入れる
    let helpText: String?
    
    init(
        output: ToKeycode,
        display: String? = nil,
        isUsingSFSymbol:Bool? = nil,
        unitSize: CGFloat = 1.0,
        keyShape: KeyShape = .square,
        helpText: String? = nil,
        layerKeyNumber: Layer? = nil
    ) {
        self.id = UUID()
        self.isCustomized = true
        self.unitSize = unitSize
        self.keyShape = keyShape
        self.output = output
        self.display = display ?? output.defaultDisplayString().display
        self.isUsingSFSymbol = isUsingSFSymbol ?? output.defaultDisplayString().isSFSymbol
        self.layerKeyNumber = layerKeyNumber
        self.helpText = helpText
    }
}



