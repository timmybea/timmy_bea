//
//  AttributedParagraph.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-25.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit


class AttributedParagraph {
    
    let attributedText = NSMutableAttributedString()
    let style = NSMutableParagraphStyle()
    
    func append(text: String, font: UIFont, alignment: NSTextAlignment) {
        self.style.alignment = alignment
        let new = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font: font,
                                                                NSAttributedStringKey.foregroundColor: UIColor.Theme.customSand.color,
                                                                NSAttributedStringKey.paragraphStyle: self.style])
        self.attributedText.append(new)
    }
}
