//
//  Helpers.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit


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
            case .customBlue:       return UIColor.colorWithValues(red: 75, green: 103, blue: 146, alpha: 0.87)
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
        case contact
        
        var size: CGFloat {
            switch self {
            case .navText:      return Device.isSizeOrLarger(height: .Inches_4_7) ? 20 : 18
            case .header:       return Device.isSizeOrLarger(height: .Inches_4_7) ? 18 : 16
            case .contact:      return Device.isSizeOrLarger(height: .Inches_4_7) ? 16 : 14
            case .subHeader:    return Device.isSizeOrLarger(height: .Inches_4_7) ? 18 : 14
            case .bodyText:     return Device.isSizeOrLarger(height: .Inches_4_7) ? 16 : 14
            case .footNote:     return Device.isSizeOrLarger(height: .Inches_4_7) ? 14 : 12
            
            }
        }
        
        var font: UIFont {
            switch self {
            case .navText:      return UIFont.systemFont(ofSize: size, weight: .medium)
            case .header:       return UIFont.systemFont(ofSize: size, weight: .heavy)
            case .contact:      return UIFont.systemFont(ofSize: size, weight: .regular)
            case .subHeader:    return UIFont.systemFont(ofSize: size, weight: .medium)
            case .bodyText:     return UIFont.systemFont(ofSize: size, weight: .regular)
            case .footNote:     return UIFont.systemFont(ofSize: size, weight: .light)
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




