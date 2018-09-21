//
//  EducationCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Properties and init
class EducationCell: CustomCollectionViewCell {
    
    var stackViewController: StackViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createTitleLabel()
        stackViewController = StackViewController(referenceView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func redrawCell() {
        super.redrawCell()
        
        removeAllSubviews()
        createTitleLabel()
        stackViewController.removeStackViews()
        stackViewController.dynamicAnimatorService.resetDynamicAnimator()
        stackViewController.createStackViews()
    }
}

//MARK: Private methods
extension EducationCell {
    
    private func createTitleLabel() {
        let titleLabel = UILabel.createLabelWith(text: "Drag to view", color: UIColor.Theme.customSand.color)
        let titleX = CGFloat((blueView.bounds.width - 130) / 2)
        titleLabel.frame = CGRect(x: titleX, y: 4, width: 130, height: 20)
        blueView.addSubview(titleLabel)
    }
    
    private func removeAllSubviews() {
        for subview in blueView.subviews {
            subview.removeFromSuperview()
        }
    }
}
