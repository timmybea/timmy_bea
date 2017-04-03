//
//  StackView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-01.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class StackView: UIView {

    var recipe: Recipe? {
        didSet {
            setupLayer()
        }
    }
    
    var gradientColors = [UIColor]()

    override init(frame: CGRect) {
        super.init(frame: frame)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayer() {
        layer.cornerRadius = 8
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3

        
        self.backgroundColor = UIColor.blue
//        if let recipe = self.recipe {
//            self.gradientColors = [UIColor.white, UIColor.gray]
//                
//                //recipe.gradientColors
//
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.frame = self.bounds
//            gradientLayer.colors = self.gradientColors
//            gradientLayer.locations = [0.0, 1.0]
//            self.layer.insertSublayer(gradientLayer, at: 0)
//            //self.layer.addSublayer(gradientLayer, at)
//        }
    }
    
    
    
    
    
    
}
