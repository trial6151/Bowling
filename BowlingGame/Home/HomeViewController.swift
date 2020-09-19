//
//  HomeViewController.swift
//  BowlingGame
//

import UIKit

class HomeViewController: UIViewController {

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
        self.collectionView.dataSource = self
    }

    //MARK: - IBActions
    
    @IBAction func showFinalScoreButtonTapped(sender: UIButton) {
        do {
            self.finalScoreLabel.text = try self.homeViewModel.getFinalScore()
        } catch {
            let alert = UIAlertController(title: nil,
                                          message: self.homeViewModel.alertMessage,
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }

        self.homeViewModel.resetGame()
    }

    @IBAction func resetGameButtonTapped(sender: UIButton) {
        self.homeViewModel.resetGame()
        self.rollSequenceLabel.text = self.homeViewModel.rollSequenceInitialMessage
        self.finalScoreLabel.text = "0"
    }

}

//MARK: - UICollectionViewDataSource methods

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.homeViewModel.scoreCollectionViewCellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScoreCollectionViewCell", for: indexPath) as? ScoreCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(vm: self.homeViewModel.scoreCollectionViewCellViewModels[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegate methods

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scoreValue = self.homeViewModel.scoreCollectionViewCellViewModels[indexPath.row].scoreValue
        self.homeViewModel.rolls.append(scoreValue)
        self.rollSequenceLabel.text = self.homeViewModel.rollsSequenceString
    }
}
