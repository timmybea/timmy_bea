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
    
    //    let videoPlayerView: VideoPlayerView = {
    //        let view = VideoPlayerView()
    //        return view
    //    }()
    
    func launchVideo() {
        //setup background view with animation
        if let window = UIApplication.shared.keyWindow {
            imageView.frame = window.frame
            imageView.backgroundColor = UIColor.white
            
            //Note that this height is for standard 16:9 screen ratio used by youtube
            let height = imageView.frame.width * 9 / 16
            let frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: frame)
            
            imageView.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            imageView.addSubview(videoPlayerView)
            window.addSubview(imageView)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.imageView.frame = window.frame
                
            }, completion: { (true) in
                //print("animation complete")
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
        })
    }
    
    
    
    
    
    
    
//   var isVideoLaunched = false
    


//    
//    var screenSize = ScreenSize()
//    
//    func launchVideo() {
//        if let window = UIApplication.shared.keyWindow {
//            
//            window.addSubview(view)
//            view.frame = window.frame
//            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
//
//            layoutVideoPlayerView()
//            view.addSubview(videoPlayerView)
//            
//            view.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
//            
//            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.view.frame = window.frame
//            }, completion: { (true) in
//                //UIApplication.shared.setStatusBarHidden(true, with: .slide)
//                self.isVideoLaunched = true
//            })
//        }
//    }
//    
//    func handleDismiss() {
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            
//            if let window = UIApplication.shared.keyWindow {
//                self.view.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
//            }
//        }, completion: { (true) in
//            //UIApplication.shared.setStatusBarHidden(false, with: .slide)
//            self.isVideoLaunched = false
//        })
//    }
//    
//    func redrawVideoScreen() {
//        if UIDevice.current.orientation.isPortrait {
//            if let window = UIApplication.shared.keyWindow {
//                view.frame = window.frame
//                layoutVideoPlayerView()
//            }
//        } else {
//            if let window = UIApplication.shared.keyWindow {
//                view.frame = window.frame
//                layoutVideoPlayerView()
//            }
//        }
//    }
//    
//    func layoutVideoPlayerView() {
//        
//        screenSize.width = Int(view.frame.width)
//    
//        if UIDevice.current.orientation.isPortrait {
//            videoPlayerView.frame = CGRect(x: 0, y: 40, width: screenSize.width + 2, height: screenSize.height)
//        } else {
//            videoPlayerView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        }
//    }
}
