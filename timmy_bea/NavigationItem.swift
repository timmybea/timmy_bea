//
//  NavigationItem.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-11.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Enum
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
    
    var iconImage: UIImage {
        switch self {
        case .skills:           return UIImage.Theme.skills.image
        case .projects:         return UIImage.Theme.projects.image
        case .education_work:   return UIImage.Theme.education.image
        case .about :           return UIImage.Theme.about.image
        }
    }
    
    static func orderedItems() -> [NavigationItem] {
        return [NavigationItem.skills,
                NavigationItem.projects,
                NavigationItem.education_work,
                NavigationItem.about]
    }
    
}
