//
//  MacroCollection.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/07.
//
import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@Model
final class MacroCollection: Identifiable, ObservableObject, Codable {
    
    @Relationship(inverse: \Macro.array)
    private var _collection: [Macro]
    
    @Relationship(deleteRule: .cascade)
    var MacroArray: [Macro] = []
    
    private var idsInOrderCollection: [CustomUUID]
    
    var collection: [Macro] {
        get {
            return getSortedArray(from: _collection, using: idsInOrderCollection)
        }
        set {
            idsInOrderCollection = newValue.map { CustomUUID(id: $0.id) }
            _collection = newValue
        }
    }
    
    
    
    // MARK: - Initializers
    init(collection: [Macro] = []) {
        self._collection = []
        self.idsInOrderCollection = []
        self.collection = collection
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._collection = try container.decode([Macro].self, forKey: ._collection)
        self.idsInOrderCollection = try container.decode([CustomUUID].self, forKey: .idsInOrderCollection)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_collection, forKey: ._collection)
        try container.encode(idsInOrderCollection, forKey: .idsInOrderCollection)
    }
    
    enum CodingKeys: String, CodingKey {
        case _collection, idsInOrderCollection
    }
    
    // MARK: - Methods
    private func getSortedArray(from array: [Macro], using order: [CustomUUID]) -> [Macro] {
        var sortedCollection = [Macro]()
        var elementsToCheck = array
        
        for id in order {
            guard let idx = elementsToCheck.firstIndex(where: { $0.id == id.id }) else { continue }
            sortedCollection.append(elementsToCheck[idx])
            elementsToCheck.remove(at: idx)
        }
        
        return sortedCollection
    }
    
    func addMacro(_ macro: Macro) {
        guard !_collection.contains(where: { $0.id == macro.id }) else {
            print("Macro already exists in the collection!")
            return
        }
        _collection.append(macro)
        idsInOrderCollection.append(CustomUUID(id: macro.id))
    }
    
    func removeMacro(byId id: UUID) {
        guard let index = _collection.firstIndex(where: { $0.id == id }) else {
            print("Macro with specified ID not found!")
            return
        }
        _collection.remove(at: index)
        idsInOrderCollection.removeAll { $0.id == id }
    }
    
    // IDを指定してMacroを取得するメソッド
    func getMacro(byId id: UUID?) -> Macro? {
        return collection.first { $0.id == id }
    }
    
    func getMacro_includeStoredMacros(_ id_or_key: String) -> Macro? {
        if let macro = StoredMacroDictionary.allMacros[id_or_key] {
            return macro
        }
        if let uuid = UUID(uuidString: id_or_key) {
            return collection.first { $0.id == uuid }
        }
        return nil
    }

    
}

@Model
final class Macro: Identifiable, ObservableObject, Codable {
    var id: UUID
    var name: String
    var dictionary_key: String?
    var toDetailCollection: ToDetail_macroCollection
    
    @Relationship(deleteRule: .nullify)
    var array: MacroCollection?
    
    init(name: String = "user Macro", dictionary_key: String? = nil, toDetailCollection: ToDetail_macroCollection = ToDetail_macroCollection()) {
        self.id = UUID()
        self.name = name
        self.dictionary_key = dictionary_key
        self.toDetailCollection = toDetailCollection
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.dictionary_key = try container.decodeIfPresent(String.self, forKey: .dictionary_key)
        self.toDetailCollection = try container.decode(ToDetail_macroCollection.self, forKey: .toDetailCollection)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id) // ToDetail と共有しているので変更せず
        try container.encode(name, forKey: .name)
        try container.encode(dictionary_key, forKey: .dictionary_key)
        try container.encode(toDetailCollection, forKey: .toDetailCollection)
    }
    enum CodingKeys: String, CodingKey {
        case id, name, dictionary_key, toDetailCollection
    }
}

extension Macro {
    static let initialMacro = Macro()
    
    /// Macroを引数に、インデックスの場所に追加する関数
    func insert_macro(_ macro: Macro, at index: Int) {
        if (index >= 0) && (index + 1 <= self.toDetailCollection.collection.count) {
            self.toDetailCollection.collection.insert(contentsOf: macro.toDetailCollection.collection, at: index)
        } else {
            print("無効なインデックス")
        }
    }
}



@Model
final class ToDetail_macroCollection: Identifiable, ObservableObject, Codable {
    @Relationship(inverse: \ToDetail_macro.array)
    private var _collection: [ToDetail_macro]
    
    @Relationship(deleteRule: .cascade)
    var toDetail_macroArray: [ToDetail_macro] = []
    
    private var idsInOrderCollection: [CustomUUID]
    
    var collection: [ToDetail_macro] {
        get {
            return getSortedArray(from: _collection, using: idsInOrderCollection)
        }
        set {
            idsInOrderCollection = newValue.map { CustomUUID(id: $0.id) }
            _collection = newValue
        }
    }
    
    // MARK: - Initializers
    init(collection: [ToDetail_macro] = []) {
        self._collection = []
        self.idsInOrderCollection = []
        self.collection = collection
    }
    
    // MARK: - Codable Implementation
    enum CodingKeys: String, CodingKey {
        case _collection, idsInOrderCollection
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._collection = try container.decode([ToDetail_macro].self, forKey: ._collection)
        self.idsInOrderCollection = try container.decode([CustomUUID].self, forKey: .idsInOrderCollection)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_collection, forKey: ._collection)
        try container.encode(idsInOrderCollection, forKey: .idsInOrderCollection)
    }
    
    // MARK: - Methods
    private func getSortedArray(from array: [ToDetail_macro], using order: [CustomUUID]) -> [ToDetail_macro] {
        var sortedCollection = [ToDetail_macro]()
        var elementsToCheck = array
        
        for id in order {
            guard let idx = elementsToCheck.firstIndex(where: { $0.id == id.id }) else { continue }
            sortedCollection.append(elementsToCheck[idx])
            elementsToCheck.remove(at: idx)
        }
        
        return sortedCollection
    }
}



@Model
final class ToDetail_macro: Identifiable, ObservableObject, Codable {
    var id: UUID
    var outputAndDisplay: OutputAndDisplay
    var withModifier: WithModifier
    var indicator: Bool
    var error: Bool
    
    @Relationship(deleteRule: .nullify)
    var array: ToDetail_macroCollection?
    
    init(output: ToKeycode, display: String? = nil, isSFSymbol: Bool? = nil) {
        self.id = UUID()
        self.outputAndDisplay = OutputAndDisplay(output: output, display: display ?? output.defaultDisplayString().display, isSFSymbol: isSFSymbol ?? output.defaultDisplayString().isSFSymbol)
        self.withModifier = WithModifier()
        self.error = false
        self.indicator = false
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.outputAndDisplay = try container.decode(OutputAndDisplay.self, forKey: .outputAndDisplay)
        self.withModifier = try container.decode(WithModifier.self, forKey: .withModifier)
        self.error = try container.decode(Bool.self, forKey: .error)
        self.indicator = try container.decode(Bool.self, forKey: .indicator)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id) // 配列とリンクしているので変更せず、する場合はその配列とすり合わせる処理が必要
        try container.encode(outputAndDisplay, forKey: .outputAndDisplay)
        try container.encode(withModifier, forKey: .withModifier)
        try container.encode(error, forKey: .error)
        try container.encode(indicator, forKey: .indicator)
    }
    enum CodingKeys: String, CodingKey {
        case id, outputAndDisplay, withModifier, error, indicator
    }
}

extension ToDetail_macro {
    static let initialToDetail_macro: ToDetail_macro = ToDetail_macro(output: .letter_keys(.a), display: "none", isSFSymbol: false)
    
    func applyTap(_ outputAndDisplay: OutputAndDisplay, withModifier: WithModifier = WithModifier()) {
        self.outputAndDisplay.applyOutputDisplay(outputAndDisplay)
        self.withModifier.applyWithModifier(withModifier)
    }
}

extension ToDetail_macro: Equatable {
    static func == (lhs: ToDetail_macro, rhs: ToDetail_macro) -> Bool {
        return lhs.id == rhs.id
    }
}

