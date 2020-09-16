//
//  SpareRoundTests.swift
//  BowlingGameTests
//

import XCTest
@testable import BowlingGame

class SpareRoundTests: XCTestCase {
    var sut: SpareRound!
    var mockBowlingGame: MockBowlingGame!
    let firstDelivery = 4
    let secondDelivery = 5

    override func setUp() {
        super.setUp()
        self.mockBowlingGame = MockBowlingGame()
        self.sut = SpareRound(self.firstDelivery, self.secondDelivery, 0, bowlingGame: mockBowlingGame)
    }

    override func tearDown() {
        super.tearDown()
        self.sut = nil
        self.mockBowlingGame = nil
    }

    func test_hasValidScore() {
        //Arrange
        let bonusScore = 5
        self.mockBowlingGame.delivery = bonusScore

        //Act
        let score = self.sut.score

        //Assert
        XCTAssertEqual(score, self.firstDelivery + self.secondDelivery + bonusScore, "Score should have matched total of firstDelivery, secondDelivey and bonusScore")
    }
}
