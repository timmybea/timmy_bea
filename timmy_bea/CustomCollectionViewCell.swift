//
//  CustomCollectionViewCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-12.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    //MARK: UI Properties
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Theme.customDarkBlue.color.withAlphaComponent(0.8)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    //MARK: Non-UI Properties
    let verticalPad: CGFloat = 24.0
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(blueView)
        sizeForOrientation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Overrideable methods
    func redrawCell() {
        sizeForOrientation()
    }
}

//MARK: Subview Layout methods
extension CustomCollectionViewCell {
    
    private func sizeForOrientation() {
        let height = UIApplication.shared.statusBarOrientation.isPortrait ? self.bounds.height - (2 * verticalPad) - 12 : self.bounds.height - (2 * verticalPad)
        blueView.frame = CGRect(x: verticalPad, y: verticalPad, width: self.bounds.width - (2 * verticalPad), height: height)
    }
    
}
