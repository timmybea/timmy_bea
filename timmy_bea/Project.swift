//
//  Project.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

struct Project {

    let title: String!
    let shortDescription: String!
    let longDescription: String!
    let frameWorks: String!
    let languages: String!
    let dateCompleted: String!
    let videoThumbnailName: String!
    let videoURL: String!
    let gitHubURL: String!
    
    static func getProjectArray() -> [Project] {
        
        let gifter = Project(title: "Gifter", shortDescription: "A gift organizer and planner", longDescription: "A gift organiser app. Users save friends and family into groups and create celebrations with reminders for getting gifts, or sending greeting cards.", frameWorks: "NSDate, JTCalendar, Realm, UNUserNotifications", languages: "Objective C", dateCompleted: "December 2016", videoThumbnailName: "Gifter_logo", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/Gifter.mp4?alt=media&token=ec379ed2-dca2-4039-8d8f-8ef5ec045f29", gitHubURL: "https://github.com/timmybea/Celebrator")
        
        let share = Project(title: "Share", shortDescription: "A food sharing social network", longDescription: "Share is a social networking platform that aims to mitigate food waste. Users post and request food items within their chosen radius and connect via a chat messenger.", frameWorks: "Firebase, JSQMessenger, CLLocation, WSTags, UIImagePicker", languages: "Swift", dateCompleted: "January 2017", videoThumbnailName: "Share_logo", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/Gifter.mp4?alt=media&token=ec379ed2-dca2-4039-8d8f-8ef5ec045f29", gitHubURL: "https://github.com/suvan92/FinalProject")
        
        let meTube = Project(title: "MeTube", shortDescription: "A demonstration app for practising custom UI Design", longDescription: "MeTube is an attempt to recreate the YouTube homepage entirely without the use of storyboards. It has the look and feel of the original interface, loads videos and provides playback options that YouTube users are familiar with.\n\nLanguage: Swift \n\nFrameworks: NSURLSessions, NSCache, AVFoundation", frameWorks: "NSURLSessions, NSCache, AVFoundation", languages: "Swift", dateCompleted: "February 2017", videoThumbnailName: "MeTube", videoURL: "https://firebasestorage.googleapis.com/v0/b/timmybea-3ba58.appspot.com/o/Gifter.mp4?alt=media&token=ec379ed2-dca2-4039-8d8f-8ef5ec045f29", gitHubURL: "https://github.com/timmybea/youtubeHomePage")
            
            return [meTube, share, gifter]
    }
}


