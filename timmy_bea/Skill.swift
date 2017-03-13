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

}

class SkillData: NSObject {
    
    class func skillDataArray() -> [Skill] {
        
        let skills = Skill(title: "Skills", underline: 60, bodyText: "< Swipe to learn more")
        
        let UIDesign = Skill(title: "UI Design", underline: 92, bodyText: "Powder pie bear claw jelly beans pudding chocolate cotton candy gingerbread. Topping cookie lemon drops sweet roll chocolate candy carrot cake sweet. Chupa chups jujubes chocolate fruitcake pastry. Jelly gingerbread apple pie bonbon halvah. Chocolate chupa chups cake pudding cheesecake.")
        let Languages = Skill(title: "Languages", underline: 102, bodyText: "Powder pie bear claw jelly beans pudding chocolate cotton candy gingerbread. Topping cookie lemon drops sweet roll chocolate candy carrot cake sweet. Chupa chups jujubes chocolate fruitcake pastry. Jelly gingerbread apple pie bonbon halvah. Chocolate chupa chups cake pudding cheesecake.")
        let mvc = Skill(title: "MVC", underline: 42, bodyText: "Powder pie bear claw jelly beans pudding chocolate cotton candy gingerbread. Topping cookie lemon drops sweet roll chocolate candy carrot cake sweet. Chupa chups jujubes chocolate fruitcake pastry. Jelly gingerbread apple pie bonbon halvah. Chocolate chupa chups cake pudding cheesecake.")
        let networking = Skill(title: "Networking", underline: 106, bodyText: "Powder pie bear claw jelly beans pudding chocolate cotton candy gingerbread. Topping cookie lemon drops sweet roll chocolate candy carrot cake sweet. Chupa chups jujubes chocolate fruitcake pastry. Jelly gingerbread apple pie bonbon halvah. Chocolate chupa chups cake pudding cheesecake.")
        let gcd = Skill(title: "GCD", underline: 42, bodyText: "Powder pie bear claw jelly beans pudding chocolate cotton candy gingerbread. Topping cookie lemon drops sweet roll chocolate candy carrot cake sweet. Chupa chups jujubes chocolate fruitcake pastry. Jelly gingerbread apple pie bonbon halvah. Chocolate chupa chups cake pudding cheesecake.")
        let persistence = Skill(title: "Data Persistence", underline: 152, bodyText: "Powder pie bear claw jelly beans pudding chocolate cotton candy gingerbread. Topping cookie lemon drops sweet roll chocolate candy carrot cake sweet. Chupa chups jujubes chocolate fruitcake pastry. Jelly gingerbread apple pie bonbon halvah. Chocolate chupa chups cake pudding cheesecake.")
        let versioning = Skill(title: "Versioning", underline: 100, bodyText: "Powder pie bear claw jelly beans pudding chocolate cotton candy gingerbread. Topping cookie lemon drops sweet roll chocolate candy carrot cake sweet. Chupa chups jujubes chocolate fruitcake pastry. Jelly gingerbread apple pie bonbon halvah. Chocolate chupa chups cake pudding cheesecake.")
        
        let skillsArray: [Skill] = [skills, UIDesign, Languages, mvc, networking, gcd, persistence, versioning]
        
        return skillsArray
    }
    
}
