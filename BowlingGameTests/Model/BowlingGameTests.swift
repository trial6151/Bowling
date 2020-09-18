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

    func test_whenPlayerDidNotScoreInAllRollsOfGame_shouldReturnScore0() {
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

    func test_whenAllStrikes_shouldReturnValidScore() {
        //Arrange
        self.makeStrikeRounds(10)
        self.sut.bonusRound(10, 10)

        //Act
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertEqual(finalScore, 300, "Score of the game should have been matched with expected score.")
    }

    func test_whenNormalRoundCalled_shouldMaintainRoll() {
        //Arrange
        let firstRoll = 3
        let secondRoll = 4

        //Act
        XCTAssertNil(self.sut.rollAt(index: 0), "Should have no stored roll in the begining.")
        self.sut.normalRound(firstRoll, secondRoll)

        //Assert
        let storedFirstRoll = try! XCTUnwrap(self.sut.rollAt(index: 0))
        XCTAssertEqual(firstRoll, storedFirstRoll, "Stored roll should have matched with round's roll")

        let storedSecondRoll = try! XCTUnwrap(self.sut.rollAt(index: 1))
        XCTAssertEqual(secondRoll, storedSecondRoll, "Stored roll should have matched with round's roll")
    }

    func test_whenSpareRoundCalled_shouldMaintainRoll() {
        //Arrange
        let firstRoll = 3
        let secondRoll = 7

        //Act
        XCTAssertNil(self.sut.rollAt(index: 0), "Should have no stored roll in the begining.")
        self.sut.spareRound(firstRoll, secondRoll)

        //Assert
        let storedFirstRoll = try! XCTUnwrap(self.sut.rollAt(index: 0))
        XCTAssertEqual(firstRoll, storedFirstRoll, "Stored roll should have matched with round's roll")

        let storedSecondRoll = try! XCTUnwrap(self.sut.rollAt(index: 1))
        XCTAssertEqual(secondRoll, storedSecondRoll, "Stored roll should have matched with round's roll")
    }

    func test_whenStrikeRoundCalled_shouldMaintainRoll() {
        //Arrange

        //Act
        XCTAssertNil(self.sut.rollAt(index: 0), "Should have no stored roll in the begining.")
        self.sut.strikeRound()

        //Assert
        let storedFirstRoll = try! XCTUnwrap(self.sut.rollAt(index: 0))
        XCTAssertEqual(10, storedFirstRoll, "Stored roll should have matched with round's roll")
    }

    func test_whenBonusRoundCalled_shouldMaintainRoll() {
        //Arrange
        let firstRoll = 3
        let secondRoll = 7

        //Act
        XCTAssertNil(self.sut.rollAt(index: 0), "Should have no stored roll in the begining.")
        self.sut.bonusRound(firstRoll, secondRoll)

        //Assert
        let storedFirstRoll = try! XCTUnwrap(self.sut.rollAt(index: 0))
        XCTAssertEqual(firstRoll, storedFirstRoll, "Stored roll should have matched with round's roll")

        let storedSecondRoll = try! XCTUnwrap(self.sut.rollAt(index: 1))
        XCTAssertEqual(secondRoll, storedSecondRoll, "Stored roll should have matched with round's roll")
    }

    func test_whenGivenValidSequenceOfRolls_ShouldReturnValidResult() {
        //Arrange

        //Act
        let finalScore = self.sut.getGamesFinalScore(rolls: [4,5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4,5])

        //Assert
        XCTAssertEqual(finalScore, 90, "Score should have matched")
    }

    func test_whenGivenValidSequenceOfAllStikes_ShouldReturnValidResult() {
        //Arrange

        //Act
        let finalScore = self.sut.getGamesFinalScore(rolls: [10,10,10,10,10,10,10,10,10,10,10,10])

        //Assert
        XCTAssertEqual(finalScore, 300, "Score should have matched")
    }

    func test_whenGivenValidSequenceOfAllSpares_ShouldReturnValidResult() {
        //Arrange

        //Act
        let finalScore = self.sut.getGamesFinalScore(rolls: [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5])

        //Assert
        XCTAssertEqual(finalScore, 150, "Score should have matched")
    }

}

//MARK:- Stub helpers

private extension BowlingGameTests {

    func makeNormalRounds(_ count: Int,_ firstRoll: Int,_ secondRoll: Int) {
        for _ in 0..<count {
            self.sut.normalRound(firstRoll, secondRoll)
        }
    }

    func makeSpareRounds(_ count: Int,_ firstRoll: Int,_ secondRoll: Int) {
        for _ in 0..<count {
            self.sut.spareRound(firstRoll, secondRoll)
        }
    }

    func makeStrikeRounds(_ count: Int) {
        for _ in 0..<count {
            self.sut.strikeRound()
        }
    }

}

