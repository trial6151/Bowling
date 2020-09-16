//
//  BonusRound.swift
//  BowlingGame
//

import Foundation

class BonusRound: Round {

    //MARK: - Internal properties

    let firstRoll: Int

    //MARK: - Private properties

    private let secondRoll: Int?

    //MARK: - Initializer

    init(_ firstRoll: Int, _ secondRoll: Int?) {
        self.firstRoll = firstRoll
        self.secondRoll = secondRoll
    }
}
