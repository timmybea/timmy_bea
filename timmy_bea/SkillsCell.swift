//
//  SkillsCollectionViewCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class SkillsCell: UICollectionViewCell {
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.customDarkBlue()
        view.alpha = 0.41
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red
        
        setupBackgroundView()
        
        
    }

    func setupBackgroundView() {
        
        addSubview(blueView)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: blueView)
        addConstraintsWithFormat(format: "V:|-24-[v0]-24-|", views: blueView)
    }

    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
