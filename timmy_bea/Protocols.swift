//
//  Protocols.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-11.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import Foundation

protocol Scrollable {
    
    var pageTracker: Int { get set }
    func scrollToItemAt(index: Int)
    
}
