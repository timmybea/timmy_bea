//
//  EducationCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class EducationCell: CustomCollectionViewCell, UICollisionBehaviorDelegate {

    var stackViews = [StackView]()
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var snap: UISnapBehavior?
    var isDragging = false
    var previousPosition: CGPoint?
    var isViewSnapped = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.customSand()
        label.text = "Drag to view"
        label.textAlignment = .center
        label.font = FontManager.AvenirNextRegular(size: FontManager.sizeSubHeader)
        return label
    }()
    
    var careers = [Career]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityView.addSubview(titleLabel)
        
        layoutBackgroundViews()
        setupDynamicAnimator()
        
        careers = Career.getCareers()
        
        let offset: CGFloat = (self.activityView.bounds.height - 30) / 3
        var currentOrigin: CGFloat = (self.activityView.bounds.height - 55)
        
        for career in careers {
            addStackViews(with: currentOrigin, career: career)
            currentOrigin -= offset
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutBackgroundViews() {
        let titleX = CGFloat((activityView.bounds.width - 130) / 2)
        titleLabel.frame = CGRect(x: titleX, y: 4, width: 130, height: 20)
    }
    
    func setupDynamicAnimator() {
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self)
        
        gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 4
        dynamicAnimator.addBehavior(gravityBehavior)
    }
    
    func addStackViews(with offset: CGFloat, career: Career)  {
        
        let stackView = StackView(frame: self.activityView.bounds)

        activityView.addSubview(stackView)
        stackView.career = career // use setter to layout stackView
        
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
        
        //left boundary
//        let leftBoundaryStart = CGPoint(x: 0, y: 0)
//        let leftBoundaryEnd = CGPoint(x: 0, y: stackView.frame.height)
//        collisionBehavior.addBoundary(withIdentifier: 2 as NSCopying, from: leftBoundaryStart, to: leftBoundaryEnd)
        
        //right boundary
//        let rightBoundaryStart = CGPoint(x: stackView.frame.width, y: 0)
//        let rightBoundaryEnd = CGPoint(x: stackView.frame.width, y: stackView.frame.height)
//        collisionBehavior.addBoundary(withIdentifier: 3 as NSCopying, from: rightBoundaryStart, to: rightBoundaryEnd)
        
        dynamicAnimator.addBehavior(collisionBehavior)
        
        gravityBehavior.addItem(stackView)
        
        stackViews.append(stackView)
    }
    
    private func updateStackViewFrame(stackView: StackView, offset: CGFloat) -> CGRect {
        return activityView.bounds.offsetBy(dx: 0, dy: activityView.bounds.height - offset)
    }
    
    
    func handlePan(panRecognizer: UIPanGestureRecognizer) {
        
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
    
    func snap(dragView: UIView) {
        
        
        let viewHasNearedSnapPosition = dragView.frame.origin.y < 60

        if viewHasNearedSnapPosition {
            if !isViewSnapped {
                var snapPosition = activityView.center
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
    
    func changeStackViewAlpha(currentView: UIView) {
        
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
        
        let offset: CGFloat = (self.activityView.bounds.height - 30) / 3
        var initialOffset: CGFloat = (self.activityView.bounds.height - 55)
        
        for career in careers {
            addStackViews(with: initialOffset, career: career)
            initialOffset -= offset
        }
    }

}
