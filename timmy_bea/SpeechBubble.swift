//
//  SpeechBubble.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-09.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class SpeechBubble: UIView, CAAnimationDelegate {

    override var frame: CGRect {
        didSet {
            setupTailLayer()
            setupBubbleLayer()
        }
    }
    
    var stretchLayer: CALayer?
    var tailLayer: CALayer?
    
    func setupBubbleLayer() {
        stretchLayer?.removeFromSuperlayer()
        
        if let image = UIImage(named: "speech_bubble") {
            let contentsCenter = CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5)
            
            stretchLayer = CALayer()
            stretchLayer?.frame = self.bounds
            stretchLayer?.contents = image.cgImage
            //don't forget this line - the image will not scale properly without it!
            stretchLayer?.contentsScale = UIScreen.main.scale
            stretchLayer?.contentsCenter = contentsCenter
            
            self.layer.insertSublayer(stretchLayer!, above: tailLayer)
        }
    }
    
    func setupTailLayer() {
        tailLayer?.removeFromSuperlayer()
        
        tailLayer = CALayer()
        //tailLayer?.backgroundColor = UIColor.red.cgColor
        tailLayer?.frame = CGRect(x: 50, y: self.bounds.height, width: 100, height: 50)
        tailLayer?.contents = UIImage(named: "tail")?.cgImage
        tailLayer?.contentsGravity = kCAGravityResizeAspect
        self.layer.addSublayer(tailLayer!)
    }
    
    func animateBubbleChange() {
        
        tailUpAnimation()
        Timer.scheduledTimer(timeInterval: animationDuration + 0.10, target: self, selector: #selector(stretchHeightAnimation), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: animationDuration * 3 + 0.10, target: self, selector: #selector(tailDownAnimation), userInfo: nil, repeats: false)
    }
    
    let animationDuration: CFTimeInterval = 0.2
    
    private func tailUpAnimation() {
        if let tailLayer = tailLayer {
            
            let beginTailPosition = CGPoint(x: 50 + (tailLayer.bounds.width / 2), y: self.bounds.height + (tailLayer.bounds.height / 2))
            let endTailPosition = CGPoint(x: 50 + (tailLayer.bounds.width / 2), y: self.bounds.height - (tailLayer.bounds.height / 2))
            let tailPositionAnimation = CABasicAnimation(keyPath: "position")
            tailPositionAnimation.fromValue = beginTailPosition
            tailPositionAnimation.toValue = endTailPosition
            tailPositionAnimation.beginTime = 0
            tailPositionAnimation.duration = animationDuration
            tailPositionAnimation.setValue("tail_up", forKey: "animation_name")
            tailPositionAnimation.delegate = self
            tailPositionAnimation.fillMode = kCAFillModeForwards
            tailPositionAnimation.isRemovedOnCompletion = false
            tailLayer.add(tailPositionAnimation, forKey: nil)
        }
    }
    
    
    @objc private func tailDownAnimation() {
        if let tailLayer = tailLayer {
            let beginTailPosition = CGPoint(x: 50 + (tailLayer.bounds.width / 2), y: self.bounds.height + (tailLayer.bounds.height / 2))
            let endTailPosition = CGPoint(x: 50 + (tailLayer.bounds.width / 2), y: self.bounds.height - (tailLayer.bounds.height / 2))
            let tailPositionAnimation = CABasicAnimation(keyPath: "position")
            tailPositionAnimation.fromValue = endTailPosition
            tailPositionAnimation.toValue = beginTailPosition
            tailPositionAnimation.beginTime = 0
            tailPositionAnimation.duration = animationDuration
            tailPositionAnimation.setValue("tail_down", forKey: "animation_name")
            tailPositionAnimation.delegate = self
            tailPositionAnimation.fillMode = kCAFillModeForwards
            tailPositionAnimation.isRemovedOnCompletion = false
            tailLayer.add(tailPositionAnimation, forKey: nil)
        }
        
    }
    
    
    @objc private func stretchHeightAnimation() {
        if let stretchLayer = stretchLayer {
            
            let beginHeight: CGFloat = self.bounds.height
            let endHeight: CGFloat = 40
            
            let heightAnimation = CABasicAnimation(keyPath: "bounds.size.height")
            heightAnimation.fromValue = beginHeight
            heightAnimation.toValue = endHeight
            heightAnimation.beginTime = 0
            heightAnimation.duration = animationDuration
            heightAnimation.autoreverses = true
            
            let beginPosition = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
            let endPosition = CGPoint(x: self.bounds.width / 2, y: endHeight / 2)
            
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.fromValue = NSValue.init(cgPoint: beginPosition)
            positionAnimation.toValue = NSValue.init(cgPoint: endPosition)
            positionAnimation.beginTime = 0
            positionAnimation.duration = animationDuration
            positionAnimation.autoreverses = true
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [heightAnimation, positionAnimation]
            animationGroup.duration = animationDuration * 2
            animationGroup.repeatCount = 1
            animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animationGroup.setValue("height_animation", forKey: "animation_name")
            animationGroup.delegate = self
            stretchLayer.add(animationGroup, forKey: nil)
        }
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        let animationName: String = anim.value(forKey: "animation_name") as! String
        
        switch animationName {
        case "tail_up":
            //print("tail up stopped")
            tailLayer?.isHidden = true
        case "height_animation":
            //print("height animation stopped")
            tailLayer?.isHidden = false
        case "tail_down":
            print("animation complete")
        default:
            print("no luck this time")
        }
    }
}



