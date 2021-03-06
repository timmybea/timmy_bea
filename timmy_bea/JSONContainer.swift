//
//  JSONContainer.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-19.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import Foundation

//MARK: Public init and enum
struct JSONContainer : Decodable {
    
    enum JSONKeys: String, CodingKey {
        case about
        case skills
        case careers
        case projects
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        if let objects = try container.decodeIfPresent([About].self, forKey: .about) {
            type(of: self).about = objects
        }
        
        if let objects = try container.decodeIfPresent([Skill].self, forKey: .skills) {
            type(of: self).skills = objects
        }

        if let objects = try container.decodeIfPresent([Career].self, forKey: .careers) {
            type(of: self).careers = objects
        }
        
        if let objects = try container.decodeIfPresent([Project].self, forKey: .projects) {
            type(of: self).projects = objects
        }
    }

}

//Mark: Static interface
extension JSONContainer {
    
    static var about = [About]() {
        didSet {
            About.aboutData = about
        }
    }
    
    static var skills = [Skill]() {
        didSet {
            Skill.skillData = skills
        }
    }
    
    static var careers = [Career]() {
        didSet {
            Career.careerData = careers
        }
    }
    
    static var projects = [Project]() {
        didSet {
            Project.projectData = projects
        }
    }
    
    static func createContainer(from json: Data) -> Bool {
        guard let _ = try? JSONDecoder().decode(JSONContainer.self, from: json) else {
            return false
        }
        return true
    }
    
    static func getObjects(url: APIService.APIURL, completion: @escaping (_ success: Bool) -> Swift.Void) {
        
        APIService.fetchData(with: url) { (data, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            let success = JSONContainer.createContainer(from: data)
            
            completion(success)
        }
    }
    
}
