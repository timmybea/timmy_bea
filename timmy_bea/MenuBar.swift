//
//  MenuBar.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let iconNames = ["skills", "projects", "education", "about"]
    
    var homeViewController: HomeViewController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.whiteNavBar()
        return view
    }()
    
    var cvWidth: CGFloat = 0.0
    
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
            addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        }
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "menuCell")
        
        //select the first tab when the vc loads
        let selectedPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedPath, animated: false, scrollPosition: .centeredHorizontally)
        
        setupHorizontalView()
    }
    
    var horizontalViewLeftAnchor: NSLayoutConstraint?
    
    func setupHorizontalView() {
        let horizontalView = UIView()
        horizontalView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalView)
        
        horizontalViewLeftAnchor = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalViewLeftAnchor?.isActive = true
        horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1/4).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        //withRenderingMode sets the image to its dark red tint color
        let name = self.iconNames[indexPath.item]
        cell.imageView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = ColorManager.customDarkBlue()
        return cell
    }
    
    //MARK: animate the sliding horizontal view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //change the collectionview cell in Home Controller with the menubar buttons
        homeViewController?.scrollToItemAt(index: indexPath.item)
    }
    
    //MARK: FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cvWidth / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}
