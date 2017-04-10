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
            setupBubbleLayer()
        }
    }
    
    var stretchLayer: CALayer?
    var tailLayer: CALayer?
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .justified
        textView.textColor = ColorManager.customDarkBlue()
        textView.font = FontManager.AvenirNextMedium(size: 16)
        textView.isEditable = false
        return textView
    }()
    
    var displayText: String?
    
    func setupBubbleLayer() {
        stretchLayer?.removeFromSuperlayer()
        
        if let image = UIImage(named: "speech_bubble") {
            let contentsCenter = CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5)
            
            stretchLayer = CALayer()
            stretchLayer?.frame = self.bounds
            stretchLayer?.contents = image.cgImage
            stretchLayer?.contentsScale = UIScreen.main.scale
            stretchLayer?.contentsCenter = contentsCenter
            
            self.layer.addSublayer(stretchLayer!)
        }
        
        textView.frame = CGRect(x: CGFloat(pad), y: CGFloat(pad), width: self.bounds.width - CGFloat(2 * pad), height: self.bounds.height - CGFloat(2 * pad))
        
        if displayText != nil {
            textView.text = displayText
        }
        self.addSubview(textView)
    }
    
    func setupTailLayer(origin: CGPoint, portrait: Bool) {
        tailLayer?.removeFromSuperlayer()
        
        tailLayer = CALayer()
        
        if portrait {
            tailLayer?.frame = CGRect(x: origin.x, y: self.bounds.height, width: 100, height: 50)
            tailLayer?.contents = UIImage(named: "tail")?.cgImage
            tailLayer?.contentsGravity = kCAGravityResizeAspect
            
            beginTailPosition = CGPoint(x: origin.x + (tailLayer!.bounds.width / 2), y: self.bounds.height + (tailLayer!.bounds.height / 2))
            endTailPosition = CGPoint(x: origin.x + (tailLayer!.bounds.width / 2), y: self.bounds.height - (tailLayer!.bounds.height / 2))
            
        } else {
            tailLayer?.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
            tailLayer?.contents = UIImage(named: "tail")?.cgImage
            tailLayer?.contentsGravity = kCAGravityResizeAspect
        
            let degrees = 90.0
            let radians = CGFloat(degrees * Double.pi / 180)
            tailLayer?.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
            
            tailLayer?.frame.origin = CGPoint(x: (tailLayer?.frame.width)! * -1, y: origin.y)
            
            beginTailPosition = CGPoint(x: (tailLayer?.frame.origin.x)! / 2, y: (tailLayer?.frame.origin.y)! + ((tailLayer?.frame.height)! / 2))
            endTailPosition = CGPoint(x: (tailLayer?.frame.width)! / 2, y: beginTailPosition.y)
        }
        
        if let stretchLayer = self.stretchLayer {
            self.layer.insertSublayer(tailLayer!, below: stretchLayer)
        }
    }
    
    func animateBubbleChange() {
        
        textView.alpha = 0
        
        var time: CFTimeInterval = 0.0
        tailUpAnimation()
        
        time += tailAnimationDuration + 0.10
        Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(stretchHeightAnimation), userInfo: nil, repeats: false)
        
        time += bubbleAnimationDuration * 2
        Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(tailDownAnimation), userInfo: nil, repeats: false)
    }
    
    let tailAnimationDuration: CFTimeInterval = 0.05
    let bubbleAnimationDuration: CFTimeInterval = 0.2
    
    var beginTailPosition = CGPoint.zero
    var endTailPosition = CGPoint.zero
    
    private func tailUpAnimation() {
        if let tailLayer = tailLayer {
            
            let tailPositionAnimation = CABasicAnimation(keyPath: "position")
            tailPositionAnimation.fromValue = beginTailPosition
            tailPositionAnimation.toValue = endTailPosition
            tailPositionAnimation.beginTime = 0
            tailPositionAnimation.duration = tailAnimationDuration
            tailPositionAnimation.setValue("tail_up", forKey: "animation_name")
            tailPositionAnimation.delegate = self
            tailPositionAnimation.fillMode = kCAFillModeForwards
            tailPositionAnimation.isRemovedOnCompletion = false
            tailLayer.add(tailPositionAnimation, forKey: nil)
        }
    }
    
    @objc private func tailDownAnimation() {
        if let tailLayer = tailLayer {
            let tailPositionAnimation = CABasicAnimation(keyPath: "position")
            tailPositionAnimation.fromValue = endTailPosition
            tailPositionAnimation.toValue = beginTailPosition
            tailPositionAnimation.beginTime = 0
            tailPositionAnimation.duration = tailAnimationDuration
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
            heightAnimation.duration = bubbleAnimationDuration
            heightAnimation.autoreverses = true
            
            let beginPosition = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
            let endPosition = CGPoint(x: self.bounds.width / 2, y: endHeight / 2)
            
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.fromValue = NSValue.init(cgPoint: beginPosition)
            positionAnimation.toValue = NSValue.init(cgPoint: endPosition)
            positionAnimation.beginTime = 0
            positionAnimation.duration = bubbleAnimationDuration
            positionAnimation.autoreverses = true
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [heightAnimation, positionAnimation]
            animationGroup.duration = bubbleAnimationDuration * 2
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
            tailLayer?.isHidden = true
        case "height_animation":
            tailLayer?.isHidden = false
        case "tail_down":
            textView.text = displayText
            textView.alpha = 1
        default:
            print("no luck this time")
            
        }
    }
}



