//
//  BowlingGame.swift
//  BowlingGame
//

import Foundation

class BowlingGame {

    //MARK: - Internal properties

    var finalScore: Int {
        self.rounds.map{ $0.score }.reduce(0, +)
    }

    //MARK: - Private properties

    private var rounds = [Round]()

    //MARK: - Internal methods

    func normalRound(_ firstDelivery: Int,_ secondDelivery: Int) {
        self.rounds.append(NormalRound(firstDelivery, secondDelivery))
    }
}
