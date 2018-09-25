//
//  SkillsCollectionViewCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import Lottie

//MARK: Properties
class SkillsCell: CustomCollectionViewCell {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.delegate = self
        return view
    }()
    
    private let animationView: LOTAnimationView = {
        let view = LOTAnimationView(name: "skills_v29")
        view.loopAnimation = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private var screenSize = ScreenSize()
    
    private var pageTracker: Int = 0
    
    
    override func redrawCell() {
        super.redrawCell()
        
        positionAnimationView()
        positionScrollView()
    }
}

//MARK: Public methods
extension SkillsCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        Skill.delegate = self
        
        removeSubviews()
        
        addSubviews()
        positionAnimationView()
        positionScrollView()
    }
    
}

//MARK: UIScrollViewDelegate
extension SkillsCell : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.x / scrollView.contentSize.width
        pageTracker = Int(scrollView.contentOffset.x / scrollView.frame.width)
        animationView.animationProgress = progress
    }
    
}

//MARK: SkillDelegate
extension SkillsCell : SkillDelegate {
    
    func dataReceived() {
        DispatchQueue.main.async {
            self.redrawCell()
        }
    }
}

//MARK: Private methods
extension SkillsCell {

    private func removeSubviews() {
        animationView.removeFromSuperview()
        scrollView.removeFromSuperview()
    }
    
    private func addSubviews() {
        blueView.addSubview(animationView)
        blueView.addSubview(scrollView)
    }
    
    private func positionAnimationView() {
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        screenSize.width = isPortrait ? blueView.bounds.width : blueView.bounds.width * 0.44
        let y: Int = isPortrait ? 20 : (Int(blueView.bounds.height) - Int(screenSize.height)) / 2
        animationView.frame = CGRect(x: 0, y: y, width: Int(screenSize.width), height: Int(screenSize.height))
    }
    
    private func positionScrollView() {
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            scrollView.frame = self.blueView.bounds
        } else {
            let width = Int(self.blueView.bounds.width) - Int(screenSize.width)
            scrollView.frame = CGRect(x: Int(screenSize.width), y: 0, width: width, height: Int(blueView.bounds.height))
        }
        setScrollViewContentSize()
        
        setupScrollViewContents()
    }
    
    private func setupScrollViewContents() {
        removeSubviews(from: scrollView)
        
        
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait

        for (i, skill) in Skill.skillData.enumerated() {
            
            let label = createAndPositionLabel(title: skill.title, index: i, isPortrait: isPortrait)
        
            let underline = UIView.createAndPositionUnderline(beneath: label)
            
            let textView = createTextView(text: skill.bodyText, beneath: underline, index: i)
            
            scrollView.addSubview(label)
            scrollView.addSubview(underline)
            scrollView.addSubview(textView)
        }
        scrollToCorrectPage()
    }
    
    private func removeSubviews(from superview: UIView) {
        for subview in superview.subviews {
            subview.removeFromSuperview()
        }
    }
    
    private func setScrollViewContentSize() {
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 8,
                                        height: scrollView.frame.height)
    }

    private func createAndPositionLabel(title: String, index: Int, isPortrait: Bool) -> UILabel {
        let label = UILabel.createLabelWith(text: title,
                                            color: UIColor.Theme.customSand.color,
                                            font: UIFont.Theme.header.font)
        let width = label.intrinsicContentSize.width
        
        if isPortrait {
            label.frame = CGRect(x: scrollView.center.x + (CGFloat(index) * scrollView.frame.width) - (width / 2),
                                 y: animationView.frame.maxY + CGFloat.pad,
                                 width: width,
                                 height: label.intrinsicContentSize.height)
        } else {
            let labelX = scrollView.frame.width / 2 + (CGFloat(index) * scrollView.frame.width) - (width / 2)
            label.frame = CGRect(x: labelX,
                                 y: CGFloat.pad,
                                 width: width,
                                 height: label.intrinsicContentSize.height)
        }
        return label
    }
    
    private func createTextView(text: String, beneath view: UIView, index: Int) -> UITextView {
        let textView = UITextView.createUneditableTextView(with: text,
                                                           color: UIColor.Theme.customSand.color)
        textView.frame = CGRect(x: (CGFloat(index) * scrollView.frame.width) + 12,
                                y: view.frame.maxY,
                                width: scrollView.bounds.width - 24,
                                height: blueView.frame.height - view.frame.maxY - verticalPad)
        return textView
    }
    
    private func scrollToCorrectPage() {
        let x: CGFloat = CGFloat(pageTracker) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
    }
    
}

