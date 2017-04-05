//
//  StackView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-01.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class StackView: UIView {
    
    var career:  Career? {
        didSet {
            setupSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setupLayer() {
//        layer.cornerRadius = 8
//        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 2, height: 2)
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 3
//        self.backgroundColor = UIColor.blue
//        if let recipe = self.recipe {
//            self.gradientColors = recipe.gradientColors
//
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.frame = self.bounds
//            gradientLayer.colors = self.gradientColors
//            gradientLayer.locations = [0.3, 0.75]
//            self.layer.insertSublayer(gradientLayer, at: 0)
//            //self.layer.addSublayer(gradientLayer, at)
//        }
//    }
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorManager.customSand()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.AvenirNextDBold(size: 20)
        label.textColor = ColorManager.customSand()
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        //label.backgroundColor = UIColor.blue
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.customSand()
        label.font = FontManager.AvenirNextMedium(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private func setupSubviews() {
        
        layer.cornerRadius = 8
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
        
        if let career = self.career {
            
            self.backgroundColor = career.backgroundColor
            
            self.addSubview(logoImageView)
            self.addSubview(titleLabel)
            self.addSubview(subtitleLabel)
            
            logoImageView.image = UIImage(named: career.imageName)?.withRenderingMode(.alwaysTemplate)
            
            var currentX = pad
            var currentY = 16
            
            if UIApplication.shared.statusBarOrientation.isPortrait {
                let logoWidth = (Int(self.bounds.width) - (2 * pad)) / 3
                logoImageView.frame = CGRect(x: currentX, y: currentY + pad, width: logoWidth, height: logoWidth / 2)
                
                currentX += Int(logoImageView.frame.width) + pad
                let titleWidth = Int(self.bounds.width) - currentX - pad
                titleLabel.frame = CGRect(x: currentX, y: currentY, width: titleWidth, height: 20)
                titleLabel.text = career.title
                titleLabel.sizeToFit()
                let centerX = currentX + ((Int(self.bounds.width) - currentX - pad) / 2)
                titleLabel.center.x = CGFloat(centerX)
                
                currentY += Int(titleLabel.frame.height) + 4
                subtitleLabel.frame = CGRect(x: currentX, y: currentY, width: Int(titleLabel.frame.width), height: 20)
                subtitleLabel.center.x = titleLabel.center.x
                subtitleLabel.text = career.subtitle
            }
            
            
            
            
            
            
        }
        
    }
    

}
