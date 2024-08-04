//
//  Board.swift
//  Fusion
//
//  Created by Jey Starratt on 8/4/24.
//

import Foundation

/// Model for the contents current visible.
struct Board {
    /// Values presented on the board.
    var contents: [[Value]]

    // For ease of reference further down.
    var size: Int { Constants.size }

    init() {
        contents = []

        // Apply unique values into each cell.
        for _ in 0...size-1 {
            var row: [Value] = []
            for _ in 0...size-1 {
                row.append(Value(0))
            }
            contents.append(row)
        }
    }

    /// For testing, mostly.
    init(contents: [[Value]]) {
        self.contents = contents
    }

    /// Access cell by explicit row and column indices.
    subscript(_ row: Int, _ column: Int) -> Value {
        get {
            contents[row][column]
        }
        set {
            contents[row][column] = newValue
        }
    }

    /// Access cell by `Position`.
    subscript(_ p: Position) -> Value {
        get {
            self[p.row, p.column]
        }
        set {
            self[p.row, p.column] = newValue
        }
    }

    /// Flattened array of all cell `Position`s.
    var allPoints: [Position] {
        var points = [Position]()

        for row in 0...size-1 {
            for column in 0...size-1 {
                points.append(Position(row, column))
            }
        }

        return points
    }

    /// Whether or not the provided index is valid in any direction.
    func isValid(_ dimension: Int) -> Bool {
        dimension >= 0 && dimension < size
    }

    /// Whether or not the provided position is valid.
    func isValid(_ p: Position) -> Bool {
        isValid(p.row) && isValid(p.column)
    }

    /// Whether or not any cell contains a specific value.
    func contains(_ target: Int) -> Bool {
        for point in allPoints {
            if self[point].value == target {
                return true
            }
        }
        return false
    }

    /// Depending on direction, what is the "previous" point.
    /// For example: if we are swiping down, then we search from the bottom up. This means the "previous" is the one further down.
    func previousPoint(from p: Position, in direction: Direction) -> Position {
        switch direction {
        case .top:
            Position(p.row - 1, p.column)
        case .bottom:
            Position(p.row + 1, p.column)
        case .leading:
            Position(p.row, p.column - 1)
        case .trailing:
            Position(p.row, p.column + 1)
        }
    }

    /// To help with navigation of the board while searching through cells.
    /// For example: swiping up means we want to search through each row for combinations. This means we start from the top and work towards the bottom.
    func incrementInternalLoop(row: inout Int, column: inout Int, direction: Direction) {
        switch direction {
        case .top:
            row += 1
        case .bottom:
            row -= 1
        case .leading:
            column += 1
        case .trailing:
            column -= 1
        }
    }

    /// To help with navigation of the board while searching through cells.
    /// For example: swiping up means we want to check each column. We start from the first column and continue on.
    func incrementOuterLoop(row: inout Int, column: inout Int, direction: Direction) {
        switch direction {
        case .top:
            column += 1
            row = 0
        case .bottom:
            column -= 1
            row = size - 1
        case .leading:
            row += 1
            column = 0
        case .trailing:
            row -= 1
            column = size - 1
        }
    }

    /// To help with navigation of the board while searching through cells.
    /// For example: swiping up means we will start from the top row. We finish a row at the bottom.
    func isEnd(row: Int, column: Int, direction: Direction) -> Bool {
        switch direction {
        case .top:
            if row == size - 1 { return true }
        case .bottom:
            if row == 0 { return true }
        case .leading:
            if column == size - 1 { return true }
        case .trailing:
            if column == 0 { return true }
        }

        return false
    }

    /// When we encounter a zero/empty cell, we need to check if we need to "pull" any values into it as a user swipes towards an empty cell.
    ///
    /// - Parameters:
    ///   - p: The position of the zero/empty cell.
    ///   - direction: The direction of the initial swipe.
    mutating func moveZero(from p: Position, direction: Direction) {
        // If the zero is at the end of our search, then there is nothing left to "pull" from next.
        if isEnd(row: p.row, column: p.column, direction: direction) { return }

        // If we're working with rows...
        if direction == .top || direction == .bottom {
            for rowToPull in direction == .top ? Array(p.row + 1...size-1) : Array(0...p.row - 1).reversed() {
                // If a number, we will move it
                if self[rowToPull, p.column].value != 0 {
                    self[p.row, p.column] = self[rowToPull, p.column]
                    self[rowToPull, p.column] = 0

                    return
                }
            }
        // If we're working with columns...
        } else {
            for columnToPull in direction == .leading ? Array(p.column + 1...size-1) : Array(0...p.column - 1).reversed() {
                // If a number, we will move it
                if self[p.row, columnToPull].value != 0 {
                    self[p.row, p.column] = self[p.row, columnToPull]
                    self[p.row, columnToPull] = 0

                    return
                }
            }
        }
    }
}
