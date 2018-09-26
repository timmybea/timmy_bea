//
//  SpeechBubble.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-09.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Properties
class SpeechBubble: UIView, CAAnimationDelegate {

    override var frame: CGRect {
        didSet {
            setupBubbleLayer()
        }
    }
    
    private var stretchLayer: CALayer?
    
    private var tailLayer: CALayer?

    private var textView: UITextView = {
        let tv = UITextView.createUneditableTextView(with: "",
                                                     color: UIColor.Theme.customDarkBlue.color,
                                                     font: UIFont.Theme.subHeader.font)
        tv.textAlignment = .center
        return tv
    }()
    
    var displayText: String?
    
    private let tailAnimationDuration: CFTimeInterval = 0.05
    private let bubbleAnimationDuration: CFTimeInterval = 0.2
    
    private var beginTailPosition = CGPoint.zero
    private var endTailPosition = CGPoint.zero
    
    
    
    @objc private func performTailDownAnimation() {
        tailDownAnimation()
    }
    
    
    @objc private func performStretchHeightAnimation() {
        stretchHeightAnimation()
    }
}

//MARK: Subview and layer setup
extension SpeechBubble {
    
    private func setupBubbleLayer() {
        stretchLayer?.removeFromSuperlayer()
        
        let speechBubble = UIImage.Theme.speechBubble.image
        createStretchLayer(with: speechBubble)
        setupTextView()
    }
    
    private func createStretchLayer(with image: UIImage) {
        let contentsCenter = CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5)
        stretchLayer = CALayer()
        stretchLayer?.frame = self.bounds
        stretchLayer?.contents = image.cgImage
        stretchLayer?.contentsScale = UIScreen.main.scale
        stretchLayer?.contentsCenter = contentsCenter
        self.layer.addSublayer(stretchLayer!)
    }
    
    private func setupTextView() {
        textView.frame = CGRect(x: CGFloat.pad,
                                y: CGFloat.pad,
                                width: self.bounds.width - (2 * CGFloat.pad),
                                height: self.bounds.height - (2 * CGFloat.pad))
        
        textView.text = displayText ?? ""
        textView.sizeToFit()
        textView.center.y = self.center.y
        self.addSubview(textView)
    }
    
    func setupTailLayer(origin: CGPoint, portrait: Bool) {
        tailLayer?.removeFromSuperlayer()
        
        tailLayer = CALayer()
        let longSide = calculateLongSide()
        let isPortrait = UIApplication.isPortrait
        
        let tailX = isPortrait ? origin.x : 0
        let tailY = isPortrait ? self.bounds.height : 0
        tailLayer?.frame = CGRect(x: tailX, y: tailY, width: longSide, height: longSide / 2)
        tailLayer?.contents = UIImage.Theme.tail.image.cgImage
        tailLayer?.contentsGravity = kCAGravityResizeAspect
        
        beginTailPosition = getBeginTailPosition(from: origin, isPortrait: isPortrait)
        endTailPosition = getEndTailPosition(from: origin, isPortrait: isPortrait)
        
        if let stretchLayer = self.stretchLayer {
            self.layer.insertSublayer(tailLayer!, below: stretchLayer)
        }
    }
    
    private func calculateLongSide() -> CGFloat {
        var longSide: CGFloat = 100
        
        if Device.isSize(height: .Inches_4_7) {
            longSide = 80
        } else if Device.isSize(height: .Inches_4) {
            longSide = 70
        }
        return longSide
    }
    
    private func turnTailRightAngle(with origin: CGPoint) {
        let degrees = 90.0
        let radians = CGFloat(degrees * Double.pi / 180)
        tailLayer?.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        tailLayer?.frame.origin = CGPoint(x: (tailLayer?.frame.width)! * -1, y: origin.y)
    }
    
    private func getBeginTailPosition(from origin: CGPoint, isPortrait: Bool) -> CGPoint {
        switch isPortrait {
        case true: return CGPoint(x: origin.x + (tailLayer!.bounds.width / 2), y: self.bounds.height + (tailLayer!.bounds.height / 2))
        case false: return CGPoint(x: (tailLayer?.frame.origin.x)! / 2, y: (tailLayer?.frame.origin.y)! + ((tailLayer?.frame.height)! / 2))
        }
    }
    
    private func getEndTailPosition(from origin: CGPoint, isPortrait: Bool) -> CGPoint {
        switch isPortrait {
        case true: return CGPoint(x: origin.x + (tailLayer!.bounds.width / 2), y: self.bounds.height - (tailLayer!.bounds.height / 2))
        case false: return CGPoint(x: (tailLayer?.frame.width)! / 2, y: beginTailPosition.y)
        }
    }
}

//MARK: Animation logic
extension SpeechBubble {
    
    func animateBubbleChange() {
        
        textView.alpha = 0
        
        var time: CFTimeInterval = 0.0
        tailUpAnimation()
        
        time += tailAnimationDuration + 0.10
        Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(performStretchHeightAnimation), userInfo: nil, repeats: false)
        
        time += bubbleAnimationDuration * 2
        Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(performTailDownAnimation), userInfo: nil, repeats: false)
    }
    
    private func tailUpAnimation() {
        guard let tailLayer = tailLayer else { return }
        
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
    
    private func tailDownAnimation() {
        guard let tailLayer = tailLayer else { return }
        
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
    
    private func stretchHeightAnimation() {
        guard let stretchLayer = stretchLayer else { return }
        
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
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        let animationName: String = anim.value(forKey: "animation_name") as! String
        
        switch animationName {
        case "tail_up":
            tailLayer?.isHidden = true
        case "height_animation":
            tailLayer?.isHidden = false
        case "tail_down":
            textView.text = displayText
            textView.sizeToFit()
            textView.center.y = self.center.y
            textView.alpha = 1
        default:
            print("speech bubble animation error")
        }
    }
    

    
    
}



