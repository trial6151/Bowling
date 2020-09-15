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

}
