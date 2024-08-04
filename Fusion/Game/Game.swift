//
//  Game.swift
//  Fusion
//
//  Created by Jey Starratt on 8/4/24.
//

import Foundation
import Observation

@Observable
class Game {
    /// For user-facing messaging.
    enum State {
        case ongoing
        case success
        case failure

        var title: String {
            switch self {
            case .ongoing:
                "Keep It Up 💪" // Shouldn't show anyway
            case .success:
                "Nicely Done 🎉"
            case .failure:
                "A Noble Attempt 👍"
            }
        }

        var message: String {
            switch self {
            case .ongoing:
                "Fortune favors the bold." // Shouldn't show anyway
            case .success:
                "You hit the target!"
            case .failure:
                "Better luck in your next round."
            }
        }
    }

    /// What state is the game in?
    var state: State = .ongoing

    /// Do we need to show an alert?
    var showAlert: Bool {
        get {
            state == .success || state == .failure
        }
        set {
            if newValue == false {
                state = .ongoing
            } else {
                // Ignoring...
            }
        }
    }

    // For ease of reference.
    var size: Int { Constants.size }

    /// Contents of the game.
    var board: Board

    /// What number do we need to reach for success?
    let currentTarget: Int

    /// Do we want to add more boxes or use pre-set ones?
    let debug: Bool

    init(currentTarget: Int = 128, debug: Bool = false, board: Board = Board()) {
        self.currentTarget = currentTarget
        self.board = board
        self.debug = debug

        _ = insertNextBox()
        _ = insertNextBox()
    }

    /// Clears the board's contents and preps for another round.
    func restart() {
        self.board = Board()

        _ = insertNextBox()
        _ = insertNextBox()
    }

    /// If possible, inserts another box in a random location.
    func insertNextBox() -> Bool {
        // If we are in debug, we don't want additional boxes (e.g., testing).
        guard debug == false else { return true }

        // Searching for a random, "open" spot.
        guard let randomPoint = board.allPoints.filter({
            board[$0].value == 0
        }).randomElement() else { return false }

        // Insert a small random value.
        board[randomPoint] = [2, 4].randomElement()!

        return true
    }

    /// Attempts to combine two different cells into a single one. If successful, "from" will be zero.
    /// - Parameters:
    ///   - from: The original point that is being compared to be moved _from_.
    ///   - to: The point that the combination will be moved _to_.
    /// - Returns: Whether or not the combination was successful.
    private func attemptToCombine(from: Position, to: Position) -> Bool {
        // If these are valid points and the values match...
        guard board.isValid(from) && board.isValid(to) && board[to].value == board[from].value else { return false }

        // Combine the values and "reset" the from cell.
        board[to] = Value(board[from].id, board[from].value + board[from].value)
        board[from] = 0

        return true
    }

    /// Shuffles the numbers in accordance with a particular direction (combination of column/row and top/bottom).
    ///
    /// - Parameters:
    ///   - direction: Where we are "pushing" numbers towards
    func swiped(towards direction: Direction) {
        var row = direction.firstRow
        var column = direction.firstColumn

        // Outer loop: the dimension we *are not* looking for combinations in.
        while (direction == .top || direction == .bottom) ? board.isValid(column) : board.isValid(row) {
            // Inner loop: the dimension we *are* looking for combinations in.
            while (direction == .top || direction == .bottom) ? board.isValid(row) : board.isValid(column) {
                // As we search, we also want to ensure we move along.
                defer {
                    board.incrementInternalLoop(row: &row, column: &column, direction: direction)
                }

                // If a number...
                if board[row, column].value != 0 {
                    // Grab the previous point.
                    let previous = board.previousPoint(from: Position(row, column), in: direction)

                    // Attempt to combine with the previous number
                    if attemptToCombine(from: Position(row, column), to: previous) {
                        // If successful, see if we can replace leftover zero with someone else (but do not combine).
                        board.moveZero(from: Position(row, column), direction: direction)

                        continue
                    } else {
                        // If it doesn't combine, then we also move along.
                        continue
                    }
                } else {
                    // For zeros, we look for the next non-zero and pull it to current spot.
                    board.moveZero(from: Position(row, column), direction: direction)

                    // Then attempt to combine with previous.
                    let previous = board.previousPoint(from: Position(row, column), in: direction)
                    if attemptToCombine(from: Position(row, column), to: previous) {
                        // If we were able to combine, then we have another zero to handle.
                        board.moveZero(from: Position(row, column), direction: direction)
                    }
                }
            }

            // As we search, we also want to ensure we move along.
            board.incrementOuterLoop(row: &row, column: &column, direction: direction)
        }

        // Once the dust settles, do we have our target?
        if board.contains(currentTarget) {
            state = .success
        // TODO: check for any combo opportunities first
        // If we can't make another move, then we need to start a new round.
        } else if insertNextBox() == false {
            state = .failure
        }
    }
}

