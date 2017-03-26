//
//  ProjectsCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ProjectsCell: CustomCollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    var projectDataSource = [Project]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: self.activityView.bounds, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let projectVideoCellID = "projectVideoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCollectionView()
    }
    

    private func setupCollectionView() {
        activityView.addSubview(collectionView)
        collectionView.register(ProjectVideoCell.self, forCellWithReuseIdentifier: projectVideoCellID)
        
        projectDataSource = Project.getProjectArray()
    }
    
    //MARK: CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectDataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectVideoCellID, for: indexPath) as! ProjectVideoCell
        cell.project = projectDataSource[indexPath.item]
        return cell
    }

    //MARK: FlowLayoutDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var screenSize = ScreenSize()
        screenSize.width = Int(self.activityView.bounds.width) - 16
        return CGSize(width: collectionView.frame.width, height: CGFloat(80 + screenSize.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: device orientation change methods
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
//        view.removeConstraints(footerV)
//        view.removeConstraints(footerH)
//        setupMenuBar(withSize: size)
//        
//        setCollectionViewFrame(withSize: size)
//        
//        setTitleLabelPosition(withSize: size)
        
    }
    
    func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        
        DispatchQueue.main.async {
            //self.scrollToItemAt(index: self.pageTracker)
            self.collectionView.reloadData()        }
    }
    
    
}
