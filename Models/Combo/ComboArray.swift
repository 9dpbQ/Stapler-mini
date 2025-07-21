//
//  ComboArray.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class ComboArray: ObservableObject, Codable {
    
    @Relationship(inverse: \Combo.array)
    private var _array: [Combo]
    
    private var idsInOrderCollection: [CustomUUID]
    
    var array: [Combo] {
        get {
            return getSortedArray(from: _array, using: idsInOrderCollection)
        }
        set {
            updateArray(with: newValue)
        }
    }
    
    @Relationship(deleteRule: .cascade)
    var comboDetailArray: [Combo] = []
    
    init(collection: [Combo] = []) {
        self._array = collection
        self.idsInOrderCollection = collection.map { CustomUUID(id: $0.id) }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._array = try container.decode([Combo].self, forKey: ._collection)
        self.idsInOrderCollection = try container.decode([CustomUUID].self, forKey: .idsInOrderCollection)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_array, forKey: ._collection)
        try container.encode(idsInOrderCollection, forKey: .idsInOrderCollection)
    }
    
    // 既存のgetSortedArray関数はそのまま
    private func getSortedArray(from array: [Combo], using order: [CustomUUID]) -> [Combo] {
        var sortedCollection = [Combo]()
        var elementsToCheck = array
        
        for id in order {
            if let index = elementsToCheck.firstIndex(where: { $0.id == id.id }) {
                sortedCollection.append(elementsToCheck[index])
                elementsToCheck.remove(at: index)
            }
        }
        return sortedCollection
    }
    
    // 新規追加: 配列を更新するメソッド
    private func updateArray(with newValue: [Combo]) {
        _array = newValue
        idsInOrderCollection = newValue.map { CustomUUID(id: $0.id) }
    }
    
    // 新規追加: コンボを追加するメソッド
    func addCombo(_ combo: Combo) {
        // 重複を避けるためにチェック
        guard !_array.contains(where: { $0.id == combo.id }) else { return }
        
        _array.append(combo)
        idsInOrderCollection.append(CustomUUID(id: combo.id))
    }
    
    // 新規追加: IDを指定してコンボを削除するメソッド
    func removeCombo(byId id: UUID) {
        if let index = _array.firstIndex(where: { $0.id == id }) {
            _array.remove(at: index)
            idsInOrderCollection.removeAll { $0.id == id }
        }
    }
    
    // 新規追加: インデックスを指定してコンボを削除するメソッド
    func removeCombo(at index: Int) {
        guard index >= 0 && index < _array.count else { return }
        let removedCombo = _array[index]
        _array.remove(at: index)
        idsInOrderCollection.removeAll { $0.id == removedCombo.id }
    }
    
    // 新規追加: コンボを特定のインデックスに挿入するメソッド
    func insertCombo(_ combo: Combo, at index: Int) {
        guard !_array.contains(where: { $0.id == combo.id }) else { return }
        
        // インデックスが範囲外の場合は末尾に追加
        if index >= _array.count {
            _array.append(combo)
            idsInOrderCollection.append(CustomUUID(id: combo.id))
        } else {
            _array.insert(combo, at: index)
            idsInOrderCollection.insert(CustomUUID(id: combo.id), at: index)
        }
    }
    
    // 新規追加: 特定のコンボを置き換えるメソッド
    func replaceCombo(_ combo: Combo) {
        if let index = _array.firstIndex(where: { $0.id == combo.id }) {
            _array[index] = combo
            // idsInOrderCollectionは変更不要（同じIDを使用）
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _collection, idsInOrderCollection
    }
    
    var bindingArray: Binding<[Combo]> {
        Binding(
            get: { self.array },
            set: { self.array = $0 }
        )
    }
}
