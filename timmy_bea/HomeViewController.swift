//
//  ViewController.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

enum CellID: String {
    case skills, projects, education_work, about
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background_gradient")
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    
    let headings: [String] = ["Skills", "Projects", "Education & Work", "About"]
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.red
        titleLabel.text = "    Skills"
        titleLabel.font = FontManager.AvenirNextRegular(size: 23)
        return titleLabel
    }()
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Tim Beals • iOS Developer"
        label.font = FontManager.AvenirNextRegular(size: 16)
        return label
    }()
    
    var footerH = [NSLayoutConstraint]()
    var footerV = [NSLayoutConstraint]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.isScrollEnabled = false
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var navHeight: CGFloat {
        return (navigationController?.navigationBar.frame.height)!
    }
    
    var menuHeight: CGFloat {
        return menuBar.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(menuBar)
        view.addSubview(footerLabel)
    
        setupBackgroundView()
        setupMenuBar(withSize: CGSize(width: view.bounds.width, height: view.bounds.height))
        setupCollectionView()
        setupNavBar()
    }

    func setupBackgroundView() {
        view.addSubview(backgroundImage)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImage)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImage)
        view.sendSubview(toBack: backgroundImage)
    }
    
    func setupCollectionView() {
        
        collectionView.register(SkillsCell.self, forCellWithReuseIdentifier: CellID.skills.rawValue)
        collectionView.register(ProjectsCell.self, forCellWithReuseIdentifier: CellID.projects.rawValue)
        collectionView.register(EducationCell.self, forCellWithReuseIdentifier: CellID.education_work.rawValue)
        collectionView.register(AboutCell.self, forCellWithReuseIdentifier: CellID.about.rawValue)
        collectionView.register(testCell.self, forCellWithReuseIdentifier: "test")


        view.insertSubview(collectionView, belowSubview: menuBar)
        setCollectionViewFrame(withSize: view.frame.size)
    }
    
    //MARK: set frame of collectionView for orientation
    func setCollectionViewFrame(withSize size: CGSize) {
        if UIDevice.current.orientation.isPortrait {
            collectionView.frame = CGRect(x: 0, y: menuHeight + navHeight + 20, width: size.width, height: size.height)
        } else {
            collectionView.frame = CGRect(x: 0, y: menuHeight + navHeight, width: size.width, height: size.height)
        }
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.backgroundColor = ColorManager.whiteNavBar()
        
        navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 25, height: 150)
        navigationItem.titleView?.backgroundColor = UIColor.red
        
        let contactImage = UIImage(named: "contact")?.withRenderingMode(.alwaysTemplate)
        let contactBarButton = UIBarButtonItem(image: contactImage, style: .plain, target: self, action: #selector(handleContact))
        contactBarButton.tintColor = ColorManager.customDarkBlue()
        navigationItem.rightBarButtonItems = [contactBarButton]
    }
    
    func handleContact() {
        print(123)
    }

    
    private func setupMenuBar(withSize size: CGSize) {
        var height = navHeight
        
        if UIDevice.current.orientation.isPortrait {
            height += CGFloat(20.0)
            
            footerLabel.textColor = ColorManager.customPeach()
            footerLabel.textAlignment = .center
            footerH = NSLayoutConstraint.constraintsWithFormat(format: "H:|[v0]|", views: footerLabel)
            footerV = NSLayoutConstraint.constraintsWithFormat(format: "V:[v0]-8-|", views: footerLabel)
            view.addConstraints(footerH)
            view.addConstraints(footerV)
            
        } else {
            footerLabel.textColor = ColorManager.customDarkBlue()
            footerLabel.textAlignment = .right
            footerH = NSLayoutConstraint.constraintsWithFormat(format: "H:[v0]-16-|", views: footerLabel)
            footerV = NSLayoutConstraint.constraintsWithFormat(format: "V:|-60-[v0]", views: footerLabel)
            
            view.addConstraints(footerH)
            view.addConstraints(footerV)
        }
        
        menuBar.frame = CGRect(x: 0, y: height, width: size.width, height: 50)
    }

    var pageTracker: Int = 0
    
    func scrollToItemAt(index: Int) {
        pageTracker = index
        let indexPath: NSIndexPath = NSIndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleFor(index: index)
    }
    
    //MARK: use the content offset of the collection view to move the white horizontal view of the menu bar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / 4
        let multiplier = menuBar.collectionView.frame.width / scrollView.frame.width
        let leftAnchorX = scrollPosition * multiplier
        menuBar.horizontalViewLeftAnchor?.constant = leftAnchorX
    }
    
    func setTitleFor(index: Int) {
        let heading = "    \(headings[index])"
        titleLabel.text = heading
    }

    //MARK: Create cells to correspond with each button in the MenuBar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //let cellIDs: [CellID] = [.skills, .projects, .education_work, .about]
        let cellIDs = ["test", "test", "test", "test"]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDs[indexPath.row], for: indexPath)
        
        let color = [UIColor.yellow, UIColor.brown, UIColor.blue, UIColor.red]
        
        cell.backgroundColor = color[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    //MARK: turn off autorotate
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        view.removeConstraints(footerV)
        view.removeConstraints(footerH)
        setupMenuBar(withSize: size)
        
        setCollectionViewFrame(withSize: size)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()

        DispatchQueue.main.async {
            self.scrollToItemAt(index: self.pageTracker)
        }        
    }
    
    
}

