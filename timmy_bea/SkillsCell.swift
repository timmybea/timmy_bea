//
//  SkillsCollectionViewCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import Lottie

class SkillsCell: CustomCollectionViewCell, UIScrollViewDelegate {
    
    private let animationView: LOTAnimationView = {
        let view = LOTAnimationView.animationNamed("skills_v29")
        view?.backgroundColor = UIColor.clear
        view?.loopAnimation = true
        view?.contentMode = .scaleAspectFill
        return view!
    }()
    
    private var screenSize = ScreenSize()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.isPagingEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.activityView.addSubview(animationView)
        positionAnimationView()
        
        setupScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func positionAnimationView() {
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            screenSize.width = Int(activityView.bounds.width)
            
            animationView.frame = CGRect(x: 0, y: 20, width: screenSize.width, height: screenSize.height)
        } else {
            screenSize.width = Int(activityView.bounds.width * 0.44)
            let positionY: Int = (Int(activityView.bounds.height) - screenSize.height) / 2
            animationView.frame = CGRect(x: 0, y: positionY, width: screenSize.width, height: screenSize.height)
        }
    }
    
    override func redrawCell() {
        super.redrawCell()
        
        positionAnimationView()
        positionScrollView()
    }
    
    private func setupScrollView() {
        activityView.addSubview(scrollView)
        scrollView.delegate = self
        positionScrollView()
    }
    
    private func positionScrollView() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            scrollView.frame = self.activityView.bounds
        } else {
            let width = Int(self.activityView.bounds.width) - screenSize.width
            scrollView.frame = CGRect(x: screenSize.width, y: 0, width: width, height: Int(activityView.bounds.height))
        }
        setupScrollViewContents()
    }
    
    private func setupScrollViewContents() {
        
        for subview in scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 8, height: scrollView.frame.height)
        
        let skillsArray = Skill.skillDataArray()
        
        var space: CGFloat = 20
        
        if Device.isSize(height: .Inches_4) {
            space = 16
        }
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            
            for (i, skill) in skillsArray.enumerated() {
                
                let label = createTitleLabel()
                label.frame = CGRect(x: scrollView.center.x + (CGFloat(i) * scrollView.frame.width) - CGFloat(130), y: scrollView.frame.height * CGFloat(0.45), width: 260, height: 50)
                label.text = skill.title
                
                let underline = UIView(frame: CGRect(x: 0, y: 0, width: skill.underline, height: 2))
                underline.backgroundColor = ColorManager.customSand()
                underline.center.x = label.center.x
                


                underline.center.y = label.center.y + space
                
                let textView = createTextView()
                textView.frame = CGRect(x: (CGFloat(i) * scrollView.frame.width) + 12, y: underline.center.y, width: scrollView.bounds.width - 24, height: 240)
                textView.text = skill.bodyText
                
                if i == 0 {
                    textView.textAlignment = .center
                    textView.font = FontManager.AvenirNextMedium(size: FontManager.sizeSubHeader)
                }
                
                scrollView.addSubview(label)
                scrollView.addSubview(underline)
                scrollView.addSubview(textView)
            }
        } else {
            
            for (i, skill) in skillsArray.enumerated() {
                
                let label = createTitleLabel()
                
                let labelX = Int(scrollView.frame.width / 2 + (CGFloat(i) * scrollView.frame.width) - 130)
                label.frame = CGRect(x: labelX, y: 8, width: 260, height: 22)
                label.text = skill.title

                let underline = UIView(frame: CGRect(x: 0, y: 0, width: skill.underline, height: 2))
                underline.backgroundColor = ColorManager.customSand()
                underline.center.x = label.center.x
                underline.center.y = label.center.y + space

                let textView = createTextView()
                textView.frame = CGRect(x: (CGFloat(i) * scrollView.frame.width) + 12, y: underline.center.y, width: scrollView.bounds.width - 24, height: 240)
                textView.text = skill.bodyText

                if i == 0 {
                    textView.textAlignment = .center
                    textView.font = FontManager.AvenirNextMedium(size: FontManager.sizeSubHeader)
                }
                
                scrollView.addSubview(label)
                scrollView.addSubview(underline)
                scrollView.addSubview(textView)
            }
        }
        scrollToCorrectPage()
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = FontManager.AvenirNextDBold(size: FontManager.sizeHeader)
        label.textColor = ColorManager.customSand()
        label.textAlignment = .center
        return label
    }
    
    private func createTextView() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .justified
        textView.textColor = ColorManager.customSand()
        textView.font = FontManager.AvenirNextMedium(size: FontManager.sizeSubHeader)
        textView.isEditable = false
        return textView
    }
    
    private var pageTracker: Int = 0
    
    private func scrollToCorrectPage() {
        let x: CGFloat = CGFloat(pageTracker) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let progress = scrollView.contentOffset.x / scrollView.contentSize.width
        pageTracker = Int(scrollView.contentOffset.x / scrollView.frame.width)
        animationView.animationProgress = progress
    }
}
