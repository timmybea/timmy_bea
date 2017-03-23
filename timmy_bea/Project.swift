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
    let decription: String!
    let dateCompleted: String!
    let videoThumbnailName: String!
    let videoURL: String!
    
    static func getProjectArray() -> [Project] {

        let gifter = Project(title: "Gifter", decription: "A gift organizer and planner", dateCompleted: "December 2016", videoThumbnailName: "", videoURL: "")
        let share = Project(title: "Share", decription: "A food sharing social network", dateCompleted: "January 2017", videoThumbnailName: "", videoURL: "")
        let meTube = Project(title: "MeTube", decription: "A demonstration app for practising custom UI design", dateCompleted: "February 2017", videoThumbnailName: "", videoURL: "")
        
        return [gifter, share, meTube]
    }
}


