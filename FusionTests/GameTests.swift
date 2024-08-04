//
//  GameTests.swift
//  FusionTests
//
//  Created by Jey Starratt on 8/4/24.
//

import XCTest
@testable import Fusion

final class GameTests: XCTestCase {
    func testSimpleSwipeDown() {
        let game = Game(debug: true, board: Board(contents: [
            [2, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]))
        game.swiped(towards: .bottom)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [2, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testSimpleCombineDown() {
        let game = Game(debug: true, board: Board(contents: [
            [2, 0, 0, 0],
            [2, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]))
        game.swiped(towards: .bottom)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [4, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testSimpleSwipeUp() {
        let game = Game(debug: true, board: Board(contents: [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [2, 0, 0, 0],
        ]))
        game.swiped(towards: .top)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [2, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testSimpleCombineUp() {
        let game = Game(debug: true, board: Board(contents: [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [2, 0, 0, 0],
            [2, 0, 0, 0],
        ]))
        game.swiped(towards: .top)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [4, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testSimpleSwipeLeft() {
        let game = Game(debug: true, board: Board(contents: [
            [0, 0, 0, 2],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]))
        game.swiped(towards: .leading)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [2, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testSimpleCombineLeft() {
        let game = Game(debug: true, board: Board(contents: [
            [2, 2, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]))
        game.swiped(towards: .leading)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [4, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testSimpleSwipeRight() {
        let game = Game(debug: true, board: Board(contents: [
            [2, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]))
        game.swiped(towards: .trailing)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [0, 0, 0, 2],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testSimpleCombineRight() {
        let game = Game(debug: true, board: Board(contents: [
            [0, 0, 2, 2],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]))
        game.swiped(towards: .trailing)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [0, 0, 0, 4],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testComplex1SwipeUp() {
        let game = Game(debug: true, board: Board(contents: [
            [4, 4, 8, 4],
            [2, 2, 0, 2],
            [4, 4, 0, 4],
            [2, 2, 0, 2],
        ]))
        game.swiped(towards: .top)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [4, 4, 8, 4],
            [2, 2, 0, 2],
            [4, 4, 0, 4],
            [2, 2, 0, 2],
        ])), "Board is: \(game.board)")
    }

    func testComplex1SwipeDown() {
        let game = Game(debug: true, board: Board(contents: [
            [4, 4, 8, 4],
            [2, 2, 0, 2],
            [4, 4, 0, 4],
            [2, 2, 0, 2],
        ]))
        game.swiped(towards: .bottom)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [4, 4, 0, 4],
            [2, 2, 0, 2],
            [4, 4, 0, 4],
            [2, 2, 8, 2],
        ])), "Board is: \(game.board)")
    }

    func testComplex1SwipeLeft() {
        let game = Game(debug: true, board: Board(contents: [
            [4, 4, 8, 4],
            [2, 2, 0, 2],
            [4, 4, 0, 4],
            [2, 2, 0, 2],
        ]))
        game.swiped(towards: .leading)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [8, 8, 4, 0],
            [4, 2, 0, 0],
            [8, 4, 0, 0],
            [4, 2, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testComplex1SwipeRight() {
        let game = Game(debug: true, board: Board(contents: [
            [4, 4, 8, 4],
            [2, 2, 0, 2],
            [4, 4, 0, 4],
            [2, 2, 0, 2],
        ]))
        game.swiped(towards: .trailing)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [0, 8, 8, 4],
            [0, 0, 2, 4],
            [0, 0, 4, 8],
            [0, 0, 2, 4],
        ])), "Board is: \(game.board)")
    }

    func testComplex2SwipeUp() {
        let game = Game(debug: true, board: Board(contents: [
            [8, 0, 4, 0],
            [2, 0, 0, 0],
            [2, 0, 0, 0],
            [4, 2, 4, 0]
        ]))
        game.swiped(towards: .top)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [8, 2, 8, 0],
            [4, 0, 0, 0],
            [4, 0, 0, 0],
            [0, 0, 0, 0],
        ])), "Board is: \(game.board)")
    }

    func testComplex2SwipeDown() {
        let game = Game(debug: true, board: Board(contents: [
            [8, 0, 4, 0],
            [2, 0, 0, 0],
            [2, 0, 0, 0],
            [4, 2, 4, 0]
        ]))
        game.swiped(towards: .bottom)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [0, 0, 0, 0],
            [8, 0, 0, 0],
            [4, 0, 0, 0],
            [4, 2, 8, 0]
        ])), "Board is: \(game.board)")
    }

    func testComplex2SwipeLeft() {
        let game = Game(debug: true, board: Board(contents: [
            [8, 0, 4, 0],
            [2, 0, 0, 0],
            [2, 0, 0, 0],
            [4, 2, 4, 0]
        ]))
        game.swiped(towards: .leading)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [8, 4, 0, 0],
            [2, 0, 0, 0],
            [2, 0, 0, 0],
            [4, 2, 4, 0]
        ])), "Board is: \(game.board)")
    }

    func testComplex2SwipeRight() {
        let game = Game(debug: true, board: Board(contents: [
            [8, 0, 4, 0],
            [2, 0, 0, 0],
            [2, 0, 0, 0],
            [4, 2, 4, 0]
        ]))
        game.swiped(towards: .trailing)
        XCTAssertTrue(game.board.sameNumbers(as: Board(contents: [
            [0, 0, 8, 4],
            [0, 0, 0, 2],
            [0, 0, 0, 2],
            [0, 4, 2, 4]
        ])), "Board is: \(game.board)")
    }
}
