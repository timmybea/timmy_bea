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
    let skills: [Skill]
    
    enum JSONKeys: String, CodingKey {
        case about, skills
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        var a = [About]()
        var s = [Skill]()
        
        if let objects = try container.decodeIfPresent([About].self, forKey: .about) {
            a = objects
        }
        
        if let objects = try container.decodeIfPresent([Skill].self, forKey: .skills) {
            s = objects
        }

        self.init(about: a, skills: s)
    }
    
    init(about: [About], skills: [Skill]) {
        self.about = about
        self.skills = skills
    }
    
    static func createContainer(from json: Data) -> JSONContainer? {
        return try? JSONDecoder().decode(JSONContainer.self, from: json)
    }
    
}
