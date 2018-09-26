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
        textView.textAlignment = .center
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
            
            logoImageView.loadImage(from: career.imageName, with: .alwaysTemplate) { }
            
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
        
        let attributedParagraph = AttributedParagraph()
        guard let career = self.career else { return attributedParagraph.attributedText }
        
        attributedParagraph.append(text: career.description, font: UIFont.Theme.bodyText.font, alignment: .center)
        attributedParagraph.append(text: "\n\nEducation", font: UIFont.Theme.subHeader.font, alignment: .left)
        for qualification in career.education {
            attributedParagraph.append(text: "\n\(qualification.institution) - \(qualification.role) \(qualification.date)", font: UIFont.Theme.footNote.font, alignment: .left)
        }
        if !career.relatedRoles.isEmpty {
            attributedParagraph.append(text: "\n\nRelated Work", font: UIFont.Theme.subHeader.font, alignment: .left)
            
            for role in career.relatedRoles {
                attributedParagraph.append(text: "\n\(role.institution) - \(role.role) \(role.date)", font: UIFont.Theme.footNote.font, alignment: .left)
            }
            attributedParagraph.append(text: "\n\nReferences available by request", font: UIFont.Theme.footNote.font, alignment: .left)
        }
        return attributedParagraph.attributedText
    }
}
