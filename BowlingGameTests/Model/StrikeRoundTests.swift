//
//  StrikeRoundTests.swift
//  BowlingGameTests
//

import XCTest
@testable import BowlingGame

class StrikeRoundTests: XCTestCase {
    var sut: StrikeRound!
    var mockBowlingGame: MockBowlingGame!

    override func setUp() {
        super.setUp()
        self.mockBowlingGame = MockBowlingGame()
        self.sut = StrikeRound(0, bowlingGame: self.mockBowlingGame)
    }

    override func tearDown() {
        super.tearDown()
        self.sut = nil
        self.mockBowlingGame = nil
    }

    func test_hasValidScore() {
        //Arrange
        let bonusScore = 4
        self.mockBowlingGame.delivery = bonusScore

        //Act
        let score = self.sut.score

        //Assert
        XCTAssertEqual(score, 10 + bonusScore * 2, "Score should have matched total of defaultStrikeScore and bonusScore")
    }
}
