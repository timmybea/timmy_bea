//
//  StackView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-01.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class StackView: UIView {

    var recipe: Recipe? {
        didSet {
            self.backgroundColor = recipe?.color
        }
    }
    
    
}
