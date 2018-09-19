//
//  AboutCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

var currentInfoIndex = 0

class AboutCell: CustomCollectionViewCell, CircleMaskViewDelegate {

    private let speechBubble: SpeechBubble = {
        let view = SpeechBubble()
        return view
    }()
    
    private var circleMaskView: CircleMaskView = {
        var circleDiameter = 140
        if Device.isSize(height: .Inches_4) {
            circleDiameter = 110
        }
        let view = CircleMaskView(frame: CGRect(x: 0, y: 0, width: circleDiameter, height: circleDiameter))
        return view
    }()
    
    private var aboutInfo: [About] = About.aboutData
    
    private func incrementInfoIndex() {
        currentInfoIndex = (currentInfoIndex < aboutInfo.count - 1) ? currentInfoIndex + 1 : 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        blueView.addSubview(circleMaskView)
        
        circleMaskView.circleMaskViewDelegate = self
        
        blueView.addSubview(speechBubble)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
    
        speechBubble.displayText = aboutInfo[currentInfoIndex].text
        
        if UIApplication.shared.statusBarOrientation == .portrait {
            let circleMaskX = (blueView.frame.width / 3) - (circleMaskView.frame.width / 2)
            let circleMaskY = blueView.bounds.height - circleMaskView.frame.height - CGFloat(pad)
            circleMaskView.frame.origin = CGPoint(x: circleMaskX, y: circleMaskY)
            
            speechBubble.frame = CGRect(x: pad, y: pad, width: Int(blueView.bounds.width) - (2 * pad), height: Int(blueView.bounds.height - circleMaskView.frame.height) - (3 * pad))
            
            let origin = CGPoint(x: circleMaskX + circleMaskView.frame.width - 12, y: speechBubble.frame.height)
            speechBubble.setupTailLayer(origin: origin, portrait: true)
            
        } else {
            
            circleMaskView.frame.origin = CGPoint(x: pad, y: pad)
            
            let speechBubbleX: CGFloat = CGFloat(2 * pad) + circleMaskView.frame.width
            speechBubble.frame = CGRect(x: speechBubbleX, y: CGFloat(pad), width: blueView.bounds.width - speechBubbleX - CGFloat(pad), height: blueView.bounds.height - CGFloat(2 * pad))
            
            
            let origin = CGPoint(x: 0, y: circleMaskView.frame.height - 12)
            speechBubble.setupTailLayer(origin: origin, portrait: false)
        }
    }
    
    override func redrawCell() {
        super.redrawCell()
        
        layoutViews()
    }
    
    //MARK: Circle mask view delegate method
    internal func viewWasTouched() {
        incrementInfoIndex()
        speechBubble.displayText = self.aboutInfo[currentInfoIndex].text
        speechBubble.animateBubbleChange()
    }
}
