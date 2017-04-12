//
//  ProjectVideoCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

var pad: Int = 8

class ProjectVideoCell: UICollectionViewCell {

    lazy var screenSize: ScreenSize = {
        var screenSize = ScreenSize()
        return screenSize
    }()
    
    var project: Project? {
        didSet {
            titleLabel.text = project?.title
            completedLabel.text = project?.dateCompleted
            shortDescLabel.text = project?.shortDescription
            thumbnailImageView.image = UIImage(named: (project?.videoThumbnailName)!)
            longDescTextView.text = project?.longDescription
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.AvenirNextDBold(size: FontManager.sizeHeader)
        label.textColor = ColorManager.customSand()
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    private let completedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = FontManager.AvenirNextMedium(size: FontManager.sizeBodyText)
        label.textColor = ColorManager.customSand()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.customSand()
        return view
    }()
    
    private let thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private let shortDescLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = ColorManager.customSand()
        label.font = FontManager.AvenirNextRegular(size: FontManager.sizeBodyText)
        return label
    }()
    
    private let longDescTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = ColorManager.customSand()
        textView.font = FontManager.AvenirNextRegular(size: FontManager.sizeBodyText)
        return textView
    }()
    
    private let gitHubButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "git_pos")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = ColorManager.customSand()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(completedLabel)
        addSubview(separatorView)
        addSubview(thumbnailImageView)
        
        addSubview(gitHubButton)
        gitHubButton.addTarget(self, action: #selector(launchGitHub), for: .touchUpInside)

        redrawCell()
    }
    
    func redrawCell() {
     
        var currentY = 0
        var currentX = 0
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            
            longDescTextView.removeFromSuperview()
            screenSize.width = Int(self.bounds.size.width - 16)
            
            let titleLabelWidth: Int = (Int(self.bounds.size.width) - (pad * 2)) / 2
            titleLabel.frame = CGRect(x: pad, y: 0, width: titleLabelWidth, height: 20)
            
            currentX += pad + Int(titleLabel.frame.width)
            completedLabel.frame = CGRect(x: currentX, y: 0, width: titleLabelWidth, height: 20)

            currentY += Int(titleLabel.frame.height) + pad
            thumbnailImageView.frame = CGRect(x: pad, y: currentY, width: screenSize.width, height: screenSize.height)
            
            addSubview(shortDescLabel)
            
            currentY += Int(screenSize.height + 4)
            shortDescLabel.frame = CGRect(x: pad, y: currentY, width: Int(self.bounds.size.width) - (pad * 2), height: 24)
            
            
            currentY += Int(shortDescLabel.frame.height) + 4
            gitHubButton.frame = CGRect(x: Int(self.bounds.width) - 30 - pad, y: currentY, width: 30, height: 30)
            
            currentY += Int(gitHubButton.frame.height) + pad
            separatorView.frame = CGRect(x: pad, y: currentY, width: Int(self.bounds.width) - (pad * 2), height: 2)

        } else {
            
            shortDescLabel.removeFromSuperview()
            screenSize.width = (Int(self.bounds.size.width) - (pad * 2)) / 2
            
            currentX += pad
            thumbnailImageView.frame = CGRect(x: currentX, y: 0, width: screenSize.width, height: screenSize.height)
            
            currentX += screenSize.width + pad
            titleLabel.frame = CGRect(x: currentX, y: 0, width: (screenSize.width - pad) / 2, height: 20)

            addSubview(longDescTextView)

            currentY += Int(titleLabel.frame.height) + pad
            let descHeight = Int(self.bounds.height - titleLabel.bounds.height) - (pad * 3) - 32
            longDescTextView.frame = CGRect(x: currentX, y: currentY, width: screenSize.width - pad, height: descHeight)
            
            currentY += Int(longDescTextView.frame.height) + pad
            gitHubButton.frame = CGRect(x: Int(self.bounds.width) - 30 - pad, y: currentY, width: 30, height: 30)
            
            currentY += Int(gitHubButton.frame.height) + pad
            separatorView.frame = CGRect(x: pad, y: currentY, width: Int(self.bounds.width) - (pad * 2), height: 2)
            
            currentX += Int(titleLabel.frame.width)
            completedLabel.frame = CGRect(x: currentX, y: 0, width: Int(titleLabel.frame.width), height: 20)
        }
    }
    
    @objc private func launchGitHub() {
        if let url = URL(string: (project?.gitHubURL)!) {
            UIApplication.shared.open(url)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
