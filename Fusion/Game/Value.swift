//
//  Value.swift
//  Fusion
//
//  Created by Jey Starratt on 8/4/24.
//

import Foundation

/// Describes a value on the game board.
struct Value: ExpressibleByIntegerLiteral {
    /// To assist with animations.
    let id: UUID

    /// The value stored in that cell.
    var value: Int

    init(_ id: UUID, _ value: Int) {
        self.id = UUID()
        self.value = value
    }

    init(integerLiteral: Int) {
        self.id = UUID()
        self.value = integerLiteral
    }
}
