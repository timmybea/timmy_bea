//
//  ProjectsCell.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ProjectsCell: CustomCollectionViewCell {
 
    lazy var videoLauncher: VideoLauncher = {
        let launcher = VideoLauncher()
        return launcher
    }()
    
    private var projectDataSource = [Project]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView: UICollectionView = UICollectionView.defaultCollectionView(in: self, with: .vertical)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCollectionView()
        
        projectDataSource = Project.projectData
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func redrawCell() {
        super.redrawCell()
        
        
        setCollectionViewFrame()
        layoutAndReloadData()
        
        if videoLauncher.isVideoLaunched {
            videoLauncher.redrawVideoScreen()
        }
    }
    
    private func setupCollectionView() {
        blueView.addSubview(collectionView)
        collectionView.register(ProjectVideoCell.self, forCellWithReuseIdentifier: ProjectVideoCell.cellID)
        
        setCollectionViewFrame()
    }
    
    private func setCollectionViewFrame() {
        collectionView.frame.size = self.blueView.bounds.size
    }
    
    func layoutAndReloadData() {
        collectionView.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: CollectionView delegate and datasource
extension ProjectsCell : UICollectionViewDelegateAndDatasource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectVideoCell.cellID, for: indexPath) as! ProjectVideoCell
        let project = projectDataSource[indexPath.item]
        cell.setupCell(for: project)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        videoLauncher.launchVideo(withProject: projectDataSource[indexPath.item])
    }
    
}

//MARK: FlowLayoutDelegate
extension ProjectsCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        var screenSize = ScreenSize()
        screenSize.width = isPortrait ? self.blueView.bounds.width - (CGFloat.pad * 2) : (self.blueView.bounds.width - (CGFloat.pad * 2)) / 2
        let height =  isPortrait ? ProjectVideoCell.portraitStaticUIHeight + screenSize.height : screenSize.height + CGFloat.pad + 2
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: CGFloat.pad)
    }

}

//MARK: HomeViewControllerDelegate
extension ProjectsCell : HomeViewControllerDelegate {
    
    func viewControllerDidChangeOrientation() {
        layoutAndReloadData()
    }
    
}
