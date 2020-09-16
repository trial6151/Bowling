//
//  NormalRoundTests.swift
//  BowlingGameTests
//

import XCTest
@testable import BowlingGame

class NormalRoundTests: XCTestCase {
    var sut: NormalRound!
    let firstRoll = 4
    let secondRoll = 4

    override func setUp() {
        super.setUp()
        self.sut = NormalRound(self.firstRoll, self.secondRoll)
    }

    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }

    func test_hasValidScore() {
        //Arrange

        //Act
        let score = self.sut.score

        //Assert
        XCTAssertEqual(score, self.firstRoll + self.secondRoll, "Score should have matched total of firstRoll and secondDelivey")
    }
}

