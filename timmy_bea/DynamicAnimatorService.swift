//
//  DynamicAnimatorService.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-21.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Delegate
protocol DynamicAnimatorServiceDelegate {
    func currentView(_ view: UIView, isSnapped: Bool)
}

//MARK: Properties and init
class DynamicAnimatorService : NSObject, UICollisionBehaviorDelegate {
    
    var delegate: DynamicAnimatorServiceDelegate?
    
    private var dynamicAnimator: UIDynamicAnimator!
    private var gravityBehavior: UIGravityBehavior!
    private var snap: UISnapBehavior?
    private var referenceView: CustomCollectionViewCell!
    private var isViewSnapped = false

    init(in referenceView: CustomCollectionViewCell) {
        super.init()
        
        self.referenceView = referenceView
        resetDynamicAnimator()
    }
}

//MARK: Public methods
extension DynamicAnimatorService {
    
    func resetDynamicAnimator() {
        isViewSnapped = false
        
        dynamicAnimator = UIDynamicAnimator(referenceView: referenceView)
        gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 4
        dynamicAnimator.addBehavior(gravityBehavior)
    }
    
    func addBehaviors(to stackView: StackView) {
        addCollisionBehavior(to: stackView)
        gravityBehavior.addItem(stackView)
    }
    
    func updateItem(using currentState: UIDynamicItem) {
        dynamicAnimator.updateItem(usingCurrentState: currentState)
    }
    
    func addSnapBehavior(to item: UIDynamicItem, position: CGPoint) {
        snap = UISnapBehavior(item: item, snapTo: position)
        dynamicAnimator.addBehavior(snap!)
    }
    
    func removeSnapBehavior() {
        if let snap = snap {
            dynamicAnimator.removeBehavior(snap)
        }
    }
    
    func snap(dragView: UIView) {
        let viewHasNearedSnapPosition = dragView.frame.origin.y < 60
        
        if viewHasNearedSnapPosition {
            if !isViewSnapped {
                
                var snapPosition = referenceView.blueView.center
                snapPosition.y += 30
                
                addSnapBehavior(to: dragView, position: snapPosition)
                changeStackViewAlpha(currentView: dragView)
                isViewSnapped = true
            }
        } else {
            if isViewSnapped {
                removeSnapBehavior()
                changeStackViewAlpha(currentView: dragView)
                isViewSnapped = false
            }
        }
    }
}

//MARK: Private methods
extension DynamicAnimatorService {
    
    private func addCollisionBehavior(to stackView: StackView) {
        let collisionBehavior = UICollisionBehavior(items: [stackView])
        let boundaryY = stackView.frame.origin.y + stackView.frame.height
        let boundaryStart = CGPoint(x: 0, y: boundaryY)
        let boundaryEnd = CGPoint(x: stackView.frame.width, y: boundaryY)
        collisionBehavior.addBoundary(withIdentifier: 1 as NSCopying, from: boundaryStart, to: boundaryEnd)
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    
    private func changeStackViewAlpha(currentView: UIView) {
        self.delegate?.currentView(currentView, isSnapped: isViewSnapped)
    }
    
}
