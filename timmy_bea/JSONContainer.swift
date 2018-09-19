//
//  JSONContainer.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-19.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import Foundation

struct JSONContainer : Decodable {
    
    let about: [About]
    
    enum JSONKeys: String, CodingKey {
        case about
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        var a = [About]()
        
        if let objects = try container.decodeIfPresent([About].self, forKey: .about) {
            a = objects
        }

        self.init(about: a)
    }
    
    init(about: [About]) {
        self.about = about
    }
    
    static func createContainer(from json: Data) -> JSONContainer? {
        return try? JSONDecoder().decode(JSONContainer.self, from: json)
    }
    
}
