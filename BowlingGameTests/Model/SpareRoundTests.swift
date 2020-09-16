//
//  SpareRoundTests.swift
//  BowlingGameTests
//

import XCTest
@testable import BowlingGame

class SpareRoundTests: XCTestCase {
    var sut: SpareRound!
    var mockBowlingGame: MockBowlingGame!
    let firstRoll = 4
    let secondRoll = 5

    override func setUp() {
        super.setUp()
        self.mockBowlingGame = MockBowlingGame()
        self.sut = SpareRound(self.firstRoll, self.secondRoll, 0, bowlingGame: mockBowlingGame)
    }

    override func tearDown() {
        super.tearDown()
        self.sut = nil
        self.mockBowlingGame = nil
    }

    func test_hasValidScore() {
        //Arrange
        let bonusScore = 5
        self.mockBowlingGame.roll = bonusScore

        //Act
        let score = self.sut.score

        //Assert
        XCTAssertEqual(score, self.firstRoll + self.secondRoll + bonusScore, "Score should have matched total of firstRoll, secondDelivey and bonusScore")
    }
}
