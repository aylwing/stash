//
//  AchievementCollectionViewCell.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import UIKit

final class AchievementCollectionViewCell: UICollectionViewCell, NibLoadable {

    @IBOutlet private var levelLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var currentProgressLabel: UILabel!
    @IBOutlet private var totalProgressLabel: UILabel!
    @IBOutlet private var progressBarView: UIProgressView!

    var achievement: Achievement! {
        didSet {
            setUI()
        }
    }

    private func setUI() {

        setShadowLayer()

        set(points: achievement.progress, for: currentProgressLabel)
        set(points: achievement.total, for: totalProgressLabel
        )
        levelLabel.layer.opacity = 0.9
        levelLabel.attributedText = NSMutableAttributedString()
            .normal("Level")
            .normal("\n")
            .bold(achievement.level, size: 45, weight: 1)

        progressBarView.progress = 0
        
        if achievement.progress > 0 {
            let progressOutOfOneHundreadPercent = Double(100 / (achievement.total / achievement.progress))
            let progressInDecimal = Float(progressOutOfOneHundreadPercent * 0.01)
            progressBarView.setProgress(progressInDecimal, animated: false)
        }

        progressBarView.trackTintColor = .white
        progressBarView.progressTintColor = #colorLiteral(red: 0.4451607466, green: 0.790314734, blue: 0.3629356027, alpha: 1)
        imageView.downloadImageFrom(url: achievement.bg_image_url, didFinish: updateViewEnabledStatus)
    }

    private func updateViewEnabledStatus() {
        if !achievement.accessible {
            backgroundColor = .clear
            contentView.layer.opacity = 0.5
        }
    }

    private func setShadowLayer() {
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
    }

    private func set(points: Int, for label: UILabel) {
        label.text = "\(points)pts"
    }
}
