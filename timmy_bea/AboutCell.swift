//
//  AboutCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class AboutCell: CustomCollectionViewCell {

    let speechBubble: SpeechBubble = {
        let view = SpeechBubble()
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let size: CGFloat = 140
        let circleMaskX = (activityView.bounds.width / 2) - (size / 2)
        let circleMaskView = CircleMaskView(frame: CGRect(x: circleMaskX, y: activityView.bounds.height - size - CGFloat(pad), width: size, height: size))
        
        activityView.addSubview(circleMaskView)
        

        activityView.addSubview(speechBubble)
        speechBubble.frame = CGRect(x: pad, y: pad, width: Int(activityView.bounds.width) - (2 * pad), height: Int(activityView.bounds.height - circleMaskView.frame.height) - (3 * pad))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
