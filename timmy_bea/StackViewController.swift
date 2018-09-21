//
//  StackViewController.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-21.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Properties and init
class StackViewController {

    static private var stackViewColors: [UIColor.Theme] = [.customGreen, .customRust, .customDarkBlue]

    var dynamicAnimatorService: DynamicAnimatorService!
    
    private var stackViews = [StackView]()
    private var isDragging = false
    private var previousPosition: CGPoint?
    private var referenceView: CustomCollectionViewCell!

    
    init(referenceView: CustomCollectionViewCell) {
        self.referenceView = referenceView
        self.dynamicAnimatorService = DynamicAnimatorService(in: referenceView)
        self.dynamicAnimatorService.delegate = self
        createStackViews()
    }
    
    @objc private func handlePan(panRecognizer: UIPanGestureRecognizer) {
        
        let currentPosition = panRecognizer.location(in: referenceView)
        guard let dragView = panRecognizer.view else { return }
        
        switch panRecognizer.state {
        case .began:
            let isTouchNearTop = panRecognizer.location(in: dragView).y < 60
            
            if isTouchNearTop {
                isDragging = true
                previousPosition = currentPosition
            }
        case .changed:
            if isDragging {
                if let previousPosition = previousPosition {
                    let offset = previousPosition.y - currentPosition.y
                    dragView.center = CGPoint(x: dragView.center.x, y: dragView.center.y - offset)
                }
                previousPosition = currentPosition

            }
        case .ended:
            if isDragging {
                dynamicAnimatorService.snap(dragView: dragView)
                dynamicAnimatorService.updateItem(using: dragView)
                isDragging = false
            }
        default:
            return
        }
    }
        
}

//MARK: Methods
extension StackViewController {
    
    func createStackViews() {
        
        let offset: CGFloat = (referenceView.blueView.bounds.height - 30) / 3
        var initialOffset: CGFloat = (referenceView.blueView.bounds.height - 55)
        
        for (index, career) in Career.careerData.enumerated() {
            addStackViews(with: initialOffset, career: career, color: type(of: self).stackViewColors[index])
            initialOffset -= offset
        }
    }
    
    private func addStackViews(with offset: CGFloat, career: Career, color: UIColor.Theme)  {
        
        let stackView = createStackView(with: career, color: color)
        referenceView.blueView.addSubview(stackView)
        stackView.frame = updateStackViewFrame(stackView: stackView, offset: offset)
        addPanGesture(to: stackView)
        dynamicAnimatorService.addBehaviors(to: stackView)
        stackViews.append(stackView)
        
    }
    
    private func createStackView(with career: Career, color: UIColor.Theme) -> StackView {
        let stackView = StackView(frame: referenceView.blueView.bounds)
        stackView.backgroundColor = color.color
        stackView.career = career
        return stackView
    }
    
    private func addPanGesture(to stackView: StackView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(panRecognizer:)))
        stackView.addGestureRecognizer(panGesture)
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
}


//MARK: DynamicAnimatorServiceDelegate
extension StackViewController : DynamicAnimatorServiceDelegate {

    func currentView(_ view: UIView, isSnapped: Bool) {
        for stackView in stackViews {
            stackView.alpha = isSnapped ? 1 : stackView != view ? 0 : 1
            if stackView == view {
                animateMainText(of: stackView, visible: !isSnapped)
            }
        }
    }
    
    private func animateMainText(of stackView: StackView, visible: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            stackView.mainTextView.alpha = visible ? 1 : 0
        })
    }
    
}

