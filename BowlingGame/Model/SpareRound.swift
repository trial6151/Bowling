//
//  SpareRound.swift
//  BowlingGame
//

import Foundation

class SpareRound: Round, Bonusable {

    //MARK: - Internal properties

    let firstRoll: Int

    var score: Int {
        self.firstRoll + self.secondRoll + self.bonusScore
    }

    var bonusScore: Int {
        guard let roll = self.bowlingGame?.rollAt(index:  self.roundRollStartIndex + 2) else {
            assertionFailure("Could not calculate bonus score")
            return 0
        }

        return roll
    }

    //MARK: - Private properties
    private let secondRoll: Int
    private let roundRollStartIndex: Int
    private weak var bowlingGame: BowlingGameProtocol?

    //MARK: - Initializer

    init(_ firstRoll: Int, _ secondRoll: Int,_ roundRollStartIndex: Int, bowlingGame: BowlingGameProtocol) {
        self.roundRollStartIndex = roundRollStartIndex
        self.firstRoll = firstRoll
        self.secondRoll = secondRoll
        self.bowlingGame = bowlingGame
    }
}
