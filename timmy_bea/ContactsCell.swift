//
//  ContactsCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-03.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ContactsCell: UICollectionViewCell {
    
    var contact: Contact? {
        didSet {
            nameLabel.text = contact?.name.rawValue
            iconImageView.image = UIImage(named: (contact?.imageName)!)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Theme.bodyText.font
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.darkGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(18)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(18)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    override var isHighlighted: Bool {
        didSet {
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
            self.backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
        }
    }
}
