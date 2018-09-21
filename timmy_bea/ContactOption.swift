//
//  ContactOption.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-11.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Enum
enum ContactOption {
    case mobile
    case email
    case linkedIn
    case github
    case cancel
    
    var name: String {
        switch self {
        case .mobile:   return "Mobile"
        case .email:    return "Email"
        case .linkedIn: return "LinkedIn"
        case .github:   return "Github"
        case .cancel:   return "Cancel"
        }
    }
    
    var image: UIImage {
        switch self {
        case .mobile:   return UIImage.Theme.phone.image
        case .email:    return UIImage.Theme.email.image
        case .linkedIn: return UIImage.Theme.linkedIn.image
        case .github:   return UIImage.Theme.github.image
        case .cancel:   return UIImage.Theme.cancel.image
        }
    }
    
    static func allContactOptions() -> [ContactOption] {
        return [ContactOption.mobile,
                ContactOption.email,
                ContactOption.linkedIn,
                ContactOption.github,
                ContactOption.cancel]
    }
}
