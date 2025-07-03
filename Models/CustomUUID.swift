//
//  CustomUUID.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/07.
//
import SwiftUI

struct CustomUUID: Codable, Equatable, Hashable {
    var id: UUID
    init(id: UUID) {
        self.id = id
    }

    // Equatableの実装
    static func == (lhs: CustomUUID, rhs: CustomUUID) -> Bool {
        return lhs.id == rhs.id
    }

    static func == (lhs: CustomUUID, rhs: UUID) -> Bool {
        return lhs.id == rhs
    }

    static func == (lhs: UUID, rhs: CustomUUID) -> Bool {
        return lhs == rhs.id
    }
}

