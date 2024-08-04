//
//  Extensions.swift
//  FusionTests
//
//  Created by Jey Starratt on 8/4/24.
//

@testable import Fusion

// Note this is not Equatable because I'm ignoring IDs.
extension Board {
    func sameNumbers(as otherBoard: Board) -> Bool {
        self.contents.flatMap({ $0 }).map(\.value) == otherBoard.contents.flatMap({ $0 }).map(\.value)
    }
}

extension Board: CustomDebugStringConvertible {
    public var debugDescription: String {
        contents.reduce("\n", { result, row in
            result
                .appending(row.map({ String($0.value) }).joined(separator: "\t"))
                .appending("\n")
        })
        //contents.map({ $0.value }).joined(separator: "\n")
    }
}
