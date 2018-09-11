//
//  UIExtensions.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-11.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

//MARK: UINavigationBar Extension
extension UINavigationBar {
    
    //remove bar shadow
    static func setupCustomAppearance() {
        self.appearance().shadowImage = UIImage()
        self.appearance().setBackgroundImage(UIImage(), for: .default)
        self.appearance().barTintColor = UIColor.Theme.customWhite.color
    }
    
}

//MARK: UIImage Extension
extension UIImage {
    
    enum Theme {
        case backgroundGradient
        case contact
        case phone
        case email
        case linkedIn
        case github
        case cancel
        
        var name: String {
            switch self {
            case .backgroundGradient:    return "background_gradient"
            case .phone:                 return "phone"
            case .contact:               return "contact"
            case .email:                 return "contact_email"
            case .linkedIn:              return "contact_linkedIn"
            case .github:                return "contact_git"
            case .cancel:                return "contact_cancel"
            }
        }
        
        var image: UIImage {
            switch self {
            case .backgroundGradient:   return UIImage(named: self.name)!
            case .phone:                return UIImage(named: self.name)!
            case .contact:              return UIImage(named: self.name)!
            case .email:                return UIImage(named: self.name)!
            case .linkedIn:             return UIImage(named: self.name)!
            case .github:               return UIImage(named: self.name)!
            case .cancel:               return UIImage(named: self.name)!
            }
        }
    }
    
}

//MARK: UIImageView Extension
extension UIImageView {

    static func createWith(imageName: String?, contentMode: UIViewContentMode) -> UIImageView {
        let view = UIImageView()
        if let name = imageName, let image = UIImage(named: name) {
            view.image = image
        }
        view.contentMode = contentMode
        view.backgroundColor = UIColor.clear
        return view
    }
    
}

//MARK: UILabel Extension
extension UILabel {
    
    static func createLabelWith(text: String = "", color: UIColor = UIColor.white, font: UIFont = UIFont.Theme.subHeader.font) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        return label
    }

}

protocol UICollectionViewDelegateAndDatasource : UICollectionViewDataSource, UICollectionViewDelegate {}

extension UICollectionView {
    
    static func horizontalPagingCollectionView(in delegate: UICollectionViewDelegateAndDatasource) -> UICollectionView {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.isScrollEnabled = false
        cv.isPagingEnabled = true
        cv.delegate = delegate
        cv.dataSource = delegate
        return cv
    }
    
}
