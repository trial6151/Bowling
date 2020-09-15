//
//  NormalRoundTests.swift
//  BowlingGameTests
//

import XCTest
@testable import BowlingGame

class NormalRoundTests: XCTestCase {
    var sut: NormalRound!
    let firstDelivery = 4
    let secondDelivery = 4

    override func setUp() {
        super.setUp()
        self.sut = NormalRound(self.firstDelivery, self.secondDelivery)
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
        XCTAssertEqual(score, self.firstDelivery + self.secondDelivery, "Score should have matched total of firstDelivery and secondDelivey")
    }
}

