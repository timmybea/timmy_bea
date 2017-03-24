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
            descriptionTextLabel.text = project?.decription
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
        label.backgroundColor = UIColor.clear
        label.textColor = ColorManager.customSand()
        label.font = FontManager.AvenirNextRegular(size: 14)
        return label
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
        
        
        let titleLabelwidth = Int((self.bounds.size.width - 16) / 2)
        addConstraintsWithFormat(format: "H:|-8-[v0(\(titleLabelwidth))]", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(\(screenSize.width))]", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: seperatorView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: descriptionTextLabel)
        
        addConstraintsWithFormat(format: "V:|[v0(20)]-8-[v1(\(screenSize.height))]-8-[v2(20)]-8-[v3(2)]", views: titleLabel, thumbnailImageView, descriptionTextLabel, seperatorView)
        
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 1))
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: completedLabel, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
