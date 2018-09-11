//
//  Helpers.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: UIColor Extensions
extension UIColor {
    
    static func colorWithValues(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
}

extension UIColor {
    
    enum Theme {
        case customWhite
        case customDarkBlue
        case customPeach
        case customSand
        case customRust
        case customGreen
        case customBlue
        
        var color: UIColor {
            switch self {
            case .customWhite:      return UIColor(white: 200/255, alpha: 0.35)
            case .customDarkBlue:   return UIColor.colorWithValues(red: 2, green: 119, blue: 134, alpha: 1)
            case .customPeach:      return UIColor.colorWithValues(red: 226, green: 114, blue: 103, alpha: 1)
            case .customSand:       return UIColor.colorWithValues(red: 251, green: 221, blue: 189, alpha: 1)
            case .customRust:       return UIColor.colorWithValues(red: 208, green: 111, blue: 102, alpha: 0.87)
            case .customGreen:      return UIColor.colorWithValues(red: 90, green: 176, blue: 159, alpha: 0.87)
            case .customBlue:       return UIColor.colorWithValues(red: 90, green: 176, blue: 159, alpha: 0.87)
            }
        }
    }

}

//MARK: UIFont Extensions
extension UIFont {
    
    enum Theme {
        
        case navText
        case header
        case subHeader
        case bodyText
        case footNote
        
        var size: CGFloat {
            switch self {
            case .navText:      return Device.isSizeOrLarger(height: .Inches_4_7) ? 20 : 18
            case .header:       return Device.isSize(height: .Inches_4_7) ? 18 : 14
            case .subHeader:    return Device.isSize(height: .Inches_4_7) ? 14 : 12
            case .bodyText:     return Device.isSize(height: .Inches_4_7) ? 12 : 10
            case .footNote:     return Device.isSize(height: .Inches_4_7) ? 11 : 9
            }
        }
        
        var font: UIFont {
            switch self {
            case .navText:      return UIFont.systemFont(ofSize: size, weight: .medium)
            case .header:       return UIFont.systemFont(ofSize: size, weight: .heavy)
            case .subHeader:    return UIFont(name: FontFamily.medium.rawValue, size: size)!
            case .bodyText:     return UIFont(name: FontFamily.regular.rawValue, size: size)!
            case .footNote:     return UIFont(name: FontFamily.regular.rawValue, size: size)!
            }
            
        }
        
        private enum FontFamily: String {
            case ultraLight = "AvenirNext-UltraLight"
            case regular = "AvenirNext-Regular"
            case medium = "AvenirNext-Medium"
            case demiBold = "AvenirNext-DemiBold"
            case italic = "AvenirNext-Italic"
        }
        
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
        view.backgroundColor = UIColor.Theme.customDarkBlue.color
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


