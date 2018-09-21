//
//  VideoLauncher.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-28.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {

    
    private var project: Project? {
        didSet {
            titleLabel.text = project?.title
            completedLabel.text = project?.dateCompleted
        }
    }
    
    private var imageView: UIImageView = {
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
    
    private var screenSize = ScreenSize()
    
    var isVideoLaunched = false
    
    func launchVideo(withProject project: Project) {
        self.project = project
        
        if let window = UIApplication.shared.keyWindow {
            imageView.frame = window.frame

            screenSize.width = Int(window.frame.width) + 2
            
            if UIApplication.shared.statusBarOrientation.isPortrait {
                let frame = CGRect(x: 0, y: 40, width: screenSize.width, height: screenSize.height)
                videoPlayerView = VideoPlayerView(withFrame: frame, videoURLString: (self.project?.videoURL)!)
            } else {
                let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
                videoPlayerView = VideoPlayerView(withFrame: frame, videoURLString: (self.project?.videoURL)!)
            }
            imageView.addSubview(videoPlayerView!)
            setupVideoInfoViews()
            
            imageView.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            window.addSubview(imageView)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.imageView.frame = window.frame
            }, completion: { (true) in
                self.isVideoLaunched = true
            })
        }
     
        let attributedString = NSMutableAttributedString()
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.justified
        
        attributedString.append(NSAttributedString(string: project.longDescription, attributes: [NSAttributedStringKey.font: UIFont.Theme.bodyText.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color, NSAttributedStringKey.paragraphStyle: style]))
        
        style.alignment = NSTextAlignment.left
        attributedString.append(NSAttributedString(string: "\n\nLanguages: ", attributes: [NSAttributedStringKey.font: UIFont.Theme.bodyText.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color, NSAttributedStringKey.paragraphStyle: style]))
        
        attributedString.append(NSAttributedString(string: project.languages, attributes: [NSAttributedStringKey.font: UIFont.Theme.bodyText.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
        
        attributedString.append(NSAttributedString(string: "\n\nFrameworks: ", attributes: [NSAttributedStringKey.font: UIFont.Theme.bodyText.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
        
        attributedString.append(NSAttributedString(string: project.frameWorks, attributes: [NSAttributedStringKey.font: UIFont.Theme.bodyText.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
        
        longDescTextView.attributedText = attributedString
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let window = UIApplication.shared.keyWindow {
                self.imageView.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            }
        }, completion: { (true) in
            self.videoPlayerView = nil
            self.isVideoLaunched = false
            self.dismissTouchView.removeFromSuperview()
        })
    }

    func redrawVideoScreen() {
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            if let window = UIApplication.shared.keyWindow {
                imageView.frame = window.frame
                screenSize.width = Int(imageView.frame.width)
                videoPlayerView?.frame = CGRect(x: 0, y: 40, width: screenSize.width, height: screenSize.height)
                videoPlayerView?.redrawLayers()
                setupVideoInfoViews()
            }
        } else {
            if let window = UIApplication.shared.keyWindow {
                imageView.frame = window.frame
                screenSize.width = Int(imageView.frame.width)
                videoPlayerView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
                videoPlayerView?.redrawLayers()
                setupVideoInfoViews()
            }
        }
    }
    
    
    //MARK: Setup of text view components
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Theme.customDarkBlue.color
        view.alpha = 0.4
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let activeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Theme.header.font
        label.textColor = UIColor.Theme.customSand.color
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    private let completedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.Theme.bodyText.font
        label.textColor = UIColor.Theme.customSand.color
        label.textAlignment = .right
        return label
    }()
    
    private let longDescTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.Theme.customSand.color
        textView.textAlignment = .justified
        textView.font = UIFont.Theme.bodyText.font
        return textView
    }()
    
    private func setupVideoInfoViews() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            imageView.addSubview(activeView)
            activeView.addSubview(blueView)
            activeView.addSubview(titleLabel)
            activeView.addSubview(completedLabel)
            activeView.addSubview(longDescTextView)
            imageView.addSubview(dismissTouchView)

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
        
        var currentY = 40 + screenSize.height + 24
        
        let activeHeight = Int(imageView.bounds.height) - currentY - 24
        activeView.frame = CGRect(x: 24, y: currentY, width: Int(imageView.bounds.width) - 48, height: activeHeight)
        
        blueView.frame = activeView.bounds
        
//        currentY = pad
//        titleLabel.frame = CGRect(x: pad, y: currentY, width: (Int(blueView.frame.width) - (2 * pad)) / 2, height: 22)
        
        let currentX = Int(8 + titleLabel.frame.width)
        completedLabel.frame = CGRect(x: currentX, y: currentY, width: Int(titleLabel.frame.width), height: 22)
        
        currentY += Int(titleLabel.frame.height)
//        longDescTextView.frame = CGRect(x: 4, y: currentY, width: Int(blueView.frame.width) - (2 * 4), height: Int(blueView.frame.height) - currentY - pad)
        
        let dismissY: CGFloat = CGFloat(40 + screenSize.height)
        dismissTouchView.frame = CGRect(x: 0, y: dismissY, width: imageView.frame.width, height: imageView.frame.height - CGFloat(dismissY))
        dismissTouchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
}
