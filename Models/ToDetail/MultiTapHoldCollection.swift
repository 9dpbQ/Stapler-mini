//
//  MultiTapHoldCollection.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

@Model
final class MultiTapHoldCollection: Identifiable, ObservableObject, Codable {
    @Relationship(inverse: \ToDetail_multi.array)
    private var _collection: [ToDetail_multi]
    
    @Relationship(deleteRule: .cascade)
    var toDetail_multArray: [ToDetail_multi] = []
    
    private var idsInOrderCollection: [CustomUUID]
    
    var collection: [ToDetail_multi] {
        get {
            return getSortedArray(from: _collection, using: idsInOrderCollection)
        }
        set {
            idsInOrderCollection = newValue.map { CustomUUID(id: $0.id) }
            _collection = newValue
        }
    }
    
    
    
    // MARK: - Initializers
    init() {
        self._collection = []
        self.idsInOrderCollection = []
    }
    
    // MARK: - Codable Implementation
    enum CodingKeys: String, CodingKey {
        case _collection, idsInOrderCollection
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._collection = try container.decode([ToDetail_multi].self, forKey: ._collection)
        self.idsInOrderCollection = try container.decode([CustomUUID].self, forKey: .idsInOrderCollection)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_collection, forKey: ._collection)
        try container.encode(idsInOrderCollection, forKey: .idsInOrderCollection)
    }
    
    // MARK: - Methods
    private func getSortedArray(from array: [ToDetail_multi], using order: [CustomUUID]) -> [ToDetail_multi] {
        var sortedCollection = [ToDetail_multi]()
        var elementsToCheck = array
        
        for id in order {
            guard let idx = elementsToCheck.firstIndex(where: { $0.id == id.id }) else { continue }
            sortedCollection.append(elementsToCheck[idx])
            elementsToCheck.remove(at: idx)
        }
        
        return sortedCollection
    }
    
    func addMulti(_ multi: ToDetail_multi) {
        guard !_collection.contains(where: { $0.id == multi.id }) else {
            print("Macro already exists in the collection!")
            return
        }
        _collection.append(multi)
        idsInOrderCollection.append(CustomUUID(id: multi.id))
    }
    
    func removeMulti(byId id: UUID) {
        guard let index = _collection.firstIndex(where: { $0.id == id }) else {
            print("Macro with specified ID not found!")
            return
        }
        _collection.remove(at: index)
        idsInOrderCollection.removeAll { $0.id == id }
    }
}
