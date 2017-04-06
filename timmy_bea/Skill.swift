//
//  Skill.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

struct Skill {

    let title: String!
    let underline: CGFloat!
    let bodyText: String!
    
    static func skillDataArray() -> [Skill] {
        
        let skills = Skill(title: "Skills", underline: 60, bodyText: "< Swipe to learn more")
        
        let UIDesign = Skill(title: "UI Design", underline: 92, bodyText: "With an eye for color and composition, I have a passion for building intuitive, minimilist user interfaces programmatically or using storyboards. I believe in the importance of communicating effectively with the end user through visual components. I also enjoy creating interesting animations with a variety of approaches from using UIView animation methods, to dynamic animators, to Core Graphics and even After Effects.")
        let Languages = Skill(title: "Languages", underline: 102, bodyText: "I am a quick learner of  programming languages and have experience building projects in C, Objective C and Swift. I believe that code should be read and understood by a community of programmers, and so regularly seek to refactor my code to make it as readable, typesafe and concise as possible. My next goal is to build on my knowledge of javascript, and use it to create online backends to my apps.")
        let mvc = Skill(title: "MVC", underline: 42, bodyText: "In the interest of making my projects as reusable and accessible as possible, I am a believer in applying SOLID principles to MVC architecture. While making my code as encapsulated and private as possible, I am comfortable using delegate patterns, notifications and occassionally singletons to pass information appropriately through the MVC chain.")
        let networking = Skill(title: "Networking", underline: 106, bodyText: "I have experience performing many common networking tasks in apps. Some tasks include using APIs to download data, parsing json data for model objects, caching reusable data, using predicates in data requests, and uploading user data to a database in real time. I have worked with Firebase and Parse, and am eager to learn how to build databases using MongoDB.")
        let gcd = Skill(title: "GCD", underline: 42, bodyText: "I have a good understanding of the role of GCD in a multithreading environment, and am comfortable assigning work items to dispatch queues with appropriate quality of service so as to create a smooth continuous user experience.")
        let persistence = Skill(title: "Data Persistence", underline: 152, bodyText: "There are so many ways with which to persist data and I have had the opportunity to explore several of them from user defaults, to the keychain, to using the file manager to persist data to the file system. I have also used the dependency Realm and have some experience with CoreData, although I look forward to learning more about its complexities.")
        let versioning = Skill(title: "Versioning", underline: 100, bodyText: "Github is an incredibly useful versioning tool that I use on a daily basis. I am very comfortable with essential processes like setting up local and remote repositories, using git ignores, inviting collaborators, branching, handling pull requests, and merging branches. I also understand and use best practices to avoid nasty merge conflicts that we all hate to deal with.")
        
        return [skills, UIDesign, Languages, mvc, networking, gcd, persistence, versioning]
    }
}
