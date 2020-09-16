//
//  BonusRound.swift
//  BowlingGame
//

import Foundation

class BonusRound: Round {

    //MARK: - Private properties

    private let firstDelivery: Int
    private let secondDelivery: Int?

    //MARK: - Initializer

    init(_ firstDelivery: Int, _ secondDelivery: Int?) {
        self.firstDelivery = firstDelivery
        self.secondDelivery = secondDelivery
    }
}
