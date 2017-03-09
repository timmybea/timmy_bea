//
//  File.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

struct ColorManager {
    
    static func customMaroon() -> UIColor {
        return UIColor(red: 139/255, green: 30/255, blue: 63/255, alpha: 1)
    }
    
    static func customGrape() -> UIColor {
        return UIColor(red: 60/255, green: 21/255, blue: 59/255, alpha: 1)
    }
    
    static func customMint() -> UIColor {
        return UIColor(red: 137/255, green: 189/255, blue: 158/255, alpha: 1)
    }
    
    static func customCreme() -> UIColor {
        return UIColor(red: 240/255, green: 201/255, blue: 135/255, alpha: 1)
    }
    
    static func customRust() -> UIColor {
        return UIColor(red: 219/255, green: 76/255, blue: 64/255, alpha: 1)
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
