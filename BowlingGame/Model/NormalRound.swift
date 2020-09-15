//
//  NormalRound.swift
//  BowlingGame
//

import Foundation

class NormalRound: Round {

    //MARK: - Internal properties

    var score: Int {
        self.firstDelivery + self.secondDelivery
    }

    //MARK: - Private properties

    private let firstDelivery: Int
    private let secondDelivery: Int

    //MARK: - Initializer

    init(_ firstDelivery: Int, _ secondDelivery: Int) {
        self.firstDelivery = firstDelivery
        self.secondDelivery = secondDelivery
    }

}
