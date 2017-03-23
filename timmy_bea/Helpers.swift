//
//  Helpers.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

struct ColorManager {
    
    static func whiteNavBar() -> UIColor {
        return UIColor(white: 200/255, alpha: 0.24)
    }
    
    static func customDarkBlue() -> UIColor {
        return UIColor(red: 2/255, green: 119/255, blue: 134/255, alpha: 1)
    }
    
    static func customPeach() -> UIColor {
        return UIColor(red: 226/255, green: 114/255, blue: 103/255, alpha: 1)
    }
    
    static func customSand() -> UIColor {
        return UIColor(red: 251/255, green: 221/255, blue: 189/255, alpha: 1)
    }
    
}

struct FontManager {
    
    static func AvenirNextULight(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-UltraLight", size: size)!
    }

    static func AvenirNextRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size)!
    }

    static func AvenirNextMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }

    static func AvenirNextDBold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size)!
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

class CustomCollectionViewCell: UICollectionViewCell {

    let activityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    func setupBackgroundView() {
        
        addSubview(activityView)
        activityView.frame = CGRect(x: 24, y: 24, width: self.bounds.width - 48, height: self.bounds.height - 24)
        
        let blueView = UIView(frame: activityView.bounds)
        activityView.addSubview(blueView)
        blueView.backgroundColor = ColorManager.customDarkBlue()
        blueView.alpha = 0.4
        blueView.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackgroundView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

