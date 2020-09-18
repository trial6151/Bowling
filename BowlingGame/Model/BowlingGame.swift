//
//  BowlingGame.swift
//  BowlingGame
//

import Foundation

protocol BowlingGameProtocol: class {
    var finalScore: Int { get }
    func normalRound(_ firstRoll: Int,_ secondRoll: Int)
    func spareRound(_ firstRoll: Int,_ secondRoll: Int)
    func strikeRound()
    func bonusRound(_ firstRoll: Int,_ secondRoll: Int?)
    func getGamesFinalScore(rolls: [Int]) -> Int
    func rollAt(index: Int) -> Int?
    @discardableResult func resetGame() -> Bool
}

class BowlingGame: BowlingGameProtocol {

    //MARK: - Internal properties

    var finalScore: Int {
        self.rounds.map{ $0.score }.reduce(0, +)
    }

    //MARK: - Private properties

    private var rounds = [Round]()
    private var rolls = [Int]()

    private static let roundMaxScore = 10
    private static let totalRounds = 10

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

    func getGamesFinalScore(rolls: [Int]) -> Int {
        var firstRoll: Int? = nil
        var roundCount = 0
        var isLastRoundSpare = false

        for roll in rolls {
            if roundCount == BowlingGame.totalRounds {
                if let score = self.addBonusRoundAndGetScore(roll: roll,
                                                                firstRoll: &firstRoll,
                                                                isLastRoundSpare: isLastRoundSpare) {
                        return score
                }
                continue
            }

            if firstRoll != nil {
                self.addNormalAndSpareRound(roll: roll,
                                            firstRoll: &firstRoll,
                                            isLastRoundSpare: &isLastRoundSpare,
                                            roundCount: &roundCount)
            } else {
                self.addStrikeRound(roll: roll, firstRoll: &firstRoll, roundCount: &roundCount)
                continue
            }
        }

        return self.finalScore
    }

    func rollAt(index: Int) -> Int? {
        guard self.rolls.indices.contains(index) else {
            return nil
        }
        return self.rolls[index]
    }

    @discardableResult
    func resetGame() -> Bool {
        self.rounds.removeAll()
        self.rolls.removeAll()
        return self.rounds.isEmpty && self.rolls.isEmpty ? true : false
    }
}

private extension BowlingGame {

    private func addStrikeRound(roll: Int, firstRoll: inout Int?, roundCount: inout Int) {
        if roll == BowlingGame.roundMaxScore {
            self.strikeRound()
            roundCount += 1
            return
        }
        firstRoll = roll
    }

    private func addBonusRoundAndGetScore(roll: Int, firstRoll: inout Int?, isLastRoundSpare: Bool) -> Int? {
        if let first = firstRoll {
            self.bonusRound(first, roll)
            return self.finalScore
        } else {
            firstRoll = roll
            guard isLastRoundSpare else { return nil }
            self.bonusRound(roll, nil)
            return self.finalScore
        }
    }

    private func addNormalAndSpareRound(roll: Int,
                                        firstRoll: inout Int?,
                                        isLastRoundSpare: inout Bool,
                                        roundCount: inout Int) {

        guard let first = firstRoll else {
            return
        }

        if first + roll == BowlingGame.roundMaxScore {
            self.spareRound(first, roll)
            isLastRoundSpare = roundCount == 9
        } else {
            self.normalRound(first, roll)
        }
        roundCount += 1
        firstRoll = nil
    }

}
