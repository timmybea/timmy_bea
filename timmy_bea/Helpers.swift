//
//  File.swift
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
