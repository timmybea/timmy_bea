//
//  EducationCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class EducationCell: CustomCollectionViewCell {
    
//    var dynamicAnimatorService: DynamicAnimatorService!
    var stackViewController: StackViewController!
    
//    private var stackViews = [StackView]()
//    private var stackViewColors: [UIColor.Theme] = [.customGreen, .customRust, .customDarkBlue]
//
//    private var isDragging = false
//    private var previousPosition: CGPoint?
//    private var isViewSnapped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        createTitleLabel()
        stackViewController = StackViewController(referenceView: self)
        
//        self.dynamicAnimatorService = DynamicAnimatorService(in: self)
        
//        createStackViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTitleLabel() {
        let titleLabel = UILabel.createLabelWith(text: "Drag to view", color: UIColor.Theme.customSand.color)
        let titleX = CGFloat((blueView.bounds.width - 130) / 2)
        titleLabel.frame = CGRect(x: titleX, y: 4, width: 130, height: 20)
        blueView.addSubview(titleLabel)
    }
    
//    private func addStackViews(with offset: CGFloat, career: Career, color: UIColor.Theme)  {
//
//        let stackView = StackView(frame: self.blueView.bounds)
//
//        stackView.backgroundColor = color.color
//
//        blueView.addSubview(stackView)
//        stackView.career = career
//
//        stackView.frame = updateStackViewFrame(stackView: stackView, offset: offset)
//
//        //pan Gesture
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(panRecognizer:)))
//        stackView.addGestureRecognizer(panGesture)
//
//        dynamicAnimatorService.addBehaviors(to: stackView)
//
//        stackViews.append(stackView)
//    }
    
//    private func updateStackViewFrame(stackView: StackView, offset: CGFloat) -> CGRect {
//        return blueView.bounds.offsetBy(dx: 0, dy: blueView.bounds.height - offset)
//    }
    
    
//    @objc private func handlePan(panRecognizer: UIPanGestureRecognizer) {
//
//        let currentPosition = panRecognizer.location(in: self)
//
//        if let dragView = panRecognizer.view {
//            if panRecognizer.state == .began {
//                let isTouchNearTop = panRecognizer.location(in: dragView).y < 60
//
//                if isTouchNearTop {
//                    isDragging = true
//                    previousPosition = currentPosition
//                }
//            } else if panRecognizer.state == .changed && isDragging {
//                if let previousPosition = previousPosition {
//                    let offset = previousPosition.y - currentPosition.y
//                    dragView.center = CGPoint(x: dragView.center.x, y: dragView.center.y - offset)
//                }
//                previousPosition = currentPosition
//            } else if panRecognizer.state == .ended && isDragging {
//
//                dynamicAnimatorService.snap(dragView: dragView)
//
//                dynamicAnimatorService.updateItem(using: dragView)
//                isDragging = false
//            }
//        }
//    }
    
//    private func snap(dragView: UIView) {
//
//        let viewHasNearedSnapPosition = dragView.frame.origin.y < 60
//
//        if viewHasNearedSnapPosition {
//            if !isViewSnapped {
//                var snapPosition = blueView.center
//                snapPosition.y += 30
//
//                dynamicAnimatorService.addSnapBehavior(to: dragView, position: snapPosition)
//
//                changeStackViewAlpha(currentView: dragView)
//
//                isViewSnapped = true
//            }
//        } else {
//            if isViewSnapped {
//                dynamicAnimatorService.removeSnapBehavior()
//                changeStackViewAlpha(currentView: dragView)
//                isViewSnapped = false
//            }
//        }
//    }
    
//    private func changeStackViewAlpha(currentView: UIView) {
//
//        if isViewSnapped {
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
    
    private func removeAllSubviews() {
        for subview in blueView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    override func redrawCell() {
        super.redrawCell()
        
        removeAllSubviews()
        
        createTitleLabel()

        stackViewController.removeStackViews()
//        for stackView in stackViews {
//            stackView.removeFromSuperview()
//        }
        
//        isViewSnapped = false
        stackViewController.dynamicAnimatorService.resetDynamicAnimator()
//        dynamicAnimatorService.resetDynamicAnimator()
        
        stackViewController.createStackViews()
//        createStackViews()
        
    }
    
//    private func createStackViews() {
//        let offset: CGFloat = (self.blueView.bounds.height - 30) / 3
//        var initialOffset: CGFloat = (self.blueView.bounds.height - 55)
//
//        for (index, career) in Career.careerData.enumerated() {
//            addStackViews(with: initialOffset, career: career, color: stackViewColors[index])
//            initialOffset -= offset
//        }
//    }
}
