//
//  Bonusable.swift
//  BowlingGame
//

import Foundation

protocol Bonusable {
    var bonusScore: Int { get }
    var numberOfRollsToCalculateBonus: Int { get }
}

extension Bonusable {
    var numberOfRollsToCalculateBonus: Int {
        1
    }
}
