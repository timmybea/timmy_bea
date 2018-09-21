//
//  StackViewController.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-21.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

//class StackViewController : NSObject, UICollisionBehaviorDelegate {
    class StackViewController {
    
    private var stackViews = [StackView]()

    static private var stackViewColors: [UIColor.Theme] = [.customGreen, .customRust, .customDarkBlue]

    private var isDragging = false
    
    private var previousPosition: CGPoint?
    
    var dynamicAnimatorService: DynamicAnimatorService!
    
    private var referenceView: CustomCollectionViewCell!

    
    init(referenceView: CustomCollectionViewCell) {
        self.referenceView = referenceView
        self.dynamicAnimatorService = DynamicAnimatorService(in: referenceView)
        self.dynamicAnimatorService.delegate = self
        createStackViews()
    }
    
    func createStackViews() {
        let offset: CGFloat = (referenceView.blueView.bounds.height - 30) / 3
        var initialOffset: CGFloat = (referenceView.blueView.bounds.height - 55)
        
        for (index, career) in Career.careerData.enumerated() {
            addStackViews(with: initialOffset, career: career, color: type(of: self).stackViewColors[index])
            initialOffset -= offset
        }
    }
    
    private func addStackViews(with offset: CGFloat, career: Career, color: UIColor.Theme)  {
        
        let stackView = StackView(frame: referenceView.blueView.bounds)
        
        stackView.backgroundColor = color.color
        
        referenceView.blueView.addSubview(stackView)
        
        stackView.career = career
        stackView.frame = updateStackViewFrame(stackView: stackView, offset: offset)
        
        //pan Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(panRecognizer:)))
        stackView.addGestureRecognizer(panGesture)
        
        dynamicAnimatorService.addBehaviors(to: stackView)
        
        stackViews.append(stackView)
    }
    
    private func updateStackViewFrame(stackView: StackView, offset: CGFloat) -> CGRect {
        return referenceView.blueView.bounds.offsetBy(dx: 0, dy: referenceView.blueView.bounds.height - offset)
    }
    
    func removeStackViews() {
        for stackView in stackViews {
            stackView.removeFromSuperview()
        }
        stackViews.removeAll()
    }
    
        @objc private func handlePan(panRecognizer: UIPanGestureRecognizer) {
    
            let currentPosition = panRecognizer.location(in: referenceView)
    
            if let dragView = panRecognizer.view {
                if panRecognizer.state == .began {
                    let isTouchNearTop = panRecognizer.location(in: dragView).y < 60
    
                    if isTouchNearTop {
                        isDragging = true
                        previousPosition = currentPosition
                    }
                } else if panRecognizer.state == .changed && isDragging {
                    if let previousPosition = previousPosition {
                        let offset = previousPosition.y - currentPosition.y
                        dragView.center = CGPoint(x: dragView.center.x, y: dragView.center.y - offset)
                    }
                    previousPosition = currentPosition
                } else if panRecognizer.state == .ended && isDragging {
    
                    dynamicAnimatorService.snap(dragView: dragView)
    
                    dynamicAnimatorService.updateItem(using: dragView)
                    isDragging = false
                }
            }
        }
    
//
//    private func changeStackViewAlpha(currentView: UIView) {
//
//        if isViewSnapped {
//
//
//            for stackView in stackViews {
//                if stackView == currentView {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        stackView.mainTextView.alpha = 0
//                    })
//                }
//                stackView.alpha = 1
//            }
//        } else {
//            for stackView in stackViews {
//                if stackView != currentView {
//                    stackView.alpha = 0
//                } else {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        stackView.mainTextView.alpha = 1
//                    })
//                }
//            }
//        }
//    }

    
}

extension StackViewController : DynamicAnimatorServiceDelegate {
    
    func currentView(_ view: UIView, isSnapped: Bool) {
        if isSnapped {
            for stackView in stackViews {
                if stackView == view {
                    UIView.animate(withDuration: 0.5, animations: {
                        stackView.mainTextView.alpha = 0
                    })
                }
                stackView.alpha = 1
            }
        } else {
            for stackView in stackViews {
                if stackView != view {
                    stackView.alpha = 0
                } else {
                    UIView.animate(withDuration: 0.5, animations: {
                        stackView.mainTextView.alpha = 1
                    })
                }
            }
        }
    }
    
}

