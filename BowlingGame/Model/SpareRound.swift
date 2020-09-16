//
//  SpareRound.swift
//  BowlingGame
//

import Foundation

class SpareRound: Round, Bonusable {

    //MARK: - Internal properties

    let firstDelivery: Int
    let secondDelivery: Int

    var score: Int {
        self.firstDelivery + self.secondDelivery + self.bonusScore
    }

    var bonusScore: Int {
        guard let delivery = self.bowlingGame?.deliveryAt(index:  self.roundDeliveryStartIndex + 2) else {
            assertionFailure("Could not calculate bonus score")
            return 0
        }

        return delivery
    }

    //MARK: - Private properties

    private let roundDeliveryStartIndex: Int
    private weak var bowlingGame: BowlingGameProtocol?

    //MARK: - Initializer

    init(_ firstDelivery: Int, _ secondDelivery: Int,_ roundDeliveryStartIndex: Int, bowlingGame: BowlingGameProtocol) {
        self.roundDeliveryStartIndex = roundDeliveryStartIndex
        self.firstDelivery = firstDelivery
        self.secondDelivery = secondDelivery
        self.bowlingGame = bowlingGame
    }
}
