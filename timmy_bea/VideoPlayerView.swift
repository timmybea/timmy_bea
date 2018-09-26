//
//  VideoPlayerView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-29.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    //MARK: Properties
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var gradientLayer: CAGradientLayer?

    private var isSettingPlay = true
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    private let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(handlePausePlayTouch), for: .touchUpInside)
        return button
    }()
    
    private let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    var videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor.Theme.customSand.color
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChangedValue), for: .valueChanged)
        return slider
    }()
    
    //MARK: Initializer
    init(withFrame frame: CGRect, videoURLString: String) {
        super.init(frame: frame)
        
        setupGradientLayer()
        backgroundColor = UIColor.black
        
        setupVideoPlayer(with: videoURLString)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: @objc methods
    @objc private func handleTapGesture() {
        handlePausePlayTouch()
    }
    
    @objc private func handlePausePlayTouch() {
        if isSettingPlay {
            player?.pause()
            pausePlayButton.alpha = 1
            let image = UIImage(named: "Play")
            pausePlayButton.setImage(image, for: .normal)
            isSettingPlay = false
        } else {
            player?.play()
            pausePlayButton.alpha = 1
            let image = UIImage(named: "Pause")
            pausePlayButton.setImage(image, for: .normal)
            isSettingPlay = true
            fadeButton()
        }
    }
    
    @objc private func handleSliderChangedValue() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(slider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (_) in })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard keyPath == AVPlayer.observableKey.loadedTimeRanges.rawValue else { return }
        
        activityIndicatorView.stopAnimating()
        controlsContainerView.backgroundColor = UIColor.clear
        pausePlayButton.isHidden = false
        fadeButton()
        
        guard let duration = player?.currentItem?.duration else { return }
        
        videoLengthLabel.text = String.duration(from: duration)
    }
  
}

//MARK: UI Layout
extension VideoPlayerView {
    
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer?.locations = [0.9, 1.6]
        controlsContainerView.layer.addSublayer(gradientLayer!)
    }
    
    private func setupSubviews() {
        
        controlsContainerView.frame = self.bounds
        self.addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.isHidden = true
        NSLayoutConstraint.activate([
            pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pausePlayButton.widthAnchor.constraint(equalToConstant: 50),
            pausePlayButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        controlsContainerView.addSubview(videoLengthLabel)
        NSLayoutConstraint.activate([
            videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            videoLengthLabel.widthAnchor.constraint(equalToConstant: 45),
            videoLengthLabel.heightAnchor.constraint(equalToConstant: 22)
            ])
        
        controlsContainerView.addSubview(currentTimeLabel)
        NSLayoutConstraint.activate([
            currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            currentTimeLabel.widthAnchor.constraint(equalToConstant: 45),
            currentTimeLabel.heightAnchor.constraint(equalToConstant: 22)
            ])
        
        controlsContainerView.addSubview(slider)
        NSLayoutConstraint.activate([
            slider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor),
            slider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            slider.heightAnchor.constraint(equalToConstant: 24)
            ])
    }
    
    func redrawLayers() {
        playerLayer?.frame = self.bounds
        gradientLayer?.frame = self.bounds
    }
    
    private func fadeButton() {
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.animate(withDuration: 1, animations: {
                if self.isSettingPlay {
                    self.pausePlayButton.alpha = 0
                }
            })
        }
    }
}

//MARK: Player logic
extension VideoPlayerView {
    
    private func setupVideoPlayer(with path: String) {
        addPlayer(with: path)
        
        player?.play()
        
        player?.addObserver(self, forKeyPath: AVPlayer.observableKey.loadedTimeRanges.rawValue, options: .new, context: nil)
        
        trackVideoProgress()
    }
    
    private func addPlayer(with urlPath: String) {
        let videoURL = NSURL(string: urlPath)!
        player = AVPlayer(url: videoURL as URL)
        playerLayer = AVPlayerLayer(player: player)
        
        self.layer.addSublayer(playerLayer!)
        playerLayer?.frame = self.bounds
    }
    
    private func trackVideoProgress() {
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            self.currentTimeLabel.text = String.duration(from: progressTime)
            if let player = self.player {
                self.slider.setSliderValue(for: player, progress: progressTime)
            }
        })
    }

}
