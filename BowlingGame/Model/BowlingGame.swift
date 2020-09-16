//
//  BowlingGame.swift
//  BowlingGame
//

import Foundation

protocol BowlingGameProtocol: class {
    func rollAt(index: Int) -> Int?
}

class BowlingGame: BowlingGameProtocol {

    //MARK: - Internal properties

    var finalScore: Int {
        self.rounds.map{ $0.score }.reduce(0, +)
    }

    //MARK: - Private properties

    private var rounds = [Round]()
    private var rolls = [Int]()

    //MARK: - Internal methods

    func normalRound(_ firstRoll: Int,_ secondRoll: Int) {
        self.rounds.append(NormalRound(firstRoll, secondRoll))
        self.rolls.append(firstRoll)
        self.rolls.append(secondRoll)
    }

    func spareRound(_ firstRoll: Int,_ secondRoll: Int) {
        self.rounds.append(SpareRound(firstRoll, secondRoll, self.rolls.count, bowlingGame: self))
        self.rolls.append(firstRoll)
        self.rolls.append(secondRoll)
    }

    func strikeRound() {
        self.rounds.append(StrikeRound(self.rolls.count, bowlingGame: self))
        self.rolls.append(StrikeRound.strikeDefaultScore)
    }

    func bonusRound(_ firstRoll: Int,_ secondRoll: Int?) {
        self.rounds.append(BonusRound(firstRoll, secondRoll))
        self.rolls.append(firstRoll)

        if let secondRoll = secondRoll {
            self.rolls.append(secondRoll)
        }
    }

    func rollAt(index: Int) -> Int? {
        guard self.rolls.indices.contains(index) else {
            return nil
        }
        return self.rolls[index]
    }
}
