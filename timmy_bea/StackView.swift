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

    private let logoImageView: CachedImageView = {
        let view = CachedImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.clear
        view.tintColor = UIColor.Theme.customSand.color
        return view
    }()

    
//    private let logoImageView: UIImageView = {
//        let imageView = UIImageView.createWith(imageName: nil, contentMode: .scaleAspectFit)
//        imageView.tintColor = UIColor.Theme.customSand.color
//        return imageView
//    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Theme.header.font
        label.textColor = UIColor.Theme.customSand.color
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Theme.customSand.color
        label.font = UIFont.Theme.subHeader.font
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
        
        if self.career != nil {
            self.addSubview(logoImageView)
            self.addSubview(titleLabel)
            self.addSubview(subtitleLabel)
            self.addSubview(mainTextView)
        }
        layoutFrames()
    }
    
    private func layoutFrames() {
        if let career = self.career {
            
            logoImageView.loadImage(from: career.imageName, with: .alwaysTemplate)
            
//            logoImageView.imageEndPoint = career.imageName
//            logoImageView.image = UIImage(named: career.imageName)?.withRenderingMode(.alwaysTemplate)
            
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
            
            attributedString.append(NSAttributedString(string: career.description, attributes: [NSAttributedStringKey.font: UIFont.Theme.bodyText.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color, NSAttributedStringKey.paragraphStyle: style]))
            
            attributedString.append(NSAttributedString(string: "\n\nEducation", attributes: [NSAttributedStringKey.font: UIFont.Theme.subHeader.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
            
            for qualification in career.education {
                attributedString.append(NSAttributedString(string: "\n\(qualification.institution) - \(qualification.role) \(qualification.date)", attributes: [NSAttributedStringKey.font: UIFont.Theme.footNote.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
            }
            
            if career.relatedRoles.count > 0 {
                
                attributedString.append(NSAttributedString(string: "\n\nRelated Work", attributes: [NSAttributedStringKey.font: UIFont.Theme.subHeader.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
                
                for role in career.relatedRoles {
                    attributedString.append(NSAttributedString(string: "\n\(role.institution) - \(role.role) \(role.date)", attributes: [NSAttributedStringKey.font: UIFont.Theme.footNote.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
                }
            }
            
            attributedString.append(NSAttributedString(string: "\n\nReferences available by request", attributes: [NSAttributedStringKey.font: UIFont.Theme.footNote.font, NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color]))
        }
        return attributedString
    }
}
