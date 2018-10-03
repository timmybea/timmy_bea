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
    let projectSource: ProjectSource
    
    enum ProjectKeys: String, CodingKey {
        case title, shortDescription, longDescription, frameworks, languages, dateCompleted, videoThumbnailName, videoURL, gitHubURL, projectSource
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
        let projectSource = try container.decode(ProjectSource.self, forKey: .projectSource)
        
        
        
        self.init(title: title, shortDescription: shortDescription, longDescription: longDescription, frameworks: frameworks, languages: languages, dateCompleted: dateCompleted, videoThumbnailName: videoThumbnailName, videoURL: videoURL, gitHubURL: gitHubURL, source: projectSource)
    }
    
    init(title: String, shortDescription: String, longDescription: String, frameworks: String, languages: String, dateCompleted: String, videoThumbnailName: String, videoURL: String, gitHubURL: String, source: ProjectSource) {
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.frameworks =  frameworks
        self.languages = languages
        self.dateCompleted = dateCompleted
        self.videoThumbnailName = videoThumbnailName
        self.videoURL = videoURL
        self.gitHubURL = gitHubURL
        self.projectSource = source
        
        self.cacheImage(from: self.videoThumbnailName) { (_) in }
    }
    
    enum ProjectSource: Int, Codable {
        case github = 0
        case appleStore = 1
        
        var image: UIImage {
            switch self {
            case .github: return UIImage.Theme.gitIcon.image.withRenderingMode(.alwaysTemplate)
            case .appleStore: return UIImage.Theme.appleIcon.image.withRenderingMode(.alwaysTemplate)
            }
        }
    }
}

//MARK: ImageCachable conformance
extension Project : ImageCachable { }


