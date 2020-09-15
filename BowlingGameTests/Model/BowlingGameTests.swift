//
//  BowlingGameTests.swift
//  BowlingGameTests
//

import XCTest
@testable import BowlingGame

class BowlingGameTests: XCTestCase {

    var sut: BowlingGame!

    override func setUp() {
        super.setUp()
        self.sut = BowlingGame()
    }

    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }

    func test_shouldProvideValidScore() {
        //Arrange

        //Act
        self.sut.normalRound(1, 5)
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertTrue(finalScore >= 0, "Game should have valid score.")
    }

    func test_whenPlayerDidNotScoreInAllDeliveriesOfGame_shouldReturnScore0() {
        //Arrange
        self.makeNormalRounds(10, 0, 0)

        //Act
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertEqual(finalScore, 0, "Score of the game should have been 0.")
    }

}

//MARK:- Stub helpers

private extension BowlingGameTests {

    func makeNormalRounds(_ count: Int,_ firstDelivery: Int,_ secondDelivery: Int) {
        for _ in 0..<count {
            self.sut.normalRound(firstDelivery, secondDelivery)
        }
    }

}

