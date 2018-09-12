//
//  ProjectsCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ProjectsCell: CustomCollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeViewControllerDelegate {
 
    lazy var videoLauncher: VideoLauncher = {
        let launcher = VideoLauncher()
        return launcher
    }()
    
    private var projectDataSource = [Project]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let projectVideoCellID = "projectVideoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCollectionView()
    }

    private func setupCollectionView() {
        blueView.addSubview(collectionView)
        collectionView.register(ProjectVideoCell.self, forCellWithReuseIdentifier: projectVideoCellID)
        projectDataSource = Project.getProjectArray()
        
        setCVFrame()
    }
    
    override func redrawCell() {
        super.redrawCell()
        setCVFrame()
        
        viewControllerDidChangeOrientation()
        
        if videoLauncher.isVideoLaunched {
            videoLauncher.redrawVideoScreen()
        }
    }
    
    private func setCVFrame() {
        collectionView.frame.size = self.blueView.bounds.size
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
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            screenSize.width = Int(self.blueView.bounds.width) - 16
            let height  = 20 + pad + screenSize.height + pad + 24 + 30 + pad + 2
            return CGSize(width: collectionView.frame.width, height: CGFloat(height))
        } else {
            screenSize.width = Int((self.blueView.bounds.width - 16) / 2)
            return CGSize(width: collectionView.frame.width, height: CGFloat(screenSize.height + 10))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        videoLauncher.launchVideo(withProject: projectDataSource[indexPath.item])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: device orientation change methods
    func viewControllerDidChangeOrientation() {
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
