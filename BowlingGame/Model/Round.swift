//
//  Round.swift
//  BowlingGame
//

import Foundation

protocol Round {
    var score: Int { get }
    var firstRoll: Int { get }
}

extension Round {
    var score: Int {
        0
    }
}
