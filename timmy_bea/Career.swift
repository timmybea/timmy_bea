//
//  Career.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-04.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: CareerDetail Properties and init
struct CareerDetail : Decodable {
    
    let institution: String
    let role: String
    let date: String
    
    enum CareerDetailKeys: String, CodingKey {
        case institution
        case role
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CareerDetailKeys.self)
        
        let institution = try container.decode(String.self, forKey: .institution)
        let role = try container.decode(String.self, forKey: .role)
        let date = try container.decode(String.self, forKey: .date)
        
        self.init(institution: institution, role: role, date: date)
    }
    
    init(institution: String, role: String, date: String) {
        self.institution = institution
        self.role = role
        self.date = date
    }
}

//MARK: Career properies and init
struct Career : Decodable {

    static var careerData = [Career]()
    
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
    let education: [CareerDetail]
    let relatedRoles: [CareerDetail]
    let relatedURLs: [String]
    
    enum CareerKeys: String, CodingKey {
        case title
        case subtitle
        case description
        case imageName
        case education
        case relatedRoles
        case relatedURLs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CareerKeys.self)
        
        let title: String = try container.decode(String.self, forKey: .title)
        let subtitle: String = try container.decode(String.self, forKey: .subtitle)
        let description: String = try container.decode(String.self, forKey: .description)
        let imageName: String = try container.decode(String.self, forKey: .imageName)
        let education: [CareerDetail] = try container.decode([CareerDetail].self, forKey: .education)
        let relatedRoles: [CareerDetail] = try container.decode([CareerDetail].self, forKey: .relatedRoles)
        let relatedURLs: [String] = (try? container.decode([String].self, forKey: .relatedRoles)) ?? []
        
        self.init(title: title, subtitle: subtitle, description: description, imageName: imageName, educaton: education, relatedRoles: relatedRoles, relatedURLs: relatedURLs)
    }
    
    init(title: String, subtitle: String, description: String, imageName: String, educaton: [CareerDetail], relatedRoles: [CareerDetail], relatedURLs: [String]) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.imageName = imageName
        self.education = educaton
        self.relatedRoles = relatedRoles
        self.relatedURLs = relatedURLs
        
        cacheImage(from: imageName) { (_) in }
    }
    
}

//MARK: Private methods
extension Career : ImageCachable { }
