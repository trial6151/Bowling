//
//  Factory.swift
//  BowlingGame
//

import Foundation

class Factory {

    static func createBowlingGame() -> BowlingGameProtocol {
        BowlingGame()
    }

    static func createAllowedScores() -> [Int] {
        [0,1,2,3,4,5,6,7,8,9,10]
    }

}
