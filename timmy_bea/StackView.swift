//
//  StackView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-01.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Properties and Initializer
class StackView: UIView, UIScrollViewDelegate {
    
    var career:  Career? {
        didSet {
            setupSubviews()
        }
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

}

//MARK: UI Layout
extension StackView {
    
    private func setupSubviews() {
        
        setupStackLayer()
        addSubviews()
        layoutFrames()
    }
    
    private func setupStackLayer() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
    }
    
    private func addSubviews() {
        if self.career != nil {
            self.addSubview(logoImageView)
            self.addSubview(titleLabel)
            self.addSubview(subtitleLabel)
            self.addSubview(mainTextView)
        }
    }
    
    private func layoutFrames() {
        guard let career = self.career else { return }
        
        logoImageView.loadImage(from: career.imageName, with: .alwaysTemplate) { }
        let isPortrait = UIApplication.isPortrait
        
        let logoX = isPortrait ? CGFloat.pad : (CGFloat.pad * 3.0)
        let logoY: CGFloat = isPortrait ? CGFloat.pad * 2 : CGFloat.pad
        let logoWidth = isPortrait ? (self.bounds.width - (2 * CGFloat.pad)) / 3 : (self.bounds.width - (2 * CGFloat.pad)) / 5
        logoImageView.frame = CGRect(x: logoX, y: logoY, width: logoWidth, height: logoWidth / 2)

        
        let titleX = logoImageView.frame.maxX + CGFloat.pad
        let titleWidth = self.bounds.width - logoImageView.frame.maxX - (CGFloat.pad * 2)
        titleLabel.frame = CGRect(x: titleX,
                                  y: CGFloat.pad * 2,
                                  width: titleWidth,
                                  height: 20)
        titleLabel.text = career.title
        titleLabel.sizeToFit()
        titleLabel.center.x = titleX + (titleWidth / 2)
 
        subtitleLabel.frame = CGRect(x: titleX,
                                     y: titleLabel.frame.maxY + 4.0,
                                     width: titleWidth,
                                     height: 18)
        subtitleLabel.center.x = titleLabel.center.x
        subtitleLabel.text = career.subtitle
        
        let textY = max(logoImageView.frame.maxY, subtitleLabel.frame.maxY) + CGFloat.pad
        mainTextView.frame = CGRect(x: CGFloat.pad,
                                    y: textY,
                                    width: self.bounds.width - (2 * CGFloat.pad),
                                    height: self.bounds.height - textY - 40.0)
        mainTextView.isScrollEnabled = false
        mainTextView.attributedText = createAttributedString()
        mainTextView.alpha = 0
    }
}

//MARK: Text formatting
extension StackView {
    
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
