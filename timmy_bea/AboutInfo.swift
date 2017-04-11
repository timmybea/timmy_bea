//
//  AboutInfo.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-10.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

struct AboutInfo {

    
    static func getAboutInfo() -> [String] {
        
        let aboutOne = "Thank you for taking the time to experience this app and see some of the skill set that I have to offer. You can tap my face (gently!) to learn more about my soft skills, and what kinds of opportunities I'm seeking."
        
        let aboutTwo = "After living in Vancouver BC for the last eight years, I recently made my move to Medford OR to raise my young family with my wife who is a US citizen. At present I am seeking to expand my professional network while I wait for my immigration to be approved - something that I anticipate to happen around June 2017."

        let aboutThree = "I am looking for an opportunity to work with cool people on interesting, creative projects. I thrive in diverse, inclusive environments and value the relationships that I build with colleagues."
        

        let aboutFour = "I see myself as a lifelong-learner and I am seeking opportunities to not only apply, but also expand my skills base. I am an attentive student and I have a lot of drive when it comes to solving problems independently."
        

        let aboutFive = "I consider one of my strengths to be communication. I am very good at steering discussion towards a speedy and comfortable decision, whether meeting with a client to discuss a project, or coordinating with a development team to keep a project moving towards it's completion date."
        
        return [aboutOne, aboutTwo, aboutThree, aboutFour, aboutFive]
    }
    
    
}
