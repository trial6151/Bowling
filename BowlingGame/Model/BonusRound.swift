//
//  BonusRound.swift
//  BowlingGame
//

import Foundation

class BonusRound: Round {

    //MARK: - Private properties

    private let firstRoll: Int
    private let secondRoll: Int?

    //MARK: - Initializer

    init(_ firstRoll: Int, _ secondRoll: Int?) {
        self.firstRoll = firstRoll
        self.secondRoll = secondRoll
    }
}
