//
//  Bonusable.swift
//  BowlingGame
//

import Foundation

protocol Bonusable {
    var bonusScore: Int { get }
    var numberOfDeliveriesToCalculateBonus: Int { get }
}
