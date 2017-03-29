//
//  VideoLauncher.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-28.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {

    
    var isVideoLaunched = false
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background_gradient")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    func launchVideo() {
        if let window = UIApplication.shared.keyWindow {
            
            
            //Note that this height is for standard 16:9 screen ratio used by youtube
            //let height = view.frame.width * 9 / 16
            //let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
            //                let videoPlayerView = VideoPlayerView(frame: frame)
            
            window.addSubview(imageView)
            imageView.frame = window.frame
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            imageView.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            
            //               view.addSubview(videoPlayerView)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.imageView.frame = window.frame
            }, completion: { (true) in
                //UIApplication.shared.setStatusBarHidden(true, with: .slide)
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
            //UIApplication.shared.setStatusBarHidden(false, with: .slide)
            self.isVideoLaunched = false
        })
    }
    
    func redrawVideoScreen() {
        if UIDevice.current.orientation.isPortrait {
            if let window = UIApplication.shared.keyWindow {
                imageView.frame = window.frame
            }
        } else {
            if let window = UIApplication.shared.keyWindow {
                imageView.frame = window.frame
            }
        }
    }
}
