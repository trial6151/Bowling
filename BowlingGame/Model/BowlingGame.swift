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
                if let first = firstRoll {
                    self.bonusRound(first, roll)
                    return self.finalScore
                } else {
                    firstRoll = roll
                    guard isLastRoundSpare == true else { continue }
                    self.bonusRound(roll, nil)
                    return self.finalScore
                }
            }

            if let first = firstRoll {
                if first + roll == BowlingGame.roundMaxScore {
                    self.spareRound(first, roll)
                    isLastRoundSpare = roundCount == 9 ? true : false
                } else {
                    self.normalRound(first, roll)
                }
                roundCount += 1
                firstRoll = nil
            } else {
                if roll == BowlingGame.roundMaxScore {
                    self.strikeRound()
                    roundCount += 1
                    continue
                }
                firstRoll = roll
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
