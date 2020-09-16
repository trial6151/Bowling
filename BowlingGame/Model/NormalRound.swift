//
//  NormalRound.swift
//  BowlingGame
//

import Foundation

class NormalRound: Round {

    //MARK: - Internal properties

    var score: Int {
        self.firstRoll + self.secondRoll
    }

    //MARK: - Private properties

    private let firstRoll: Int
    private let secondRoll: Int

    //MARK: - Initializer

    init(_ firstRoll: Int, _ secondRoll: Int) {
        self.firstRoll = firstRoll
        self.secondRoll = secondRoll
    }

}
