//
//  StrikeRound.swift
//  BowlingGame
//

import Foundation

class StrikeRound: Round, Bonusable {

    //MARK: - Internal properties

    static let strikeDefaultScore = 10

    var score: Int {
        self.firstDelivery + self.bonusScore
    }

    var bonusScore: Int {
        var bonusScore = 0

        for index in 1...self.numberOfDeliveriesToCalculateBonus {
            guard let delivery = self.bowlingGame?.deliveryAt(index: self.roundDeliveryStartIndex + index) else {
                assertionFailure("Could not calculate bonus score")
                return 0
            }

            bonusScore += delivery
        }
        return bonusScore
    }

    var numberOfDeliveriesToCalculateBonus: Int {
        2
    }

    //MARK: - Private properties

    private let firstDelivery: Int
    private let roundDeliveryStartIndex: Int
    private weak var bowlingGame: BowlingGameProtocol?

    //MARK: - Initializer

    init(_ roundDeliveryStartIndex: Int, bowlingGame: BowlingGameProtocol) {
        self.roundDeliveryStartIndex = roundDeliveryStartIndex
        self.firstDelivery = StrikeRound.strikeDefaultScore
        self.bowlingGame = bowlingGame
    }
}
