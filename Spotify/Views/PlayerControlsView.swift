    //
    //  PlayerControlsView.swift
    //  Spotify
    //
    //  Created by LE BA TRONG on 25/02/2022.
    //

import Foundation
import UIKit

protocol PlayerControlsViewDelegate :AnyObject{
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardsButton(_ playerControlsView:PlayerControlsView)
    func playerControlsViewDidTapBackwardButton(_ playerControlsView:PlayerControlsView)
    func playerControlsView(_ playerControlsView:PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
    let title:String?
    let subtitle:String?
}

final class PlayerControlsView: UIView {
    private var isPlaying = true
    
    weak var delegate:PlayerControlsViewDelegate?
        //slider
    private let volumeSlider:UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
        //name label
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.text = "This is my Song"
        return label
    }()
        //subtitle Label
    private let subtitleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Drake"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
        //back button
    private let backButton:UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.tintColor = .label
        button.setImage(image, for: .normal)
        return button
    }()
    
        //next button
    private let nextButton:UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.tintColor = .label
        button.setImage(image, for: .normal)
        return button
    }()
        //Play and Pause button
    private let playPauseButton:UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.tintColor = .label
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didSlideSlider(_ slider:UISlider) {
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }
    @objc private func didTapBack() {
        delegate?.playerControlsViewDidTapBackwardButton(self)
    }
    
    @objc private func didTapNext() {
        delegate?.playerControlsViewDidTapForwardsButton(self)
    }
    
    @objc private func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPauseButton(self)

        // Update icon
        let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))

        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0,
                                 y: 0,
                                 width: width,
                                 height: 50)
        subtitleLabel.frame = CGRect(x: 0,
                                     y: nameLabel.bottom + 10,
                                     width: width,
                                     height: 50)
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom + 20, width: width-20, height: 44)
        let buttonSize:CGFloat = 60
        playPauseButton.frame = CGRect(x: (width-buttonSize)/2,
                                       y: volumeSlider.bottom+30,
                                       width: buttonSize,
                                       height: buttonSize)
        backButton.frame = CGRect(x: playPauseButton.left-80-buttonSize,
                                  y: playPauseButton.top,
                                  width: buttonSize,
                                  height: buttonSize)
        nextButton.frame = CGRect(x: playPauseButton.left+80+buttonSize,
                                  y: playPauseButton.top,
                                  width: buttonSize,
                                  height: buttonSize)
    }
    
    func configure(with viewModel:PlayerControlsViewViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
