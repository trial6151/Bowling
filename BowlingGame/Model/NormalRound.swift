//
//  NormalRound.swift
//  BowlingGame
//

import Foundation

class NormalRound: Round {

    //MARK: - Internal properties

    let firstRoll: Int

    var score: Int {
        self.firstRoll + self.secondRoll
    }

    //MARK: - Private properties

    private let secondRoll: Int

    //MARK: - Initializer

    init(_ firstRoll: Int, _ secondRoll: Int) {
        self.firstRoll = firstRoll
        self.secondRoll = secondRoll
    }

}
