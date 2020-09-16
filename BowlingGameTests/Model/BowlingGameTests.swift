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

    func test_whenAllStrikes_shouldReturnValidScore() {
        //Arrange
        self.makeStrikeRounds(10)
        self.sut.bonusRound(10, 10)

        //Act
        let finalScore = self.sut.finalScore

        //Assert
        XCTAssertEqual(finalScore, 300, "Score of the game should have been matched with expected score.")
    }

    func test_whenNormalRoundCalled_shouldMaintainDelivery() {
        //Arrange
        let firstDelivery = 3
        let secondDelivery = 4

        //Act
        XCTAssertNil(self.sut.deliveryAt(index: 0), "Should have no stored delivery in the begining.")
        self.sut.normalRound(firstDelivery, secondDelivery)

        //Assert
        let storedFirstDelivery = try! XCTUnwrap(self.sut.deliveryAt(index: 0))
        XCTAssertEqual(firstDelivery, storedFirstDelivery, "Stored delivery should have matched with round's delivery")

        let storedSecondDelivery = try! XCTUnwrap(self.sut.deliveryAt(index: 1))
        XCTAssertEqual(secondDelivery, storedSecondDelivery, "Stored delivery should have matched with round's delivery")
    }

    func test_whenSpareRoundCalled_shouldMaintainDelivery() {
        //Arrange
        let firstDelivery = 3
        let secondDelivery = 7

        //Act
        XCTAssertNil(self.sut.deliveryAt(index: 0), "Should have no stored delivery in the begining.")
        self.sut.spareRound(firstDelivery, secondDelivery)

        //Assert
        let storedFirstDelivery = try! XCTUnwrap(self.sut.deliveryAt(index: 0))
        XCTAssertEqual(firstDelivery, storedFirstDelivery, "Stored delivery should have matched with round's delivery")

        let storedSecondDelivery = try! XCTUnwrap(self.sut.deliveryAt(index: 1))
        XCTAssertEqual(secondDelivery, storedSecondDelivery, "Stored delivery should have matched with round's delivery")
    }

    func test_whenStrikeRoundCalled_shouldMaintainDelivery() {
        //Arrange

        //Act
        XCTAssertNil(self.sut.deliveryAt(index: 0), "Should have no stored delivery in the begining.")
        self.sut.strikeRound()

        //Assert
        let storedFirstDelivery = try! XCTUnwrap(self.sut.deliveryAt(index: 0))
        XCTAssertEqual(10, storedFirstDelivery, "Stored delivery should have matched with round's delivery")
    }

    func test_whenBonusRoundCalled_shouldMaintainDelivery() {
        //Arrange
        let firstDelivery = 3
        let secondDelivery = 7

        //Act
        XCTAssertNil(self.sut.deliveryAt(index: 0), "Should have no stored delivery in the begining.")
        self.sut.bonusRound(firstDelivery, secondDelivery)

        //Assert
        let storedFirstDelivery = try! XCTUnwrap(self.sut.deliveryAt(index: 0))
        XCTAssertEqual(firstDelivery, storedFirstDelivery, "Stored delivery should have matched with round's delivery")

        let storedSecondDelivery = try! XCTUnwrap(self.sut.deliveryAt(index: 1))
        XCTAssertEqual(secondDelivery, storedSecondDelivery, "Stored delivery should have matched with round's delivery")
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

    func makeStrikeRounds(_ count: Int) {
        for _ in 0..<count {
            self.sut.strikeRound()
        }
    }

}

