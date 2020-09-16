//
//  StrikeRound.swift
//  BowlingGame
//

import Foundation

class StrikeRound: Round, Bonusable {

    //MARK: - Internal properties

    static let strikeDefaultScore = 10

    let firstRoll: Int
    
    var score: Int {
        self.firstRoll + self.bonusScore
    }

    var bonusScore: Int {
        var bonusScore = 0

        for index in 1...self.numberOfRollsToCalculateBonus {
            guard let roll = self.bowlingGame?.rollAt(index: self.roundRollStartIndex + index) else {
                assertionFailure("Could not calculate bonus score")
                return 0
            }

            bonusScore += roll
        }
        return bonusScore
    }

    var numberOfRollsToCalculateBonus: Int {
        2
    }

    //MARK: - Private properties

    private let roundRollStartIndex: Int
    private weak var bowlingGame: BowlingGameProtocol?

    //MARK: - Initializer

    init(_ roundRollStartIndex: Int, bowlingGame: BowlingGameProtocol) {
        self.roundRollStartIndex = roundRollStartIndex
        self.firstRoll = StrikeRound.strikeDefaultScore
        self.bowlingGame = bowlingGame
    }
}
