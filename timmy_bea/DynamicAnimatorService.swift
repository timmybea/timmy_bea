//
//  DynamicAnimatorService.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-21.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

struct DynamicAnimatorService {
    
    private var dynamicAnimator: UIDynamicAnimator!
    private var gravityBehavior: UIGravityBehavior!
    private var snap: UISnapBehavior?
    private var referenceView: UIView

    init(in referenceView: UIView) {
        self.referenceView = referenceView
        resetDynamicAnimator()
    }
    
    mutating func resetDynamicAnimator() {
        dynamicAnimator = UIDynamicAnimator(referenceView: referenceView)
        gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 4
        dynamicAnimator.addBehavior(gravityBehavior)
    }
    
    func addBehaviors(to stackView: StackView) {
        
        addCollisionBehavior(to: stackView)
        gravityBehavior.addItem(stackView)
    }
    
    private func addCollisionBehavior(to stackView: StackView) {

        let collisionBehavior = UICollisionBehavior(items: [stackView])
        
        let boundaryY = stackView.frame.origin.y + stackView.frame.height
        let boundaryStart = CGPoint(x: 0, y: boundaryY)
        let boundaryEnd = CGPoint(x: stackView.frame.width, y: boundaryY)
        collisionBehavior.addBoundary(withIdentifier: 1 as NSCopying, from: boundaryStart, to: boundaryEnd)
        
        dynamicAnimator.addBehavior(collisionBehavior)
    }

    func updateItem(using currentState: UIDynamicItem) {
        dynamicAnimator.updateItem(usingCurrentState: currentState)
    }
    
    mutating func addSnapBehavior(to item: UIDynamicItem, position: CGPoint) {
        snap = UISnapBehavior(item: item, snapTo: position)
        dynamicAnimator.addBehavior(snap!)
    }
    
    func removeSnapBehavior() {
        if let snap = snap {
            dynamicAnimator.removeBehavior(snap)
        }
    }
}
