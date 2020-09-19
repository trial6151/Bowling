//
//  BowlingGame.swift
//  BowlingGame
//

import Foundation

protocol BowlingGameProtocol: class {
    func getGamesFinalScore(rolls: [Int]) throws -> Int
    func rollAt(index: Int) -> Int?
}

enum BowlingError: Error {
    case wrongNumberOfRounds
}

class BowlingGame: BowlingGameProtocol {

    //MARK: - Private properties

    private var finalScore: Int {
        self.rounds.map{ $0.score }.reduce(0, +)
    }

    private var rounds = [Round]()
    private var rolls = [Int]()

    private static let roundMaxScore = 10
    private static let totalRounds = 10
    private static let minimumRolls = 12
    private static let maximumRolls = 21

    //MARK: - Internal methods

    func getGamesFinalScore(rolls: [Int]) throws -> Int {
        defer {
            self.resetGame()
        }

        guard self.isValidNumberOf(rolls: rolls) else {
            throw BowlingError.wrongNumberOfRounds
        }

        var firstRoll: Int? = nil
        var roundCount = 0
        var isLastRoundSpare = false

        for roll in rolls {
            if isLastRoundCompleted(roundCount) {
                if let score = self.addBonusRoundIfNeededAndGetScore(roll: roll,
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

        if roundCount < BowlingGame.totalRounds {
            throw BowlingError.wrongNumberOfRounds
        }

        return self.finalScore
    }

    func rollAt(index: Int) -> Int? {
        guard self.rolls.indices.contains(index) else {
            return nil
        }
        return self.rolls[index]
    }
}

//MARK: - Private methods

private extension BowlingGame {

    //MARK: - Helpers to maintain rolls and rounds

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

    func resetGame() {
        self.rounds.removeAll()
        self.rolls.removeAll()
    }

    //MARK: - Helpers to create game sequence

    func addStrikeRound(roll: Int, firstRoll: inout Int?, roundCount: inout Int) {
        if roll == BowlingGame.roundMaxScore {
            self.strikeRound()
            roundCount += 1
            return
        }
        firstRoll = roll
    }

    func addBonusRoundIfNeededAndGetScore(roll: Int, firstRoll: inout Int?, isLastRoundSpare: Bool) -> Int? {
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

    func addNormalAndSpareRound(roll: Int,
                                        firstRoll: inout Int?,
                                        isLastRoundSpare: inout Bool,
                                        roundCount: inout Int) {

        guard let first = firstRoll else {
            return
        }

        if isSpareRound(first, roll) {
            self.spareRound(first, roll)
            isLastRoundSpare = roundCount == 9
        } else {
            self.normalRound(first, roll)
        }
        roundCount += 1
        firstRoll = nil
    }

    func isSpareRound(_ first: Int, _ roll: Int) -> Bool {
        return first + roll == BowlingGame.roundMaxScore
    }

    func isLastRoundCompleted(_ roundCount: Int) -> Bool {
        return roundCount == BowlingGame.totalRounds
    }

    //MARK: - Helper for basic validation

    func isValidNumberOf(rolls: [Int]) -> Bool {
        BowlingGame.minimumRolls <= rolls.count && rolls.count <= BowlingGame.maximumRolls
    }
}
