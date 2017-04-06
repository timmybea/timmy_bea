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
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.customSand()
        label.font = FontManager.AvenirNextMedium(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let mainTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
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
            self.addSubview(mainTextView)
        }
        layoutFrames()
    }
    
    func layoutFrames() {
        if let career = self.career {
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
                
                let yImage = (3 * pad) + Int(logoImageView.frame.height) + 4
                let yText = currentY + Int(subtitleLabel.frame.height) + 4
                
                if yImage > yText {
                    currentY = yImage
                } else {
                    currentY = yText
                }
                
                mainTextView.frame = CGRect(x: pad, y: currentY, width: Int(self.bounds.width) - (2 * pad), height: Int(self.bounds.height) - currentY - 40)
                mainTextView.isScrollEnabled = false
                
            } else {
                
                currentY = pad
                
                let logoWidth = (Int(self.bounds.width) - (2 * pad)) / 5
                logoImageView.frame = CGRect(x: (pad * 3), y: currentY, width: logoWidth, height: logoWidth / 2)
                
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
                
                let yImage = (3 * pad) + Int(logoImageView.frame.height) + 4
                let yText = currentY + Int(subtitleLabel.frame.height) + 4
                
                if yImage > yText {
                    currentY = yImage
                } else {
                    currentY = yText
                }
                
                mainTextView.frame = CGRect(x: pad, y: currentY, width: Int(self.bounds.width) - (2 * pad), height: Int(self.bounds.height) - currentY - 40)
                mainTextView.isScrollEnabled = true
            }
            mainTextView.attributedText = createAttributedString()
            mainTextView.alpha = 0
        }
    }
    
    
    
    private func createAttributedString() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString()
        
        if let career = self.career {

            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.justified
            
            attributedString.append(NSAttributedString(string: career.description, attributes: [NSFontAttributeName: FontManager.AvenirNextRegular(size: 14), NSForegroundColorAttributeName: ColorManager.customSand(), NSParagraphStyleAttributeName: style]))
            
            attributedString.append(NSAttributedString(string: "\n\nEducation", attributes: [NSFontAttributeName: FontManager.AvenirNextMedium(size: 16), NSForegroundColorAttributeName: ColorManager.customSand()]))
            
            for qualification in career.education {
                attributedString.append(NSAttributedString(string: "\n\(qualification.institution!) - \(qualification.role!) \(qualification.date!)", attributes: [NSFontAttributeName: FontManager.AvenirNextRegular(size: 12), NSForegroundColorAttributeName: ColorManager.customSand()]))
            }
            
            if career.relatedRoles.count > 0 {
                
                attributedString.append(NSAttributedString(string: "\n\nRelated Work", attributes: [NSFontAttributeName: FontManager.AvenirNextMedium(size: 16), NSForegroundColorAttributeName: ColorManager.customSand()]))
                
                for role in career.relatedRoles {
                    attributedString.append(NSAttributedString(string: "\n\(role.institution!) - \(role.role!) \(role.date!)", attributes: [NSFontAttributeName: FontManager.AvenirNextRegular(size: 12), NSForegroundColorAttributeName: ColorManager.customSand()]))
                }
            }
            
            attributedString.append(NSAttributedString(string: "\n\nReferences available by request", attributes: [NSFontAttributeName: FontManager.AvenirNextItalic(size: 14), NSForegroundColorAttributeName: ColorManager.customSand()]))
        }
        return attributedString
    }

}
