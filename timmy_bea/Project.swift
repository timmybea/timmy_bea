//
//  Project.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Properties and initializers
struct Project : Decodable {

    static var projectData = [Project]()
    
    let title: String
    let shortDescription: String
    let longDescription: String
    let frameworks: String
    let languages: String
    let dateCompleted: String
    let videoThumbnailName: String
    let videoURL: String
    let gitHubURL: String
    
    enum ProjectKeys: String, CodingKey {
        case title, shortDescription, longDescription, frameworks, languages, dateCompleted, videoThumbnailName, videoURL, gitHubURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProjectKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let shortDescription = try container.decode(String.self, forKey: .shortDescription)
        let longDescription = try container.decode(String.self, forKey: .longDescription)
        let frameworks = try container.decode(String.self, forKey: .frameworks)
        let languages = try container.decode(String.self, forKey: .languages)
        let dateCompleted = try container.decode(String.self, forKey: .dateCompleted)
        let videoThumbnailName = try container.decode(String.self, forKey: .videoThumbnailName)
        let videoURL = try container.decode(String.self, forKey: .videoURL)
        let gitHubURL = try container.decode(String.self, forKey: .gitHubURL)
        
        self.init(title: title, shortDescription: shortDescription, longDescription: longDescription, frameworks: frameworks, languages: languages, dateCompleted: dateCompleted, videoThumbnailName: videoThumbnailName, videoURL: videoURL, gitHubURL: gitHubURL)
    }
    
    init(title: String, shortDescription: String, longDescription: String, frameworks: String, languages: String, dateCompleted: String, videoThumbnailName: String, videoURL: String, gitHubURL: String) {
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.frameworks =  frameworks
        self.languages = languages
        self.dateCompleted = dateCompleted
        self.videoThumbnailName = videoThumbnailName
        self.videoURL = videoURL
        self.gitHubURL = gitHubURL
        
        self.cacheImage(from: self.videoThumbnailName) { (_) in }
    }
}

//MARK: ImageCachable conformance
extension Project : ImageCachable { }


