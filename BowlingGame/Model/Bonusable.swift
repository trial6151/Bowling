//
//  Bonusable.swift
//  BowlingGame
//

import Foundation

protocol Bonusable {
    var bonusScore: Int { get }
    var numberOfDeliveriesToCalculateBonus: Int { get }
}

extension Bonusable {
    var numberOfDeliveriesToCalculateBonus: Int {
        1
    }
}
