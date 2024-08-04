//
//  Direction.swift
//  Fusion
//
//  Created by Jey Starratt on 8/4/24.
//

import Foundation

/// Describes the direction/"wall" the user hit on swiping.
enum Direction: CaseIterable {
    case top
    case bottom
    case leading
    case trailing

    /// The first row to search when hitting this wall.
    var firstRow: Int {
        switch self {
        case .top, .leading:
            0
        case .bottom, .trailing:
            Constants.size - 1
        }
    }

    /// The first row to search when hitting this wall.
    var firstColumn: Int {
        switch self {
        case .top, .leading:
            0
        case .bottom, .trailing:
            Constants.size - 1
        }
    }
}

