//
//  MenuCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Properties
class MenuCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView.createWith(imageName: nil, contentMode: .scaleAspectFit)
        view.tintColor = UIColor.Theme.customDarkBlue.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconSize: CGFloat = 26.0
    
}

//MARK: Override methods
extension MenuCell {
    
    override func layoutSubviews() {
        imageView.removeFromSuperview()
        
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
