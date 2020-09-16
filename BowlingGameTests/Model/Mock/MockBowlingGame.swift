//
//  MockBowlingGame.swift
//  BowlingGameTests
//

import Foundation
@testable import BowlingGame

class MockBowlingGame: BowlingGameProtocol {
    var roll: Int?

    func rollAt(index: Int) -> Int? {
        self.roll
    }
}
