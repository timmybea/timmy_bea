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
    let dateCompleted: String!
    let videoThumbnailName: String!
    let videoURL: String!
    let gitHubURL: String!
    
    static func getProjectArray() -> [Project] {

        let gifter = Project(title: "Gifter", shortDescription: "A gift organizer and planner", longDescription: "More details go here", dateCompleted: "December 2016", videoThumbnailName: "Gifter_logo", videoURL: "", gitHubURL: "https://github.com/timmybea/Celebrator")
        let share = Project(title: "Share", shortDescription: "A food sharing social network", longDescription: "More details go in here", dateCompleted: "January 2017", videoThumbnailName: "Share_logo", videoURL: "", gitHubURL: "https://github.com/suvan92/FinalProject")
        let meTube = Project(title: "MeTube", shortDescription: "A demonstration app for practising custom UI Design", longDescription: "More details go in here", dateCompleted: "February 2017", videoThumbnailName: "MeTube", videoURL: "", gitHubURL: "https://github.com/timmybea/youtubeHomePage")
        
        return [meTube, share, gifter]
    }
}


