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

    func test_whenGivenValidSequenceOfRolls_ShouldReturnValidResult() {
        //Arrange

        //Act
        let finalScore = try! self.sut.getGamesFinalScore(rolls: [4,5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4,5])

        //Assert
        XCTAssertEqual(finalScore, 90, "Score should have matched")
    }

    func test_whenGivenValidSequenceOfAllStikes_ShouldReturnValidResult() {
        //Arrange

        //Act
        let finalScore = try! self.sut.getGamesFinalScore(rolls: [10,10,10,10,10,10,10,10,10,10,10,10])

        //Assert
        XCTAssertEqual(finalScore, 300, "Score should have matched")
    }

    func test_whenGivenValidSequenceOfAllSpares_ShouldReturnValidResult() {
        //Arrange

        //Act
        let finalScore = try! self.sut.getGamesFinalScore(rolls: [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5])

        //Assert
        XCTAssertEqual(finalScore, 150, "Score should have matched")
    }

}

