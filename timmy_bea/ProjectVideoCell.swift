//
//  ProjectVideoCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

var pad: Int = 8

//MARK: Properties and init method
class ProjectVideoCell: UICollectionViewCell {

    static let cellID = "projectVideoCell"
    
    lazy var screenSize: ScreenSize = {
        var screenSize = ScreenSize()
        return screenSize
    }()
    
    
    var project: Project?
    
    private let titleLabel: UILabel = {
        let label = UILabel.createLabelWith(text: "title",
                                            color: UIColor.Theme.customSand.color,
                                            font: UIFont.Theme.header.font)
        label.textAlignment = .left
        return label
    }()
    
    private let completedLabel: UILabel = {
        let label = UILabel.createLabelWith(text: "completed",
                                            color: UIColor.Theme.customSand.color,
                                            font: UIFont.Theme.bodyText.font)
        label.textAlignment = .right
        return label
    }()
    
    private let shortDescLabel: UILabel = UILabel.createLabelWith(text: "short description",
                                                                  color: UIColor.Theme.customSand.color,
                                                                  font: UIFont.Theme.bodyText.font)


    private let thumbnailImageView = CachedImageView()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Theme.customSand.color
        return view
    }()

    private let longDescTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.Theme.customSand.color
        textView.font = UIFont.Theme.bodyText.font
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    lazy var gitHubButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "git_pos")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.Theme.customSand.color
        button.addTarget(self, action: #selector(launchGitHub(sender:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        redrawCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @objc private func launchGitHub(sender: UIButton) {
        if let url = URL(string: (project?.gitHubURL)!) {
            UIApplication.shared.open(url)
        }
    }

}

//MARK: Subview layout
extension ProjectVideoCell {
    
    private func addSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
        
        addSubview(titleLabel)
        addSubview(completedLabel)
        addSubview(separatorView)
        addSubview(thumbnailImageView)
        addSubview(gitHubButton)
    }
    
    func setupCell(for project: Project) {
        self.project = project
        
        titleLabel.text = project.title
        completedLabel.text = project.dateCompleted
        shortDescLabel.text = project.shortDescription
        longDescTextView.text = project.longDescription
        thumbnailImageView.loadImage(from: project.videoThumbnailName, with: nil) {
            self.layoutIfNeeded()
        }
        self.redrawCell()
    }
    
    private func redrawCell() {
        
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        screenSize.width = isPortrait ? self.bounds.size.width - (CGFloat.pad * 2) : (self.bounds.size.width - (CGFloat.pad * 2)) / 2
        layoutSubviews(for: isPortrait)
    }

    
    private func layoutSubviews(for isPortrait: Bool) {
        if isPortrait {
            layoutTitleLabel(for: isPortrait)
            layoutCompletedLabel()
            layoutThumbnail(for: isPortrait)
        } else {
            layoutThumbnail(for: isPortrait)
            layoutTitleLabel(for: isPortrait)
            layoutCompletedLabel()
        }
        layoutSeparator()
        layoutButton()
        layoutDescription(for: isPortrait)
    }

    private func getLabelWidth() -> CGFloat {
        return (screenSize.width - (CGFloat.pad * 2.0)) / 2.0
    }

    private func layoutTitleLabel(for isPortrait: Bool) {
        let x = isPortrait ? CGFloat.pad : thumbnailImageView.frame.maxX + CGFloat.pad
        titleLabel.frame = CGRect(x: x, y: 0, width: getLabelWidth(), height: type(of: self).titleHeight)
    }
    
    private func layoutCompletedLabel() {
        let width = getLabelWidth()
        let x = self.bounds.width - width - CGFloat.pad
        completedLabel.frame = CGRect(x: x, y: 0, width: width, height: type(of: self).titleHeight)
    }
    
    private func layoutThumbnail(for isPortrait: Bool) {
        thumbnailImageView.backgroundColor = UIColor.lightGray
        thumbnailImageView.contentMode = .scaleAspectFill
        let y = isPortrait ? titleLabel.frame.maxY + CGFloat.pad : 0
        thumbnailImageView.frame = CGRect(x: CGFloat.pad, y: y, width: screenSize.width, height: screenSize.height)
    }
    
    private func layoutSeparator() {
        let height = type(of: self).separatorHeight
        separatorView.frame = CGRect(x: CGFloat.pad,
                                     y: self.bounds.height - height,
                                     width: self.bounds.width - (2 * CGFloat.pad),
                                     height: height)
    }
    
    private func layoutButton() {
        let dimension = type(of: self).buttonHeight
        let x = self.bounds.width - CGFloat.pad - dimension
        let y = self.bounds.height - separatorView.frame.height - CGFloat.pad - dimension
        gitHubButton.frame = CGRect(x: x, y: y, width: dimension, height: dimension)
    }
    
    private func layoutDescription(for isPortrait: Bool) {
        if isPortrait {
            longDescTextView.removeFromSuperview()
            addSubview(shortDescLabel)
            let y = thumbnailImageView.frame.maxY + 4.0
            shortDescLabel.frame = CGRect(x: CGFloat.pad, y: y, width: self.screenSize.width, height: type(of: self).descriptionHeight)
        } else {
            addSubview(longDescTextView)
            shortDescLabel.removeFromSuperview()
            let x = titleLabel.frame.origin.x
            let y = titleLabel.frame.maxY + CGFloat.pad
            let height = self.bounds.height - y - gitHubButton.frame.height - CGFloat.pad - separatorView.frame.height
            longDescTextView.frame = CGRect(x: x, y: y, width: screenSize.width, height: height)
        }
    }
}

extension ProjectVideoCell {
    
    static private let titleHeight: CGFloat = 20.0
    static private let descriptionHeight: CGFloat = 24.0
    static private let buttonHeight: CGFloat = 30.0
    static private let separatorHeight: CGFloat = 2
    
    static var portraitStaticUIHeight: CGFloat {
        return (3 * CGFloat.pad) + titleHeight + descriptionHeight + buttonHeight + separatorHeight + 4.0
    }
    
}

//MARK: Screen Size
struct ScreenSize {
    
    var width: CGFloat {
        set {
            height =  newValue * 0.5625
        } get {
            return height * 1.7777
        }
    }
    
    var height: CGFloat = 100.0
}
