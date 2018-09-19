//
//  About.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-10.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

struct About : Decodable {

    static var aboutData = [About]()
    
    var text: String
    
    enum AboutKeys: String, CodingKey {
        case text
    }

    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AboutKeys.self)
        
        let text = try container.decode(String.self, forKey: .text)
        self.init(text: text)
    }
    
    init(text: String) {
        self.text = text
    }
}

extension About {
    
    static func getAboutObjects(from container: JSONContainer) {
        self.aboutData = container.about
    }
    
}
