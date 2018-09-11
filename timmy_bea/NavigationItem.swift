//
//  NavigationItem.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-11.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import Foundation

enum NavigationItem {
    
    case skills, projects, education_work, about
    
    var cellID: String {
        switch self {
        case .skills:           return "skillsCell"
        case .projects:         return "projectsCell"
        case .education_work:   return "educationWorkCell"
        case .about:            return "aboutCell"
        }
    }
    
    var heading: String {
        switch self {
        case .skills:           return "Skills"
        case .projects:         return "Projects"
        case .education_work:   return "Education & Work"
        case .about:            return "About"
        }
    }
    
    static func orderedHeadings() -> [String] {
        return [NavigationItem.skills.heading,
                NavigationItem.projects.heading,
                NavigationItem.education_work.heading,
                NavigationItem.about.heading]
    }
    
    static func orderedCellIDs() -> [String] {
        return [NavigationItem.skills.cellID,
                NavigationItem.projects.cellID,
                NavigationItem.education_work.cellID,
                NavigationItem.about.cellID]
    }
    
}