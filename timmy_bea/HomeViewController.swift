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

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

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
        titleLabel.textColor = UIColor.white
        titleLabel.text = "    Skills"
        titleLabel.font = FontManager.AvenirNextRegular(size: 23)
        return titleLabel
        
    }()
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Tim Beals • iOS Developer"
        //label.textColor = ColorManager.customPeach()
        label.font = FontManager.AvenirNextRegular(size: 16)
        //label.textAlignment = .center
        return label
    }()
    var footerH = [NSLayoutConstraint]()
    var footerV = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = ColorManager.whiteNavBar()
        
        view.addSubview(menuBar)
        view.addSubview(footerLabel)
        
        
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60, height: 100)
        navigationItem.titleView = titleLabel
        
        setupBackgroundView()
        setupCollectionView()
        setupMenuBar(withSize: CGSize(width: view.bounds.width, height: view.bounds.height))
        setupNavBarButtons()
    }

    func setupBackgroundView() {
        view.addSubview(backgroundImage)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImage)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImage)
        view.sendSubview(toBack: backgroundImage)
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isScrollEnabled = false
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = UIColor.clear
        
        collectionView?.register(SkillsCell.self, forCellWithReuseIdentifier: CellID.skills.rawValue)
        collectionView?.register(ProjectsCell.self, forCellWithReuseIdentifier: CellID.projects.rawValue)
        collectionView?.register(EducationCell.self, forCellWithReuseIdentifier: CellID.education_work.rawValue)
        collectionView?.register(AboutCell.self, forCellWithReuseIdentifier: CellID.about.rawValue)

        //make collectionview begin beneath the menu bar
        
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    private func setupNavBarButtons() {
        
        let contactImage = UIImage(named: "contact")?.withRenderingMode(.alwaysTemplate)
        
        let contactBarButton = UIBarButtonItem(image: contactImage, style: .plain, target: self, action: #selector(handleContact))
        
        
        contactBarButton.tintColor = ColorManager.customDarkBlue()
        navigationItem.rightBarButtonItems = [contactBarButton]
    }
    
    func handleContact() {
        print(123)
    }

    
    private func setupMenuBar(withSize size: CGSize) {
        var navHeight: CGFloat = (navigationController?.navigationBar.frame.height)!
        
        if UIDevice.current.orientation.isPortrait {
            navHeight += 20.0
            
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
        
        menuBar.frame = CGRect(x: 0, y: navHeight, width: size.width, height: 50)
        
    }

    func scrollToItemAt(index: Int) {
        let indexPath: NSIndexPath = NSIndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleFor(index: index)
    }
    
    //MARK: use the content offset of the collection view to move the white horizontal view of the menu bar
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        let index = scrollView.contentOffset.x / 4
        menuBar.horizontalViewLeftAnchor?.constant = index
    }
    
    
    //MARK: Use scrollview method to highlight the apporopriate button in the menubar
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let item: Int = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath: IndexPath = IndexPath(item: item, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        setTitleFor(index: item)
    }
    
    func setTitleFor(index: Int) {
        let heading = "    \(headings[index])"
        titleLabel.text = heading
    }

    //MARK: Create cells to correspond with each button in the MenuBar
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellIDs: [CellID] = [.skills, .projects, .education_work, .about]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDs[indexPath.row].rawValue, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let navHeight = (navigationController?.navigationBar.frame.height)! + CGFloat(20.0)
        let menuBarHeight: CGFloat = menuBar.frame.height
        let footer: CGFloat = 40.0
        return CGSize(width: view.frame.width, height: view.frame.height - navHeight - menuBarHeight - footer)
    }
    
    //MARK: turn off autorotate
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
//    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//        collectionView?.collectionViewLayout.invalidateLayout()
//        menuBar.collectionView.collectionViewLayout.invalidateLayout()
//        self.view.setNeedsDisplay()
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        view.removeConstraints(footerV)
        view.removeConstraints(footerH)
        self.setupMenuBar(withSize: size)
    }
    
}

