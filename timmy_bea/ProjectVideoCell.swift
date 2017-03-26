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
        screenSize.width = Int(self.bounds.size.width - 16)
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
    
    let seperatorView: UIView = {
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
        
//        backgroundColor = UIColor.clear
        setupSubViews()
    }
    
    
    private func setupSubViews() {
        
        addSubview(titleLabel)
        addSubview(completedLabel)
        addSubview(seperatorView)
        addSubview(thumbnailImageView)
        addSubview(descriptionTextLabel)
        addSubview(gitHubButton)
        
        
        let titleLabelwidth = Int((self.bounds.size.width - 16) / 2)
        addConstraintsWithFormat(format: "H:|-8-[v0(\(titleLabelwidth))]", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(\(screenSize.width))]", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: seperatorView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: descriptionTextLabel)
        addConstraintsWithFormat(format: "H:[v0(24)]-8-|", views: gitHubButton)
        
        addConstraintsWithFormat(format: "V:|[v0(20)]-8-[v1(\(screenSize.height))]-8-[v2(20)][v3(24)]-8-[v4(2)]", views: titleLabel, thumbnailImageView, descriptionTextLabel, gitHubButton, seperatorView)
        
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 1))
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        
        gitHubButton.addTarget(self, action: #selector(launchGitHub), for: .touchUpInside)
        
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
