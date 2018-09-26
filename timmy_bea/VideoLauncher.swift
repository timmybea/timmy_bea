//
//  VideoLauncher.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-28.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {

    //MARK: Non-UI Properties
    private var project: Project? {
        didSet {
            titleLabel.text = project?.title
            completedLabel.text = project?.dateCompleted
        }
    }
    
    private var screenSize = ScreenSize()
    
    var isVideoLaunched = false
    
    //MARK: UIProperties
    private var backgroundView: UIImageView = {
        let imageView = UIImageView.createWith(imageName: UIImage.Theme.backgroundGradient.name, contentMode: .scaleAspectFill)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let dismissTouchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private var videoPlayerView: VideoPlayerView?
    
    private let blueView: UIView = UIView.blueView()
    
    private let activeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()

    private let titleLabel: UILabel = UILabel.createLabelWith(text: "title",
                                                              color: UIColor.Theme.customSand.color,
                                                              font: UIFont.Theme.header.font)
    
    private let completedLabel: UILabel = {
        let label = UILabel.createLabelWith(text: "title",
                                            color: UIColor.Theme.customSand.color,
                                            font: UIFont.Theme.bodyText.font)
        label.textAlignment = .right
        return label
    }()
    
    private let longDescTextView: UITextView = UITextView.createUneditableTextView(with: "description",
                                                                                   color: UIColor.Theme.customSand.color,
                                                                                   font: UIFont.Theme.bodyText.font)
    
    @objc func handleDismiss() {
        animate(isLaunch: false)
    }

}


//MARK: methods
extension VideoLauncher {
    
    func launchVideo(withProject project: Project) {
        self.project = project
        layoutVideoPlayerView()
        setTextForLongDescription(with: project)
    }
    
    private func layoutVideoPlayerView() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let videoURL = self.project?.videoURL else { return }
        backgroundView.frame = window.frame
        screenSize.width = window.frame.width + 2
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        let y: CGFloat = isPortrait ? 40 : 0
        let frame = CGRect(x: 0, y: y, width: screenSize.width, height: screenSize.height)
        videoPlayerView = VideoPlayerView(withFrame: frame, videoURLString: videoURL)
        
        backgroundView.addSubview(videoPlayerView!)
        
        setupVideoInfoViews()
        
        backgroundView.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
        window.addSubview(backgroundView)
        
        animate(isLaunch: true)
        
    }
    
    private func setTextForLongDescription(with project: Project) {
        let attributedParagraph = AttributedParagraph()
        attributedParagraph.append(text: project.longDescription, font: UIFont.Theme.bodyText.font, alignment: .justified)
        attributedParagraph.append(text: "\n\nLanguages: ", font: UIFont.Theme.subHeader.font, alignment: .left)
        attributedParagraph.append(text: project.languages, font: UIFont.Theme.bodyText.font, alignment: .left)
        attributedParagraph.append(text: "\n\nFrameworks: ", font: UIFont.Theme.subHeader.font, alignment: .left)
        attributedParagraph.append(text: project.frameworks, font: UIFont.Theme.bodyText.font, alignment: .left)
        longDescTextView.attributedText = attributedParagraph.attributedText
    }
    
    private func animate(isLaunch: Bool) {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let x = isLaunch ? 0 : window.frame.width
            let y = isLaunch ? 0 : window.frame.height
            let width = isLaunch ? window.frame.width : 0
            let height = isLaunch ? window.frame.height : 0
            self.backgroundView.frame = CGRect(x: x, y: y, width: width, height: height)
        }, completion: { (true) in
            
            self.videoPlayerView = isLaunch ? self.videoPlayerView : nil
            self.isVideoLaunched = isLaunch ? true : false
            if !isLaunch {
                self.dismissTouchView.removeFromSuperview()
            }
        })
    }
    
    func redrawVideoScreen() {
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        guard let window = UIApplication.shared.keyWindow else { return }
        
        backgroundView.frame = window.frame
        screenSize.width = backgroundView.frame.width
        let y: CGFloat = isPortrait ? 40 : 0
        videoPlayerView?.frame = CGRect(x: 0,
                                        y: y,
                                        width: screenSize.width,
                                        height: screenSize.height)
        videoPlayerView?.redrawLayers()
        setupVideoInfoViews()
        
    }
    
    private func setupVideoInfoViews() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            backgroundView.addSubview(activeView)
            activeView.addSubview(blueView)
            activeView.addSubview(titleLabel)
            activeView.addSubview(completedLabel)
            activeView.addSubview(longDescTextView)
            backgroundView.addSubview(dismissTouchView)
            
            layoutVideoInfoViews()
        } else {
            activeView.removeFromSuperview()
            blueView.removeFromSuperview()
            titleLabel.removeFromSuperview()
            completedLabel.removeFromSuperview()
            longDescTextView.removeFromSuperview()
            dismissTouchView.removeFromSuperview()
        }
    }
    
    private func layoutVideoInfoViews() {
        
        guard let playerView = videoPlayerView else { return }
        let cellPad: CGFloat = 24.0
        let y = playerView.frame.origin.y + screenSize.height + cellPad
        let activeHeight = backgroundView.bounds.height - y - cellPad
        
        activeView.frame = CGRect(x: cellPad,
                                  y: y,
                                  width: backgroundView.bounds.width - (2 * cellPad),
                                  height: activeHeight)
        
        blueView.frame = activeView.bounds
        
        titleLabel.frame = CGRect(x: CGFloat.pad,
                                  y: CGFloat.pad,
                                  width: (blueView.frame.width - (2 * CGFloat.pad)) / 2,
                                  height: 22)
        
        completedLabel.frame = CGRect(x: titleLabel.frame.maxX,
                                      y: CGFloat.pad,
                                      width: titleLabel.frame.width,
                                      height: 22)
        
        longDescTextView.frame = CGRect(x: 4,
                                        y: titleLabel.frame.maxY,
                                        width: blueView.frame.width - CGFloat(2 * 4),
                                        height: blueView.frame.height - completedLabel.frame.maxY - CGFloat.pad)
        
        
        let dismissY: CGFloat = playerView.frame.maxY
        dismissTouchView.frame = CGRect(x: 0,
                                        y: dismissY,
                                        width: backgroundView.frame.width,
                                        height: backgroundView.frame.height - dismissY)
        dismissTouchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
}
