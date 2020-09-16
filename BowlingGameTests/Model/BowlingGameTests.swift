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

    func test_whenNormalGame_shouldReturnValidScore() {
        //Arrange
        self.makeNormalRounds(10, 6, 2)

        //Act
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertEqual(finalScore, 80, "Score of the game should have been matched with expected score.")
    }

    func test_whenAtleastOneSpare_shouldReturnValidScore() {
        //Arrange
        self.sut.normalRound(6, 2)
        self.sut.normalRound(6, 2)
        self.sut.spareRound(1, 9)
        self.makeNormalRounds(7, 6, 2)

        //Act
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertEqual(finalScore, 88, "Score of the game should have been matched with expected score.")
    }

    func test_whenAllSpares_shouldReturnValidScore() {
        //Arrange
        self.makeSpareRounds(10, 5, 5)
        self.sut.bonusRound(5, nil)

        //Act
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertEqual(finalScore, 150, "Score of the game should have been matched with expected score.")
    }

    func test_whenAtleastOneStrike_shouldReturnValidScore() {
        //Arrange
        self.sut.normalRound(2, 2)
        self.sut.normalRound(5, 3)
        self.sut.strikeRound()
        self.makeNormalRounds(7, 1, 2)

        //Act
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertEqual(finalScore, 46, "Score of the game should have been matched with expected score.")
    }

}

//MARK:- Stub helpers

private extension BowlingGameTests {

    func makeNormalRounds(_ count: Int,_ firstDelivery: Int,_ secondDelivery: Int) {
        for _ in 0..<count {
            self.sut.normalRound(firstDelivery, secondDelivery)
        }
    }

    func makeSpareRounds(_ count: Int,_ firstDelivery: Int,_ secondDelivery: Int) {
        for _ in 0..<count {
            self.sut.spareRound(firstDelivery, secondDelivery)
        }
    }

}

