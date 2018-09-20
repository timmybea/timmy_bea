//
//  EducationCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class EducationCell: CustomCollectionViewCell, UICollisionBehaviorDelegate {
    
    private var stackViews = [StackView]()
    private var stackViewColors: [UIColor.Theme] = [.customGreen, .customRust, .customBlue]
    
    private var dynamicAnimator: UIDynamicAnimator!
    private var gravityBehavior: UIGravityBehavior!
    private var snap: UISnapBehavior?
    private var isDragging = false
    private var previousPosition: CGPoint?
    private var isViewSnapped = false
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Theme.customSand.color
        label.text = "Drag to view"
        label.textAlignment = .center
        label.font = UIFont.Theme.subHeader.font
        return label
    }()
    
    private var careers = [Career]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        blueView.addSubview(titleLabel)
        
        layoutBackgroundViews()
        setupDynamicAnimator()
        
        careers = Career.careerData
        
        
        let offset: CGFloat = (self.blueView.bounds.height - 30) / 3
        var currentOrigin: CGFloat = (self.blueView.bounds.height - 55)
        
        for (index, career) in careers.enumerated() {
            addStackViews(with: currentOrigin, career: career, color: stackViewColors[index])
            currentOrigin -= offset
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutBackgroundViews() {
        let titleX = CGFloat((blueView.bounds.width - 130) / 2)
        titleLabel.frame = CGRect(x: titleX, y: 4, width: 130, height: 20)
    }
    
    private func setupDynamicAnimator() {
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self)
        
        gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 4
        dynamicAnimator.addBehavior(gravityBehavior)
    }
    
    private func addStackViews(with offset: CGFloat, career: Career, color: UIColor.Theme)  {
        
        let stackView = StackView(frame: self.blueView.bounds)
        stackView.backgroundColor = color.color

        blueView.addSubview(stackView)
        stackView.career = career
        
        stackView.frame = updateStackViewFrame(stackView: stackView, offset: offset)
        
        //pan Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(panRecognizer:)))
        stackView.addGestureRecognizer(panGesture)
        
        //collision behavior
        let collisionBehavior = UICollisionBehavior(items: [stackView])
        
        //lower boundary
        let boundaryY = stackView.frame.origin.y + stackView.frame.height
        let boundaryStart = CGPoint(x: 0, y: boundaryY)
        let boundaryEnd = CGPoint(x: stackView.frame.width, y: boundaryY)
        collisionBehavior.addBoundary(withIdentifier: 1 as NSCopying, from: boundaryStart, to: boundaryEnd)
        
        dynamicAnimator.addBehavior(collisionBehavior)
        
        gravityBehavior.addItem(stackView)
        
        stackViews.append(stackView)
    }
    
    private func updateStackViewFrame(stackView: StackView, offset: CGFloat) -> CGRect {
        return blueView.bounds.offsetBy(dx: 0, dy: blueView.bounds.height - offset)
    }
    
    
    @objc private func handlePan(panRecognizer: UIPanGestureRecognizer) {
        
        let currentPosition = panRecognizer.location(in: self)
        
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
                
                snap(dragView: dragView)
                
                dynamicAnimator.updateItem(usingCurrentState: dragView)
                
                isDragging = false
            }
        }
    }
    
    private func snap(dragView: UIView) {
        
        let viewHasNearedSnapPosition = dragView.frame.origin.y < 60

        if viewHasNearedSnapPosition {
            if !isViewSnapped {
                var snapPosition = blueView.center
                snapPosition.y += 30
                
                snap = UISnapBehavior(item: dragView, snapTo: snapPosition)
                dynamicAnimator.addBehavior(snap!)
                
                changeStackViewAlpha(currentView: dragView)
                
                isViewSnapped = true
            }
        } else {
            if isViewSnapped {
                dynamicAnimator.removeBehavior(snap!)
                changeStackViewAlpha(currentView: dragView)
                isViewSnapped = false
            }
        }
    }
    
    private func changeStackViewAlpha(currentView: UIView) {
        
        if isViewSnapped {
            for stackView in stackViews {
                if stackView == currentView {
                    UIView.animate(withDuration: 0.5, animations: {
                        stackView.mainTextView.alpha = 0
                    })
                }
                stackView.alpha = 1
            }
        } else {
            for stackView in stackViews {
                if stackView != currentView {
                    stackView.alpha = 0
                } else {
                    UIView.animate(withDuration: 0.5, animations: {
                        stackView.mainTextView.alpha = 1
                    })
                }
            }
        }
    }
    
    override func redrawCell() {
        super.redrawCell()
        layoutBackgroundViews()

        for stackView in stackViews {
            stackView.removeFromSuperview()
        }
        
        isViewSnapped = false
        setupDynamicAnimator()
        
        let offset: CGFloat = (self.blueView.bounds.height - 30) / 3
        var initialOffset: CGFloat = (self.blueView.bounds.height - 55)
        
        for (index, career) in careers.enumerated() {
            addStackViews(with: initialOffset, career: career, color: stackViewColors[index])
            initialOffset -= offset
        }
    }
}
