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

    var finalScore: String {
        String(self.bowlingGame.getGamesFinalScore(rolls: self.rolls))
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

    func resetGame() {
        self.rolls.removeAll()
        self.bowlingGame.resetGame()
    }

}

//MARK: - UICollectionViewDataSource methods

extension HomeViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.scoreCollectionViewCellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScoreCollectionViewCell", for: indexPath) as? ScoreCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(vm: self.scoreCollectionViewCellViewModels[indexPath.row])
        return cell
    }
}
