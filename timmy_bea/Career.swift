//
//  Career.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-04.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit


struct CareerDetail {
    let institution: String!
    let role: String!
    let date: String!
}

struct Career {

    let title: String!
    let subtitle: String!
    let description: String!
    let imageName: String!
    let education: [CareerDetail]!
    let relatedRoles: [CareerDetail]!
    let relatedURLs: [String]!
    let backgroundColor: UIColor!

    static func getCareers() -> [Career] {
        
        let musEdOne = CareerDetail(institution: "Victoria University of Wellington", role: "BA Media Studies", date: "(2001 - 2004)")
        let musEdTwo = CareerDetail(institution: "Victoria University of Wellington", role: "BMus Music Composition", date: "(2001 - 2004)")
        let musRoleOne = CareerDetail(institution: "LOOP Recordings", role: "Promoter", date: "(2001 - 2004)")
        let musRoleTwo = CareerDetail(institution: "Freelance", role: "Musician", date: "(2005 - 2009)")
        let musRoleThree = CareerDetail(institution: "Freelance", role: "Music Teacher", date: "(2007 - 2009)")
        
        let musician = Career(title: "Musician & Music Teacher (New Zealand)", subtitle: "2004 - 2009", description: "I completed two degrees in Wellington, New Zealand to pursue my passion of music. In the years that followed, I worked as a promoter for an independent record label, as an independent musician touring internationally and publishing my own sound recordings, and also as a private teacher for cello and bass. Predominantly working as a freelancer, I learned a tremendous amount about managing projects and seeing them through to completion.", imageName: "logo_VUW", education: [musEdOne, musEdTwo], relatedRoles: [musRoleOne, musRoleTwo, musRoleThree], relatedURLs: [], backgroundColor: ColorManager.customStackGreen())
        
        let teachEdOne = CareerDetail(institution: "ILAC", role: "TESOL Certificate", date: "(2010)")
        let teachEdTwo = CareerDetail(institution: "ILAC", role: "TESOL Instruction Certificate", date: "(2014)")
        let teachEdThree = CareerDetail(institution: "Cambridge University", role: "CAE Examiner Certification", date: "(2012 - 2016)")
        
        let teachRoleOne = CareerDetail(institution: "Instructor", role: "English for Academic Purposes, Business English, General English (low intermediate to high advanced)", date: "")
        let teachRoleTwo = CareerDetail(institution: "Instructor", role: "TESOL Certificate Program", date: "")
        let teachRoleThree = CareerDetail(institution: "Presenter", role: "professional development seminars", date: "")
        let teachRoleFour = CareerDetail(institution: "Examiner", role: "CAE speaking test", date: "")
        
        let teacher = Career(title: "ESL Teacher (Canada)", subtitle: "2010 - 2016", description: "I enjoyed a varied and rewarding teaching career in Vancouver, BC. During my time at the International Language Academy of Canada I developed and taught curriculum for a wide range of language levels and purposes. I also delivered professional development seminars to my colleagues and became a certified TESOL instructor, helping others to become teachers themselves. I was involved in all aspects of school life and was an active member of the social committee.", imageName: "logo_ILAC", education: [teachEdOne, teachEdTwo, teachEdThree], relatedRoles: [teachRoleOne, teachRoleTwo, teachRoleThree, teachRoleFour], relatedURLs: [], backgroundColor: ColorManager.customStackRust())


        let iOSEdOne = CareerDetail(institution: "Lighthouse Labs", role: "iOS Development Bootcamp", date: "(2016)")
        
        let iOSDeveloper = Career(title: "iOS Developer (Canada, USA)", subtitle: "2016 - present", description: "My hobbyist interest in coding turned into a career pursuit last year, when I embarked on a two and a half month iOS bootcamp at Lighthouse Labs in Vancouver, BC. The intensive course covered a comprehensive list of core competencies and frameworks. I worked extensively in Swift and Objective C with a hands on approach. My partner and I won the People's Choice award for our final project called Share. Now I am seeking opportunities to develop my craft and career further.", imageName: "logo_LHL", education: [iOSEdOne], relatedRoles: [], relatedURLs: [], backgroundColor: ColorManager.customStackBlue())
        
        return [musician, teacher, iOSDeveloper]
    }
}
