//
//  Skill.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Skill Delegate
protocol SkillDelegate {
    func dataReceived()
}

//MARK: Properties and init
struct Skill : Decodable {
    
    let title: String
    let bodyText: String
    
    enum SkillKeys: String, CodingKey {
        case title, bodyText
    }
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SkillKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let bodyText = try container.decode(String.self, forKey: .bodyText)

        self.init(title: title, bodyText: bodyText)
    }
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
    }
}

//MARK: Static interface
extension Skill {
    
    static var delegate: SkillDelegate?
    
    static var skillData = [Skill]() {
        didSet {
            delegate?.dataReceived()
        }
    }

}
