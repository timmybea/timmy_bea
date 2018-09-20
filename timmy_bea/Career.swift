//
//  Career.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-04.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit


struct CareerDetail : Decodable {
    
    let institution: String
    let role: String
    let date: String
    
    enum CareerDetailKeys: String, CodingKey {
        case institution
        case role
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CareerDetailKeys.self)
        
        let institution = try container.decode(String.self, forKey: .institution)
        let role = try container.decode(String.self, forKey: .role)
        let date = try container.decode(String.self, forKey: .date)
        
        self.init(institution: institution, role: role, date: date)
    }
    
    init(institution: String, role: String, date: String) {
        self.institution = institution
        self.role = role
        self.date = date
    }
}

struct Career : Decodable {

    static var careerData = [Career]()
    
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
    let education: [CareerDetail]
    let relatedRoles: [CareerDetail]
    let relatedURLs: [String]
    
    enum CareerKeys: String, CodingKey {
        case title
        case subtitle
        case description
        case imageName
        case education
        case relatedRoles
        case relatedURLs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CareerKeys.self)
        
        let title: String = try container.decode(String.self, forKey: .title)
        let subtitle: String = try container.decode(String.self, forKey: .subtitle)
        let description: String = try container.decode(String.self, forKey: .description)
        let imageName: String = try container.decode(String.self, forKey: .imageName)
        let education: [CareerDetail] = try container.decode([CareerDetail].self, forKey: .education)
        let relatedRoles: [CareerDetail] = try container.decode([CareerDetail].self, forKey: .relatedRoles)
        let relatedURLs: [String] = (try? container.decode([String].self, forKey: .relatedRoles)) ?? []
        
        self.init(title: title, subtitle: subtitle, description: description, imageName: imageName, educaton: education, relatedRoles: relatedRoles, relatedURLs: relatedURLs)
    }
    
    init(title: String, subtitle: String, description: String, imageName: String, educaton: [CareerDetail], relatedRoles: [CareerDetail], relatedURLs: [String]) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.imageName = imageName
        self.education = educaton
        self.relatedRoles = relatedRoles
        self.relatedURLs = relatedURLs
        
        //cacheImage()
    }
    
//    private func cacheImage() {
//
//        UIImage.cacheImage(from: self.imageName) { (_) in
//            //
//        }
//
//    }
    
    
//    static func getCareers() -> [Career] {
//
//        let musEdOne = CareerDetail(institution: "Victoria University of Wellington", role: "BA Media Studies", date: "(2001 - 2004)")
//        let musEdTwo = CareerDetail(institution: "Victoria University of Wellington", role: "BMus Music Composition", date: "(2001 - 2004)")
//        let musRoleOne = CareerDetail(institution: "LOOP Recordings", role: "Promoter", date: "(2001 - 2004)")
//        let musRoleTwo = CareerDetail(institution: "Freelance", role: "Musician", date: "(2005 - 2009)")
//        let musRoleThree = CareerDetail(institution: "Freelance", role: "Music Teacher", date: "(2007 - 2009)")
//
//        let musician = Career(title: "Musician & Music Teacher (New Zealand)", subtitle: "2004 - 2009", description: "I completed two degrees in Wellington, New Zealand to pursue my passion of music. In the years that followed, I worked as a promoter for an independent record label, as an independent musician touring internationally and publishing my own sound recordings, and also as a private teacher for cello and bass. Predominantly working as a freelancer, I learned a tremendous amount about managing projects and seeing them through to completion.", imageName: "logo_VUW", education: [musEdOne, musEdTwo], relatedRoles: [musRoleOne, musRoleTwo, musRoleThree], relatedURLs: [], backgroundColor: UIColor.Theme.customGreen.color)
//
//        let teachEdOne = CareerDetail(institution: "ILAC", role: "TESOL Certificate", date: "(2010)")
//        let teachEdTwo = CareerDetail(institution: "ILAC", role: "TESOL Instruction Certificate", date: "(2014)")
//        let teachEdThree = CareerDetail(institution: "Cambridge University", role: "CAE Examiner Certification", date: "(2012 - 2016)")
//
//        let teachRoleOne = CareerDetail(institution: "Instructor", role: "English for Academic Purposes, Business English, General English (low intermediate to high advanced)", date: "")
//        let teachRoleTwo = CareerDetail(institution: "Instructor", role: "TESOL Certificate Program", date: "")
//        let teachRoleThree = CareerDetail(institution: "Presenter", role: "professional development seminars", date: "")
//        let teachRoleFour = CareerDetail(institution: "Examiner", role: "CAE speaking test", date: "")
//
//        let teacher = Career(title: "ESL Teacher (Canada)", subtitle: "2010 - 2016", description: "I enjoyed a varied and rewarding teaching career in Vancouver, BC. During my time at the International Language Academy of Canada I developed and taught curriculum for a wide range of language levels and purposes. I also delivered professional development seminars to my colleagues and became a certified TESOL instructor, helping others to become teachers themselves. I was involved in all aspects of school life and was an active member of the social committee.", imageName: "logo_ILAC", education: [teachEdOne, teachEdTwo, teachEdThree], relatedRoles: [teachRoleOne, teachRoleTwo, teachRoleThree, teachRoleFour], relatedURLs: [], backgroundColor: UIColor.Theme.customRust.color)
//
//
//        let iOSEdOne = CareerDetail(institution: "Lighthouse Labs", role: "iOS Development Bootcamp", date: "(2016)")
//
//        let iOSDeveloper = Career(title: "iOS Developer (Canada, USA)", subtitle: "2016 - present", description: "My hobbyist interest in coding turned into a career pursuit last year, when I embarked on a two and a half month iOS bootcamp at Lighthouse Labs in Vancouver, BC. The intensive course covered a comprehensive list of core competencies and frameworks. I worked extensively in Swift and Objective C with a hands on approach. My partner and I won the People's Choice award for our final project called Share. Now I am seeking opportunities to develop my craft and career further.", imageName: "logo_LHL", education: [iOSEdOne], relatedRoles: [], relatedURLs: [], backgroundColor: UIColor.Theme.customBlue.color)
//
//        return [musician, teacher, iOSDeveloper]
//    }
}
