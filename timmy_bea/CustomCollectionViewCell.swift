//
//  CustomCollectionViewCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-12.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Properties, initializers
class CustomCollectionViewCell: UICollectionViewCell {

    let blueView: UIView = UIView.blueView()
    
//    let blueView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.Theme.customDarkBlue.color.withAlphaComponent(0.8)
//        view.layer.cornerRadius = 8
//        view.layer.masksToBounds = true
//        return view
//    }()

    let verticalPad: CGFloat = 24.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(blueView)
        sizeForOrientation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redrawCell() {
        sizeForOrientation()
    }
}

//MARK: Private interface
extension CustomCollectionViewCell {
    
    private func sizeForOrientation() {
        let height = UIApplication.shared.statusBarOrientation.isPortrait ? self.bounds.height - (2 * verticalPad) - 12 : self.bounds.height - (2 * verticalPad)
        blueView.frame = CGRect(x: verticalPad, y: verticalPad, width: self.bounds.width - (2 * verticalPad), height: height)
    }
    
}
