//
//  MenuCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    let imageView = UIImageView.createWith(imageName: nil, contentMode: .scaleAspectFit)
    
    private let iconSize: CGFloat = 26.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.tintColor = UIColor.Theme.customDarkBlue.color
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: iconSize),
            imageView.widthAnchor.constraint(equalToConstant: iconSize)
            ])
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.Theme.customDarkBlue.color
        }
    }
}
