//
//  Rows.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//

import SwiftUI
import SwiftData




@Model
final class Rows: ObservableObject, Codable {
    
    @Relationship(inverse: \KeyboardKey.row1)
    private var _row1: [KeyboardKey] 
    
    @Relationship(inverse: \KeyboardKey.row2)
    private var _row2: [KeyboardKey]
    
    @Relationship(inverse: \KeyboardKey.row3)
    private var _row3: [KeyboardKey]
    
    @Relationship(inverse: \KeyboardKey.row4)
    private var _row4: [KeyboardKey]
    
    @Relationship(inverse: \KeyboardKey.row5)
    private var _row5: [KeyboardKey]
    
    @Relationship(inverse: \KeyboardKey.row6)
    private var _row6: [KeyboardKey]
    
    @Relationship(deleteRule: .cascade)
    var rows: [KeyboardKey] = []
        
    private var idsInOrderRow1: [CustomUUID]
    private var idsInOrderRow2: [CustomUUID]
    private var idsInOrderRow3: [CustomUUID]
    private var idsInOrderRow4: [CustomUUID]
    private var idsInOrderRow5: [CustomUUID]
    private var idsInOrderRow6: [CustomUUID]
    
    var row1: [KeyboardKey] {
        get { getSortedArray(from: _row1, using: idsInOrderRow1) }
        set { updateRow(&_row1, ids: &idsInOrderRow1, with: newValue) }
    }
    var row2: [KeyboardKey] {
        get { getSortedArray(from: _row2, using: idsInOrderRow2) }
        set { updateRow(&_row2, ids: &idsInOrderRow2, with: newValue) }
    }
    var row3: [KeyboardKey] {
        get { getSortedArray(from: _row3, using: idsInOrderRow3) }
        set { updateRow(&_row3, ids: &idsInOrderRow3, with: newValue) }
    }
    var row4: [KeyboardKey] {
        get { getSortedArray(from: _row4, using: idsInOrderRow4) }
        set { updateRow(&_row4, ids: &idsInOrderRow4, with: newValue) }
    }
    var row5: [KeyboardKey] {
        get { getSortedArray(from: _row5, using: idsInOrderRow5) }
        set { updateRow(&_row5, ids: &idsInOrderRow5, with: newValue) }
    }
    var row6: [KeyboardKey] {
        get { getSortedArray(from: _row6, using: idsInOrderRow6) }
        set { updateRow(&_row6, ids: &idsInOrderRow6, with: newValue) }
    }
    
    var enableArrowKeys: Bool
    var rowIndex_arrow: RowIndex
    var arrow_left: KeyboardKey
    var arrow_up: KeyboardKey
    var arrow_down: KeyboardKey
    var arrow_right: KeyboardKey
    
    
    var row1isNotEmpty: Bool {
        !row1.isEmpty || (enableArrowKeys && rowIndex_arrow == .row1)
    }
    var row2isNotEmpty: Bool {
        !row2.isEmpty || (enableArrowKeys && rowIndex_arrow == .row2)
    }
    var row3isNotEmpty: Bool {
        !row3.isEmpty || (enableArrowKeys && rowIndex_arrow == .row3)
    }
    var row4isNotEmpty: Bool {
        !row4.isEmpty || (enableArrowKeys && rowIndex_arrow == .row4)
    }
    var row5isNotEmpty: Bool {
        !row5.isEmpty || (enableArrowKeys && rowIndex_arrow == .row5)
    }
    var row6isNotEmpty: Bool {
        !row6.isEmpty || (enableArrowKeys && rowIndex_arrow == .row6)
    }
    
    // MARK: - Initializers
    init(
        row1: [KeyboardKey] = [KeyboardKey(output: .letter_keys(.a))],
        row2: [KeyboardKey] = [KeyboardKey(output: .letter_keys(.a))],
        row3: [KeyboardKey] = [KeyboardKey(output: .letter_keys(.a))],
        row4: [KeyboardKey] = [KeyboardKey(output: .letter_keys(.a))],
        row5: [KeyboardKey] = [KeyboardKey(output: .letter_keys(.a))],
        row6: [KeyboardKey] = [KeyboardKey(output: .letter_keys(.a))],
        enableArrowKeys: Bool = false,
        rowIndex_arrow: RowIndex = .row6,
        product_id: String? = nil,
        vendor_id: String? = nil
    ) {
        self._row1 = row1
        self._row2 = row2
        self._row3 = row3
        self._row4 = row4
        self._row5 = row5
        self._row6 = row6
        
        self.idsInOrderRow1 = row1.map { CustomUUID(id: $0.id) }
        self.idsInOrderRow2 = row2.map { CustomUUID(id: $0.id) }
        self.idsInOrderRow3 = row3.map { CustomUUID(id: $0.id) }
        self.idsInOrderRow4 = row4.map { CustomUUID(id: $0.id) }
        self.idsInOrderRow5 = row5.map { CustomUUID(id: $0.id) }
        self.idsInOrderRow6 = row6.map { CustomUUID(id: $0.id) }
        
        self.enableArrowKeys = enableArrowKeys
        self.rowIndex_arrow = rowIndex_arrow
        
        self.arrow_left = KeyboardKey(output: .arrow_keys(.left_arrow), keyShape: .arrow_LR)
        self.arrow_up = KeyboardKey(output: .arrow_keys(.up_arrow), keyShape: .arrow_Up)
        self.arrow_down = KeyboardKey(output: .arrow_keys(.down_arrow), keyShape: .arrow_Down)
        self.arrow_right = KeyboardKey(output: .arrow_keys(.right_arrow), keyShape: .arrow_LR)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.sectionDetail = try container.decode(KeyboardSectionDetail.self, forKey: .sectionDetail)
        self._row1 = try container.decode([KeyboardKey].self, forKey: .row1)
        self._row2 = try container.decode([KeyboardKey].self, forKey: .row2)
        self._row3 = try container.decode([KeyboardKey].self, forKey: .row3)
        self._row4 = try container.decode([KeyboardKey].self, forKey: .row4)
        self._row5 = try container.decode([KeyboardKey].self, forKey: .row5)
        self._row6 = try container.decode([KeyboardKey].self, forKey: .row6)
        
        self.idsInOrderRow1 = try container.decode([CustomUUID].self, forKey: .idsInOrderRow1)
        self.idsInOrderRow2 = try container.decode([CustomUUID].self, forKey: .idsInOrderRow2)
        self.idsInOrderRow3 = try container.decode([CustomUUID].self, forKey: .idsInOrderRow3)
        self.idsInOrderRow4 = try container.decode([CustomUUID].self, forKey: .idsInOrderRow4)
        self.idsInOrderRow5 = try container.decode([CustomUUID].self, forKey: .idsInOrderRow5)
        self.idsInOrderRow6 = try container.decode([CustomUUID].self, forKey: .idsInOrderRow6)
        
        self.enableArrowKeys = try container.decode(Bool.self, forKey: .enableArrowKeys)
        self.rowIndex_arrow = try container.decode(RowIndex.self, forKey: .rowIndex_arrow)
        self.arrow_left = try container.decode(KeyboardKey.self, forKey: .arrow_left)
        self.arrow_up = try container.decode(KeyboardKey.self, forKey: .arrow_up)
        self.arrow_down = try container.decode(KeyboardKey.self, forKey: .arrow_down)
        self.arrow_right = try container.decode(KeyboardKey.self, forKey: .arrow_right)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(sectionDetail, forKey: .sectionDetail)
        try container.encode(_row1, forKey: .row1)
        try container.encode(_row2, forKey: .row2)
        try container.encode(_row3, forKey: .row3)
        try container.encode(_row4, forKey: .row4)
        try container.encode(_row5, forKey: .row5)
        try container.encode(_row6, forKey: .row6)
        try container.encode(idsInOrderRow1, forKey: .idsInOrderRow1)
        try container.encode(idsInOrderRow2, forKey: .idsInOrderRow2)
        try container.encode(idsInOrderRow3, forKey: .idsInOrderRow3)
        try container.encode(idsInOrderRow4, forKey: .idsInOrderRow4)
        try container.encode(idsInOrderRow5, forKey: .idsInOrderRow5)
        try container.encode(idsInOrderRow6, forKey: .idsInOrderRow6)
        
        try container.encode(enableArrowKeys, forKey: .enableArrowKeys)
        try container.encode(rowIndex_arrow, forKey: .rowIndex_arrow)
        try container.encode(arrow_left, forKey: .arrow_left)
        try container.encode(arrow_up, forKey: .arrow_up)
        try container.encode(arrow_down, forKey: .arrow_down)
        try container.encode(arrow_right, forKey: .arrow_right)
    }
    
    enum CodingKeys: String, CodingKey {
        case sectionDetail
        case row1, row2, row3, row4, row5, row6
        case idsInOrderRow1, idsInOrderRow2, idsInOrderRow3, idsInOrderRow4, idsInOrderRow5, idsInOrderRow6
        case enableArrowKeys, rowIndex_arrow,arrow_left, arrow_up, arrow_down, arrow_right
    }
    
    // MARK: - Helper Methods
    private func getSortedArray(from array: [KeyboardKey], using order: [CustomUUID]) -> [KeyboardKey] {
        var sorted = [KeyboardKey]()
        var remaining = array
        
        for id in order {
            if let index = remaining.firstIndex(where: { $0.id == id.id }) {
                sorted.append(remaining[index])
                remaining.remove(at: index)
            }
        }
        return sorted
    }
    
    private func updateRow(_ row: inout [KeyboardKey], ids: inout [CustomUUID], with newValue: [KeyboardKey]) {
        row = newValue
        ids = newValue.map { CustomUUID(id: $0.id) }
    }
    
    /// 引数のRow以降が空でない場合True,以降が空ならfalse
    func afterRowIsNotEmpty(_ rowIndex: RowIndex) -> Bool {
        switch rowIndex {
        case .row1:
            row2isNotEmpty || row3isNotEmpty || row4isNotEmpty || row5isNotEmpty || row6isNotEmpty
        case .row2:
            row3isNotEmpty || row4isNotEmpty || row5isNotEmpty || row6isNotEmpty
        case .row3:
            row4isNotEmpty || row5isNotEmpty || row6isNotEmpty
        case .row4:
            row5isNotEmpty || row6isNotEmpty
        case .row5:
            row6isNotEmpty
        case .row6:
            false
        }
    }
    func allKeyboardKeys() -> [KeyboardKey] {
        var rows: [[KeyboardKey]] = [row1, row2, row3, row4, row5, row6]
        
        // Arrowキーが有効な場合、指定された位置にArrowキーを挿入
        if enableArrowKeys {
            let arrowKeys = [arrow_left, arrow_up, arrow_down, arrow_right]
            if let arrowInsertIndex = RowIndex.allCases.firstIndex(of: rowIndex_arrow), arrowInsertIndex + 1 < rows.count {
                rows.insert(arrowKeys, at: arrowInsertIndex + 1)
            } else {
                rows.append(arrowKeys) // デフォルトで最後に挿入
            }
        }
        // フラット化して [KeyboardKey] を返す
        return rows.flatMap { $0 }
    }

    func getRowKeyboardKeys(_ rowIndex: RowIndex) -> Binding<[KeyboardKey]> {
        switch rowIndex {
        case .row1:
            return  Binding(
                get: { self.row1 },
                set: { newValue in
                    self.row1 = newValue
                }
            )
        case .row2:
            return  Binding(
                get: { self.row2 },
                set: { newValue in
                    self.row2 = newValue
                }
            )
        case .row3:
            return  Binding(
                get: { self.row3 },
                set: { newValue in
                    self.row3 = newValue
                }
            )
        case .row4:
            return  Binding(
                get: { self.row4 },
                set: { newValue in
                    self.row4 = newValue
                }
            )
        case .row5:
            return  Binding(
                get: { self.row5 },
                set: { newValue in
                    self.row5 = newValue
                }
            )
        case .row6:
            return  Binding(
                get: { self.row6 },
                set: { newValue in
                    self.row6 = newValue
                }
            )
        }
    }
    
    func sumOfUnitSize(rowIndex: RowIndex) -> Double {
        let row = getRowKeyboardKeys(rowIndex)
        var size: Double = row.wrappedValue.reduce(0.0) { $0 + $1.unitSize }
        if enableArrowKeys && rowIndex_arrow == rowIndex { // Arrowが有効なら3を足す
            size += 3
        }
        return size
    }
    
    func maximumUnitSize_horizontal() -> Double {
        var size: Double = 0
        for rowIndex in RowIndex.allCases {
            let currentUnitSize = sumOfUnitSize(rowIndex: rowIndex)
            if size < currentUnitSize {
                size = currentUnitSize
            }
        }
        return size
    }
    
    func verticalUnitSize() -> CGFloat {
        if row6isNotEmpty {
            return 6
        } else if row5isNotEmpty {
            return 5
        } else if row4isNotEmpty {
            return 4
        } else if row3isNotEmpty {
            return 3
        } else if row2isNotEmpty {
            return 2
        } else {
            return 1
        }
    }
    
    func removeKey(at keyIndex: Int, from rowIndex: RowIndex) {
        switch rowIndex {
        case .row1: row1.remove(at: keyIndex)
        case .row2: row2.remove(at: keyIndex)
        case .row3: row3.remove(at: keyIndex)
        case .row4: row4.remove(at: keyIndex)
        case .row5: row5.remove(at: keyIndex)
        case .row6: row6.remove(at: keyIndex)
        }
    }
    
    func removeKey_of(of keyboardKey: KeyboardKey, from rowIndex: RowIndex) {
        switch rowIndex {
        case .row1: row1.removeAll(where: { $0 == keyboardKey })
        case .row2: row2.removeAll(where: { $0 == keyboardKey })
        case .row3: row3.removeAll(where: { $0 == keyboardKey })
        case .row4: row4.removeAll(where: { $0 == keyboardKey })
        case .row5: row5.removeAll(where: { $0 == keyboardKey })
        case .row6: row6.removeAll(where: { $0 == keyboardKey })
        }
    }
    
    func appendKey(_ newKey: KeyboardKey, from rowIndex: RowIndex) {
        switch rowIndex {
        case .row1: row1.append(newKey)
        case .row2: row2.append(newKey)
        case .row3: row3.append(newKey)
        case .row4: row4.append(newKey)
        case .row5: row5.append(newKey)
        case .row6: row6.append(newKey)
        }
    }
    func insertKey(_ newKey: KeyboardKey, from rowIndex: RowIndex, at index: Int) {
        switch rowIndex {
        case .row1: row1.insert(newKey, at: index)
        case .row2: row2.insert(newKey, at: index)
        case .row3: row3.insert(newKey, at: index)
        case .row4: row4.insert(newKey, at: index)
        case .row5: row5.insert(newKey, at: index)
        case .row6: row6.insert(newKey, at: index)
        }
    }
    
    func allRows_omittingSpacer() -> [KeyboardKey] {
        var rows: [[KeyboardKey]] = [row1, row2, row3, row4, row5, row6].map { row in
            row.filter { !$0.isSpacer }
        }
        // Arrowキーが有効な場合、指定された位置にArrowキーを挿入
        if enableArrowKeys {
            let arrowKeys = [arrow_left, arrow_up, arrow_down, arrow_right]
            if let arrowInsertIndex = RowIndex.allCases.firstIndex(of: rowIndex_arrow), arrowInsertIndex + 1 < rows.count {
                rows.insert(arrowKeys, at: arrowInsertIndex + 1)
            } else {
                rows.append(arrowKeys) // デフォルトで最後に挿入
            }
        }
        // フラット化して [KeyboardKey] を返す
        return rows.flatMap { $0 }
    }
}
