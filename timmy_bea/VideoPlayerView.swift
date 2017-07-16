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
        slider.minimumTrackTintColor = ColorManager.customSand()
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChangedValue), for: .valueChanged)
        return slider
    }()
    
    @objc private func handleSliderChangedValue() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(slider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //
            })
        }
    }
    
    init(withFrame frame: CGRect, videoURLString: String) {
        super.init(frame: frame)
        
        setupGradientLayer()
        
        backgroundColor = UIColor.black
        setupVideoPlayer(withURLString: videoURLString)
        
        controlsContainerView.frame = self.bounds
        self.addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.isHidden = true
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        controlsContainerView.addSubview(slider)
        slider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        slider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupVideoPlayer(withURLString URLString: String) {
        let videoURL = NSURL(string: URLString)
        player = AVPlayer(url: videoURL! as URL)
        playerLayer = AVPlayerLayer(player: player)
        
        self.layer.addSublayer(playerLayer!)
        playerLayer?.frame = self.bounds
        
        player?.play()
        
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        //MARK:track progress of the video
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds) / 60)
            self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
            
            //slider value should move with current play time. Slider values between 0 - 1
            if let duration = self.player?.currentItem?.duration {
                let totalSeconds = CMTimeGetSeconds(duration)
                
                self.slider.value = Float(seconds / totalSeconds)
            }
        })
    }
    
    func redrawLayers() {
        playerLayer?.frame = self.bounds
        gradientLayer?.frame = self.bounds
    }
    
    //MARK: This function changes the play position of the video when the slider changes value
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            fadeButton()
            
            if let duration = player?.currentItem?.duration {
                let totalSeconds = CMTimeGetSeconds(duration)
                let secondsText = String(format: "%02d", Int(totalSeconds) % 60)
                let minutesText = String(format: "%02d", Int(totalSeconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer?.locations = [0.9, 1.6]
        controlsContainerView.layer.addSublayer(gradientLayer!)
    }
}
