//
//  ProjectsCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ProjectsCell: CustomCollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeViewControllerDelegate {
 
    var projectDataSource = [Project]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        collectionView.register(testCell.self, forCellWithReuseIdentifier: "test")
        projectDataSource = Project.getProjectArray()
        
        setCVFrame()
    }
    
    override func redrawCell() {
        super.redrawCell()
        setCVFrame()
    }
    
    private func setCVFrame() {
        collectionView.frame.size = self.activityView.bounds.size
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
        cell.redrawCell()
        return cell
    }

    //MARK: FlowLayoutDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var screenSize = ScreenSize()
        
        if UIDevice.current.orientation.isPortrait {
            screenSize.width = Int(self.activityView.bounds.width) - 16
            let height  = 20 + pad + screenSize.height + pad + 24 + 30 + pad + 2
            return CGSize(width: collectionView.frame.width, height: CGFloat(height))
        } else {
            screenSize.width = Int((self.activityView.bounds.width - 16) / 2)
            return CGSize(width: collectionView.frame.width, height: CGFloat(screenSize.height + 10))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: device orientation change methods
    
    func invalidateAndRedrawCollectionView() {
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
