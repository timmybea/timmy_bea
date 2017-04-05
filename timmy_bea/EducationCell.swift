//
//  EducationCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class EducationCell: CustomCollectionViewCell {

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
        label.font = FontManager.AvenirNextRegular(size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityView.addSubview(titleLabel)
        
        layoutBackgroundViews()
        setupDynamicAnimator()
        
        let offset: CGFloat = (self.activityView.bounds.height - 30) / 3
        var currentOrigin: CGFloat = (activityView.bounds.height - 55)
    
        let careers = Career.getCareers()
        
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
    
    override func redrawCell() {
        super.redrawCell()
        layoutBackgroundViews()
    }
    
    func addStackViews(with offset: CGFloat, career: Career)  {
        
        
        let stackView = StackView(frame: self.activityView.bounds)

        activityView.addSubview(stackView)
        stackView.career = career // use setter to layout stackView
        stackView.frame = activityView.bounds.offsetBy(dx: 0, dy: activityView.bounds.height - offset)
        
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
    
    func setupDynamicAnimator() {
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self) //??
        
        gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 4
        dynamicAnimator.addBehavior(gravityBehavior)
    }

    func handlePan(panRecognizer: UIPanGestureRecognizer) {
        
        let currentPosition = panRecognizer.location(in: self) //??
        
        if let dragView = panRecognizer.view {
            if panRecognizer.state == .began {
                let isTouchNearTop = panRecognizer.location(in: dragView).y < 80
                
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
        
        let viewHasNearedSnapPosition = dragView.frame.origin.y < 80 //??
        
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
//                        stackView.textView.alpha = 0
//                        stackView.button.alpha = 0
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
//                        stackView.textView.alpha = 1
//                        stackView.button.alpha = 1
                    })
                }
                
            }
        }
    }
    
}
