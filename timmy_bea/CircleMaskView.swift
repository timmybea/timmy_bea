//
//  CircleMaskView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-07.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class CircleMaskView: UIView {
    
    let circlePathLayer = CAShapeLayer()
    
    let animationDuration: CFTimeInterval = 0.15
    
    var ovalPathSmall: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: self.bounds.width - 16, height: self.bounds.height - 16))
    }
    
    var ovalPathMedium: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 4, y: 4, width: self.bounds.width - 8, height: self.bounds.height - 8))
    }
    
    var ovalPathLarge: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addImageToContents()
        addCircleMask()
        addTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addImageToContents() {
        let portrait = UIImage(named: "portrait_square")
        self.layer.contents = portrait?.cgImage
        self.layer.contentsGravity = kCAGravityResizeAspect
    }
    
    private func addCircleMask() {
        circlePathLayer.frame = bounds
        circlePathLayer.fillColor = UIColor.black.cgColor
        circlePathLayer.path = ovalPathMedium.cgPath
        layer.mask = circlePathLayer
    }
    
    private func createAnimations() {
        
        let wobbleAnimation1 = CABasicAnimation(keyPath: "path")
        wobbleAnimation1.fromValue = ovalPathMedium.cgPath
        wobbleAnimation1.toValue = ovalPathSmall.cgPath
        wobbleAnimation1.beginTime = 0.0
        wobbleAnimation1.duration = animationDuration
        
        let wobbleAnimation2 = CABasicAnimation(keyPath: "path")
        wobbleAnimation2.fromValue = ovalPathSmall.cgPath
        wobbleAnimation2.toValue = ovalPathLarge.cgPath
        wobbleAnimation2.beginTime = wobbleAnimation1.beginTime + wobbleAnimation1.duration
        wobbleAnimation2.duration = animationDuration
        
        let wobbleAnimation3 = CABasicAnimation(keyPath: "path")
        wobbleAnimation3.fromValue = ovalPathLarge.cgPath
        wobbleAnimation3.toValue = ovalPathMedium.cgPath
        wobbleAnimation3.beginTime = wobbleAnimation2.beginTime + wobbleAnimation2.duration
        
        let wobbleAnimationGroup = CAAnimationGroup()
        wobbleAnimationGroup.animations = [wobbleAnimation1, wobbleAnimation2, wobbleAnimation3]
        wobbleAnimationGroup.duration = wobbleAnimation3.beginTime + wobbleAnimation3.duration
        wobbleAnimationGroup.repeatCount = 1
        wobbleAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circlePathLayer.add(wobbleAnimationGroup, forKey: nil)
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.performAnimations(recognizer:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func performAnimations(recognizer: UITapGestureRecognizer) {
        createAnimations()
    }
}
