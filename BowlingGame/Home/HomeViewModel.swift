//
//  HomeViewModel.swift
//  BowlingGame
//

import UIKit

// To conform to UICollectionViewDataSource, class has to conform to NSObjectProtocol
class HomeViewModel: NSObject {

    //MARK: - Internal properties

    var scoreCollectionViewCellViewModels: [ScoreCollectionViewCellViewModel] {
        self.allowedScores.map { ScoreCollectionViewCellViewModel(score: $0) }
    }

    var rollsSequenceString: String {
        self.rolls.reduce("") { (partialResult, roll) -> String in
            partialResult == "" ? "\(roll)" : partialResult + ", \(roll)"
        }
    }

    var alertMessage: String {
        "You may have entered wrong number of frames. Please reset game and try again."
    }

    var rollSequenceInitialMessage: String {
        "Rolls will be displayed here"
    }
    
    var rolls = [Int]()

    //MARK: - Private properties

    private let allowedScores: [Int]
    private let bowlingGame: BowlingGameProtocol

    //MARK: - Initializer

    init(allowedScores: [Int], bowlingGame: BowlingGameProtocol) {
        self.allowedScores = allowedScores
        self.bowlingGame = bowlingGame
    }

    //MARK: - Internal methods

    func getFinalScore() throws -> String {
        let finalScore = try self.bowlingGame.getGamesFinalScore(rolls: self.rolls)
        return String(finalScore)
    }

    func resetGame() {
        self.rolls.removeAll()
    }

}
