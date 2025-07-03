//
//  DeviceSections.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class DeviceSections: ObservableObject, Codable {
    var sections: Set<Devices>
    
    init(sections: Set<Devices> = [.main]) {
        self.sections = sections
    }
    
    // Codableのエンコード処理
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let sectionsArray = Array(sections)
        try container.encode(sectionsArray, forKey: .sections)
    }
    
    // Codableのデコード処理
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sectionsArray = try container.decode([Devices].self, forKey: .sections)
        sections = Set(sectionsArray)
    }
    
    // CodingKeysの定義
    private enum CodingKeys: String, CodingKey {
        case sections
    }
    
    // セクションを追加するメソッド
    func addSection(_ section: Devices) {
        objectWillChange.send()
        sections.insert(section)
    }
    
    // セクションを削除するメソッド
    func removeSection(_ section: Devices) {
        objectWillChange.send()
        sections.remove(section)
    }
    
    // セクションが存在するかチェックするメソッド
    func containsSection(_ section: Devices) -> Bool {
        return sections.contains(section)
    }
    
}
