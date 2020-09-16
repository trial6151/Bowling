//
//  ScoreCollectionViewCell.swift
//  BowlingGame
//

import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {

    //MARK: - IBActions

    @IBOutlet private weak var scoreLabel: UILabel!

    //MARK: - Life cycle methods

    override func prepareForReuse() {
        super.prepareForReuse()
        self.scoreLabel.text = nil
    }

    //MARK: - Internal methods

    func configure(vm: ScoreCollectionViewCellViewModel) {
        self.scoreLabel.text = String(vm.scoreValue)
    }
    
}
