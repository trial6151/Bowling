//
//  MockBowlingGame.swift
//  BowlingGameTests
//

import Foundation
@testable import BowlingGame

class MockBowlingGame: BowlingGameProtocol {

    var roll: Int?

    var finalScore: Int = 0

    func normalRound(_ firstRoll: Int, _ secondRoll: Int) {}

    func spareRound(_ firstRoll: Int, _ secondRoll: Int) {}

    func strikeRound() {}

    func bonusRound(_ firstRoll: Int, _ secondRoll: Int?) {}

    func getGamesFinalScore(rolls: [Int]) -> Int {
        self.finalScore
    }

    func resetGame() -> Bool {
        true
    }

    func rollAt(index: Int) -> Int? {
        self.roll
    }
}
