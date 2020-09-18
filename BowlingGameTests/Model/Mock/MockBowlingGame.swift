//
//  MockBowlingGame.swift
//  BowlingGameTests
//

import Foundation
@testable import BowlingGame

class MockBowlingGame: BowlingGameProtocol {
    var roll: Int?
    var finalScore: Int = 0

    func getGamesFinalScore(rolls: [Int]) -> Int {
        self.finalScore
    }

    func rollAt(index: Int) -> Int? {
        self.roll
    }
}
