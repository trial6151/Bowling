//
//  HomeViewController.swift
//  BowlingGame
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {

    //MARK: - IBActions

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var rollSequenceLabel: UILabel!
    @IBOutlet private weak var finalScoreLabel: UILabel!

    //MARK: - Private properties

    private let homeViewModel = HomeViewModel(allowedScores: Factory.createAllowedScores(),
                                              bowlingGame: Factory.createBowlingGame())

    //MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = homeViewModel
    }

    //MARK: - IBActions
    
    @IBAction func showFinalScoreButtonTapped(sender: UIButton) {
        self.finalScoreLabel.text = self.homeViewModel.finalScore
    }

    @IBAction func resetGameButtonTapped(sender: UIButton) {
        self.finalScoreLabel.text = "Final Score will be displayed here"
        self.rollSequenceLabel.text = "Rolls will be displayed here"
        self.homeViewModel.resetGame()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scoreValue = self.homeViewModel.scoreCollectionViewCellViewModels[indexPath.row].scoreValue
        self.homeViewModel.rolls.append(scoreValue)
        self.rollSequenceLabel.text = self.homeViewModel.rollsSequenceString
    }

}

