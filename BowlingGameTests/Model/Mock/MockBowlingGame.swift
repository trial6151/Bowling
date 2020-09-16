//
//  MockBowlingGame.swift
//  BowlingGameTests
//

import Foundation
@testable import BowlingGame

class MockBowlingGame: BowlingGameProtocol {
    var delivery: Int?

    func deliveryAt(index: Int) -> Int? {
        self.delivery
    }
}
