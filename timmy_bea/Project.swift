//
//  Project.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

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
    
//    static func getProjectArray() -> [Project] {
//
//        let gifter = Project(title: "Gifter", shortDescription: "A gift organizer and planner", longDescription: "A gift organiser app. Users save friends and family into groups and create celebrations with reminders for getting gifts, or sending greeting cards.", frameWorks: "NSDate, JTCalendar, Realm, UNUserNotifications", languages: "Objective C", dateCompleted: "December 2016", videoThumbnailName: "Gifter_logo", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/Gifter.mp4?alt=media&token=4b6413e4-a206-4cf6-80c7-978267d71da2", gitHubURL: "https://github.com/timmybea/Celebrator")
//
//        let share = Project(title: "Share", shortDescription: "A food sharing social network", longDescription: "Share is a social networking platform that aims to mitigate food waste. Users post and request food items within their chosen radius and connect via a chat messenger.", frameWorks: "Firebase, JSQMessenger, CLLocation, WSTags, UIImagePicker", languages: "Swift", dateCompleted: "January 2017", videoThumbnailName: "Share_logo", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/Share.mp4?alt=media&token=e02d4f65-d19f-4970-85a6-1701f5592cd1", gitHubURL: "https://github.com/suvan92/FinalProject")
//
//        let meTube = Project(title: "MeTube", shortDescription: "A demonstration app for practising custom UI Design", longDescription: "MeTube is an attempt to recreate the YouTube app entirely without the use of storyboards. It has the look and feel of the original interface, loads videos and provides playback options that YouTube users are familiar with.", frameWorks: "NSURLSessions, NSCache, AVFoundation", languages: "Swift", dateCompleted: "February 2017", videoThumbnailName: "MeTube", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/MeTube.mp4?alt=media&token=a1d6a2ba-c749-4d32-8deb-7ea845cdc1ea", gitHubURL: "https://github.com/timmybea/youtubeHomePage")
//
//        let borrowmatic = Project(title: "Borrowmatic", shortDescription: "A CoreData demonstration app", longDescription: "A demonstration app that uses CoreData to persist person and borrowed item managed objects. Features: Fetched results controller handles tableview updates. Sort results by date (sort descriptor) and by person (section name key).", frameWorks: "CoreData, GLCalendarView, MLPAutoCompleteTextField", languages: "Swift", dateCompleted: "May 2017", videoThumbnailName: "Borrowmatic_logo", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/Borrowmatic.mp4?alt=media&token=9dee3689-ffae-4266-9de6-b6b274814980", gitHubURL: "https://github.com/timmybea/CoreDataExpert")
//
//        let swiftServer = Project(title: "Swift Server", shortDescription: "A demonstration Swift API", longDescription: "A demonstration server and API built using server-side swift with the Kitura framework. Document database created using CouchDB. Local development using Docker Containers. Cloud hosting with Bluemix. A demonstration client application makes networking calls with both NSURLSessions and Alamofire (just for practice!).", frameWorks: "Kitura, CouchDB, CloudFoundryEnv, HeliumLogger, SwiftyJSON", languages: "Swift, PHP", dateCompleted: "May 2017", videoThumbnailName: "SwiftServer_logo", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/SwiftServer.mp4?alt=media&token=71c68998-8f12-4023-ab4f-635790c1c8ef", gitHubURL: "https://github.com/timmybea/ServerAPIDev_Swift")
//
//            return [borrowmatic, swiftServer, meTube, share, gifter]
//    }
}

//MARK: Protocol conformance
extension Project : ImageCachable { }


