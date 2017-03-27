//
//  ProjectVideoCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit


class ProjectVideoCell: UICollectionViewCell {

    lazy var screenSize: ScreenSize = {
        var screenSize = ScreenSize()
        return screenSize
    }()
    
    var project: Project? {
        didSet {
            titleLabel.text = project?.title
            completedLabel.text = project?.dateCompleted
            descriptionTextLabel.text = project?.shortDescription
            thumbnailImageView.image = UIImage(named: (project?.videoThumbnailName)!)
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.AvenirNextDBold(size: 20)
        label.textColor = ColorManager.customSand()
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    let completedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = FontManager.AvenirNextMedium(size: 14)
        label.textColor = ColorManager.customSand()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.customSand()
        return view
    }()
    
    let thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    let descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.textColor = ColorManager.customSand()
        label.font = FontManager.AvenirNextRegular(size: 14)
        return label
    }()
    
    let gitHubButton: UIButton = {
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
        addSubview(descriptionTextLabel)
        addSubview(gitHubButton)
        gitHubButton.addTarget(self, action: #selector(launchGitHub), for: .touchUpInside)

        redrawCell()
    }
    
    func redrawCell() {
        
//        for constraint in self.constraints {
//            self.removeConstraint(constraint)
//        }
        
//        for view in self.subviews {
//            view.removeFromSuperview()
//        }
        
        if UIDevice.current.orientation.isPortrait {
            
            screenSize.width = Int(self.bounds.size.width - 16)
            
            let titleLabelWidth = Int((self.bounds.size.width - 16) / 2)
            titleLabel.frame = CGRect(x: 8, y: 0, width: titleLabelWidth, height: 20)

//            addConstraintsWithFormat(format: "H:|-8-[v0(\(titleLabelwidth))]", views: titleLabel)
//            addConstraintsWithFormat(format: "H:|-8-[v0(\(screenSize.width))]", views: thumbnailImageView)
//            addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: separatorView)
//            addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: descriptionTextLabel)
//            addConstraintsWithFormat(format: "H:[v0(24)]-8-|", views: gitHubButton)
//            
//            addConstraintsWithFormat(format: "V:|[v0(20)]-8-[v1(\(screenSize.height))]-8-[v2(24)][v3(24)]-8-[v4(2)]", views: titleLabel, thumbnailImageView, descriptionTextLabel, gitHubButton, separatorView)
//            
//            addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 1))
//            addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
//            addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: 0))
//            addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        } else {
            
            
//            screenSize.width = Int(self.bounds.size.width / 2)
//            addConstraintsWithFormat(format: "H:|-8-[v0(\(screenSize.width))]", views: thumbnailImageView)
//            addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: separatorView)
//            addConstraintsWithFormat(format: "V:|[v0(\(screenSize.height))]-8-[v1(2)]", views: thumbnailImageView, separatorView)
            
        }
    }
    
    func launchGitHub() {
        //print("launch git hub")
        if let url = URL(string: (project?.gitHubURL)!) {
            UIApplication.shared.open(url)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
