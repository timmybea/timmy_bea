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
        return UIColor(white: 200/255, alpha: 0.35)
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

//    static func customSkyBlue() -> UIColor {
//        return UIColor(red: 57/255, green: 186/255, blue: 200/255, alpha: 1)
//    }
//  
//    static func customSeaGreen() -> UIColor {
//        return UIColor(red: 156/255, green: 219/255, blue: 207/255, alpha: 1)
//    }
    
    static func customStackRust() -> UIColor {
        return UIColor(red: 208/255, green: 111/255, blue: 102/255, alpha: 0.87)
    }
    
    static func customStackGreen() -> UIColor {
        return UIColor(red: 90/255, green: 176/255, blue: 159/255, alpha: 0.87)
    }
    
    static func customStackBlue() -> UIColor {
        return UIColor(red: 59/255, green: 169/255, blue: 181/255, alpha: 0.87)
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

extension NSLayoutConstraint {
    
    class func constraintsWithFormat(format: String, views: UIView...) -> [NSLayoutConstraint] {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
        view.translatesAutoresizingMaskIntoConstraints = false
        let key = "v\(index)"
        viewsDictionary[key] = view
        }
        return constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary)
    }
}


struct ScreenSize {
    
    var width: Int {
        set {
            height =  Int(Double(newValue) * 0.5625)
        } get {
            return Int(Double(height) * 1.7777)
        }
    }
    
    var height: Int = 100
}


class CustomCollectionViewCell: UICollectionViewCell {

    func redrawCell() {
        sizeForOrientation()
    }
    
    let activityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.customDarkBlue()
        view.alpha = 0.4
        return view
    }()
    
    private func setupBackgroundView() {
        
        addSubview(activityView)
        sizeForOrientation()
        activityView.addSubview(blueView)
    }
    
    private func sizeForOrientation() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            activityView.frame = CGRect(x: 24, y: 24, width: self.bounds.width - 48, height: self.bounds.height - 48 - 10)
        } else {
            activityView.frame = CGRect(x: 24, y: 24, width: self.bounds.width - 48, height: self.bounds.height - 48)
        }
        blueView.frame = activityView.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackgroundView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool {
        return (visibleViewController?.shouldAutorotate)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (visibleViewController?.supportedInterfaceOrientations)!
    }
    
}



