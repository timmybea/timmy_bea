//
//  StackView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-01.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class StackView: UIView, UIScrollViewDelegate {
    
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
        return label
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.clear
        return sv
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.customSand()
        label.font = FontManager.AvenirNextMedium(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let summaryTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.font = FontManager.AvenirNextRegular(size: 14)
        textView.textColor = ColorManager.customSand()
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let educationLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.customSand()
        label.font = FontManager.AvenirNextMedium(size: 16)
        label.textAlignment = .left
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
            self.addSubview(scrollView)
            scrollView.addSubview(summaryTextView)
            scrollView.addSubview(educationLabel)
            
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
                subtitleLabel.frame = CGRect(x: currentX, y: currentY, width: Int(titleLabel.frame.width), height: 16)
                subtitleLabel.center.x = titleLabel.center.x
                subtitleLabel.text = career.subtitle
                
                let yImage = (4 * pad) + Int(logoImageView.frame.height)
                let yText = currentY + Int(subtitleLabel.frame.height) + pad
                
                if yImage > yText {
                    currentY = yImage
                } else {
                    currentY = yText
                }

                scrollView.frame = CGRect(x: 0, y: currentY, width: Int(self.bounds.width), height: Int(self.bounds.height) - currentY - 40)
                scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height * 2)
                
                summaryTextView.frame = CGRect(x: pad, y: 0, width: Int(scrollView.bounds.width) - (2 * pad), height: 20)
                summaryTextView.text = career.description
                summaryTextView.sizeToFit()
                
                currentY = Int(summaryTextView.frame.height) + pad
                educationLabel.frame = CGRect(x: pad, y: currentY, width: Int(scrollView.bounds.width), height: 16)
                educationLabel.text = "Education"
                
                
                
            }
            
            
            
            
            
            
        }
        
    }
    

}
