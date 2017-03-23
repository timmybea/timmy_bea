//
//  SkillsCollectionViewCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import Lottie

class SkillsCell: UICollectionViewCell, UIScrollViewDelegate {
    
    let activityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let animationView: LOTAnimationView = {
        let view = LOTAnimationView.animationNamed("skills_v29")
        view?.backgroundColor = UIColor.clear
        view?.loopAnimation = true
        view?.contentMode = .scaleAspectFill
        return view!
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.isPagingEnabled = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        setupBackgroundView()
        setupAnimationView()
        setupScrollView()
        
    }

    func setupBackgroundView() {
        
        addSubview(activityView)
        activityView.frame = CGRect(x: 24, y: 24, width: self.bounds.width - 48, height: self.bounds.height - 24)
        
        
        let blueView = UIView(frame: activityView.bounds)
        activityView.addSubview(blueView)
        blueView.backgroundColor = ColorManager.customDarkBlue()
        blueView.alpha = 0.4
        blueView.layer.cornerRadius = 8
    }

    func setupAnimationView() {
        
        activityView.addSubview(animationView)
        
        //16:9 screen ratio
        let animationHeight = activityView.bounds.width * 0.5625
        animationView.frame = CGRect(x: 0, y: 20, width: activityView.bounds.width, height: animationHeight)
    }
    
    func setupScrollView() {
        activityView.addSubview(scrollView)
        scrollView.frame = activityView.bounds
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 8, height: scrollView.frame.height)
        
        let skillsArray = SkillData.skillDataArray()
        
        for (i, skill) in skillsArray.enumerated() {
            
            //setup title label
            let label = UILabel()
            label.frame = CGRect(x: scrollView.center.x + (CGFloat(i) * scrollView.frame.width) - CGFloat(130), y: scrollView.frame.height * CGFloat(0.45), width: 260, height: 50)
            label.font = FontManager.AvenirNextDBold(size: 20)
            label.textColor = ColorManager.customSand()
            label.text = skill.title
            label.textAlignment = .center

            let underline = UIView(frame: CGRect(x: 0, y: 0, width: skill.underline, height: 2))
            underline.backgroundColor = ColorManager.customSand()
            underline.center.x = label.center.x
            underline.center.y = label.center.y + 20
            
            let textView = UITextView()
            textView.frame = CGRect(x: (CGFloat(i) * scrollView.frame.width) + 12, y: underline.center.y + 8, width: scrollView.bounds.width - 24, height: 240)
            textView.backgroundColor = UIColor.clear
            textView.text = skill.bodyText
            textView.textAlignment = .justified
            textView.textColor = ColorManager.customSand()
            textView.font = FontManager.AvenirNextMedium(size: 16)
            textView.isEditable = false
                        
            if i == 0 {
                textView.textAlignment = .center
                textView.font = FontManager.AvenirNextMedium(size: 18)
            }
            
            scrollView.addSubview(label)
            scrollView.addSubview(underline)
            scrollView.addSubview(textView)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let progress = scrollView.contentOffset.x / scrollView.contentSize.width
        animationView.animationProgress = progress
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
