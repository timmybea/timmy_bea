//
//  VideoLauncher.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-28.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background_gradient")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var videoPlayerView: VideoPlayerView?
    
    var screenSize = ScreenSize()
    
    var isVideoLaunched = false
    
    func launchVideo() {
        //setup background view with animation
        if let window = UIApplication.shared.keyWindow {
            imageView.frame = window.frame
            imageView.backgroundColor = UIColor.white
            
            //Note that this height is for standard 16:9 screen ratio used by youtube
            screenSize.width = Int(window.frame.width) + 2
            
            
            let frame = CGRect(x: 0, y: 40, width: screenSize.width, height: screenSize.height)
            videoPlayerView = VideoPlayerView(frame: frame)
            imageView.addSubview(videoPlayerView!)
            
            imageView.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            
            window.addSubview(imageView)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.imageView.frame = window.frame
                
            }, completion: { (true) in
                //print("animation complete")
                self.isVideoLaunched = true
            })
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let window = UIApplication.shared.keyWindow {
                self.imageView.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            }
        }, completion: { (true) in
            //print("animation complete")
            self.isVideoLaunched = false
        })
    }

    func redrawVideoScreen() {
        
        if UIDevice.current.orientation.isPortrait {
            if let window = UIApplication.shared.keyWindow {
                imageView.frame = window.frame
//                screenSize.width = Int(imageView.frame.width)
//                videoPlayerView?.frame = CGRect(x: 0, y: 40, width: screenSize.width, height: screenSize.height)
            }
        } else {
            if let window = UIApplication.shared.keyWindow {
                imageView.frame = window.frame
//                screenSize.width = Int(imageView.frame.width)
//                videoPlayerView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
            }
        }
    }
}
