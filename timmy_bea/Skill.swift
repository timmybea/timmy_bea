//
//  Skill.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

protocol SkillDelegate {
    func dataReceived()
}

//MARK: Properties and init
struct Skill : Decodable {
    
    let title: String
    let underline: CGFloat
    let bodyText: String
    
    enum SkillKeys: String, CodingKey {
        case title, underline, bodyText
    }
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SkillKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let underline = try container.decode(CGFloat.self, forKey: .underline)
        let bodyText = try container.decode(String.self, forKey: .bodyText)

        self.init(title: title, underline: underline, bodyText: bodyText)
    }
    
    init(title: String, underline: CGFloat, bodyText: String) {
        self.title = title
        self.underline = underline
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
