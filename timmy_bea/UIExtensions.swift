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
    
    //["skills", "projects", "education", "about"]
    enum Theme {
        case backgroundGradient
        case contact
        case phone
        case email
        case linkedIn
        case github
        case cancel
        case skills
        case projects
        case education
        case about
        
        var name: String {
            switch self {
            case .backgroundGradient:    return "background_gradient"
            case .phone:                 return "phone"
            case .contact:               return "contact"
            case .email:                 return "contact_email"
            case .linkedIn:              return "contact_linkedIn"
            case .github:                return "contact_git"
            case .cancel:                return "contact_cancel"
            case .skills:                 return "skills"
            case .projects:               return "projects"
            case .education:              return "education"
            case .about:                  return "about"
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
            case .skills:               return UIImage(named: self.name)!
            case .projects:             return UIImage(named: self.name)!
            case .education:            return UIImage(named: self.name)!
            case .about:                return UIImage(named: self.name)!
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
    
    static func defaultCollectionView(in delegate: UICollectionViewDelegateAndDatasource) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = delegate
        cv.dataSource = delegate
        return cv
    }
    
}

extension UINavigationController {
    
    static var navBarHeight: CGFloat {
        return UIDevice.current.orientation.isPortrait ? 44 : landscapeHeight
    }
    
    private static var landscapeHeight: CGFloat {
        return Device.IS_5_5_INCHES() ? 44 : 32
    }
    
}

extension UIScreen {
    
    static var statusHeight: CGFloat {
        if Device.isPhone() {
            return UIDevice.current.orientation.isPortrait ? 20.0 : 0.0
        } else {
            return 0.0
        }
    }

    static var safeAreaTop: CGFloat {
        if Device.isIphoneX() {
            return UIDevice.current.orientation.isPortrait ? 44 : 0.0
        } else {
            return statusHeight
        }
    }
    
}

