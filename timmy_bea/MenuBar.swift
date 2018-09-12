//
//  MenuBar.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

protocol MenuBarDelegate {
    var pageTracker: Int { get set }
    func scrollToItemAt(index: Int)
}

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var cellID = "menuCell"
    
    static var menuBarHeight = 44
        
//    private let iconNames = ["skills", "projects", "education", "about"]
    
    var delegate: MenuBarDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Theme.customWhite.color
        return view
    }()
    
    private var cvWidth: CGFloat = 0.0
    
    private let horizontalView: UIView = {
        let horizontalView = UIView()
        horizontalView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalView
    }()
    
    
    //MARK: Factory Method
    static func create(in delegate: MenuBarDelegate) -> MenuBar {
        let menuBar = MenuBar()
        menuBar.delegate = delegate
        return menuBar
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(whiteView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: whiteView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: whiteView)
    
        addSubview(collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        if UIDevice.current.orientation.isLandscape {
            cvWidth = UIScreen.main.bounds.height
            addConstraintsWithFormat(format: "H:|[v0(\(cvWidth))]", views: collectionView)
        } else {
            cvWidth = UIScreen.main.bounds.width
            addConstraintsWithFormat(format: "H:|[v0(\(cvWidth))]", views: collectionView)
        }
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        
        //select the first tab when the vc loads
        let selectedPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedPath, animated: false, scrollPosition: .centeredHorizontally)
        
        addSubview(horizontalView)
        setupHorizontalView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var horizontalViewLeftAnchor: NSLayoutConstraint?
    
    private func setupHorizontalView() {
        horizontalViewLeftAnchor = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalViewLeftAnchor?.isActive = true
        horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1/4).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }

    //MARK: Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.imageView.image = NavigationItem.orderedItems()[indexPath.row].iconImage.withRenderingMode(.alwaysTemplate)
//        cell.tintColor = UIColor.Theme.customDarkBlue.color
        return cell
    }
    
    //MARK: homeViewController scrolls to correct cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.scrollToItemAt(index: indexPath.item)
    }
    
    //MARK: FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cvWidth / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
