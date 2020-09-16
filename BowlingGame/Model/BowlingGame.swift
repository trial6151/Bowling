//
//  BowlingGame.swift
//  BowlingGame
//

import Foundation

protocol BowlingGameProtocol: class {
    func deliveryAt(index: Int) -> Int?
}

class BowlingGame: BowlingGameProtocol {

    //MARK: - Internal properties

    var finalScore: Int {
        self.rounds.map{ $0.score }.reduce(0, +)
    }

    //MARK: - Private properties

    private var rounds = [Round]()
    private var deliveries = [Int]()

    //MARK: - Internal methods

    func normalRound(_ firstDelivery: Int,_ secondDelivery: Int) {
        self.rounds.append(NormalRound(firstDelivery, secondDelivery))
        self.deliveries.append(firstDelivery)
        self.deliveries.append(secondDelivery)
    }

    func spareRound(_ firstDelivery: Int,_ secondDelivery: Int) {
        self.rounds.append(SpareRound(firstDelivery, secondDelivery, self.deliveries.count, bowlingGame: self))
        self.deliveries.append(firstDelivery)
        self.deliveries.append(secondDelivery)
    }

    func strikeRound() {
        self.rounds.append(StrikeRound(self.deliveries.count, bowlingGame: self))
        self.deliveries.append(StrikeRound.strikeDefaultScore)
    }

    func bonusRound(_ firstDelivery: Int,_ secondDelivery: Int?) {
        self.rounds.append(BonusRound(firstDelivery, secondDelivery))
        self.deliveries.append(firstDelivery)

        if let secondDelivery = secondDelivery {
            self.deliveries.append(secondDelivery)
        }
    }

    func deliveryAt(index: Int) -> Int? {
        guard self.deliveries.indices.contains(index) else {
            return nil
        }
        return self.deliveries[index]
    }
}
