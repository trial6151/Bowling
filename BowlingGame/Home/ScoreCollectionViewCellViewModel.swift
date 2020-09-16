//
//  ScoreCollectionViewCellViewModel.swift
//  BowlingGame
//

import UIKit

class ScoreCollectionViewCellViewModel {

    //MARK: - Internal properties

    var scoreValue: Int {
        self.score
    }

    //MARK: - Private properties

    private let score: Int

    //MARK: - Initializer

    init(score: Int) {
        self.score = score
    }

}
