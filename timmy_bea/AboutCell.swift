//
//  AboutCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit


//MARK: Properties and initializer
class AboutCell: CustomCollectionViewCell {

    private let speechBubble: SpeechBubble = {
        let view = SpeechBubble()
        return view
    }()
    
    private var circleMaskView: CircleMaskView = {
        var circleDiameter = Device.IS_4_INCHES_OR_SMALLER() ? 110 : 140
        return CircleMaskView(frame: CGRect(x: 0, y: 0, width: circleDiameter, height: circleDiameter))
    }()
    
    private var aboutInfo: [About] = About.aboutData
    
    private var currentInfoIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        blueView.addSubview(circleMaskView)
        circleMaskView.circleMaskViewDelegate = self
        blueView.addSubview(speechBubble)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func redrawCell() {
        super.redrawCell()

        layoutViews()
    }
}

//MARK: Layout methods
extension AboutCell {
    private func incrementInfoIndex() {
        currentInfoIndex = (currentInfoIndex < aboutInfo.count - 1) ? currentInfoIndex + 1 : 1
    }
    
    private func layoutViews() {
        
        speechBubble.displayText = aboutInfo[currentInfoIndex].text
        let isPortrait = UIApplication.shared.statusBarOrientation == .portrait
        
        let circleMaskX = isPortrait ? (blueView.frame.width / 3) - (circleMaskView.frame.width / 2) : CGFloat.pad
        let circleMaskY = isPortrait ? blueView.bounds.height - circleMaskView.frame.height - CGFloat.pad : CGFloat.pad
        circleMaskView.frame.origin = CGPoint(x: circleMaskX, y: circleMaskY)
        
        let speechX = isPortrait ? CGFloat.pad : (CGFloat.pad * 2) + circleMaskView.frame.width
        let speechHeight = isPortrait ? blueView.bounds.height - circleMaskView.frame.height - (CGFloat.pad * 3) : blueView.bounds.height - (CGFloat.pad * 2)
        speechBubble.frame = CGRect(x: speechX, y: CGFloat.pad, width: blueView.bounds.width - speechX - CGFloat.pad, height: speechHeight)


        let origin = isPortrait ? CGPoint(x: circleMaskX + circleMaskView.frame.width - 12, y: speechBubble.frame.height) : CGPoint(x: 0, y: circleMaskView.frame.height - 12)
        speechBubble.setupTailLayer(origin: origin, portrait: isPortrait)

    }
}

//MARK: Circle mask view delegate method
extension AboutCell : CircleMaskViewDelegate {
    
    internal func viewWasTouched() {
        incrementInfoIndex()
        speechBubble.displayText = self.aboutInfo[currentInfoIndex].text
        speechBubble.animateBubbleChange()
    }
}
