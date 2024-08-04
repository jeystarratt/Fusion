//
//  Position.swift
//  Fusion
//
//  Created by Jey Starratt on 8/4/24.
//

import Foundation

/// Describes the position of a cell on the game board.
struct Position {
    let row: Int
    let column: Int

    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }
}

