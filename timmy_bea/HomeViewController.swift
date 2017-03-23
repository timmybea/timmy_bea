//
//  ViewController.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

enum cellID: String {
    case skills, projects, education_work, about
}


class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background_gradient")
        view.contentMode = .scaleAspectFill
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
        //titleLabel.backgroundColor = UIColor.red
        titleLabel.text = "    Skills"
        titleLabel.font = FontManager.AvenirNextRegular(size: 23)
        return titleLabel
        
    }()
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Tim Beals • iOS Developer"
        label.textColor = ColorManager.customPeach()
        label.font = FontManager.AvenirNextRegular(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = ColorManager.whiteNavBar()
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60, height: 100)
        navigationItem.titleView = titleLabel
        
        setupBackgroundView()
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }

    func setupBackgroundView() {
        view.addSubview(backgroundImage)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImage)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImage)
        view.sendSubview(toBack: backgroundImage)
        
        view.addSubview(footerLabel)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: footerLabel)
        view.addConstraintsWithFormat(format: "V:[v0]-12-|", views: footerLabel)
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isScrollEnabled = false
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(SkillsCell.self, forCellWithReuseIdentifier: cellID.skills.rawValue)
        
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

    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        let navHeight = (navigationController?.navigationBar.frame.height)! + CGFloat(20.0)
        menuBar.frame = CGRect(x: 0, y: navHeight, width: view.frame.width, height: 50)
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

       // let colors = [UIColor.red, UIColor.green, UIColor.cyan, UIColor.blue]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.skills.rawValue, for: indexPath) as! SkillsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let navHeight = (navigationController?.navigationBar.frame.height)! + CGFloat(20.0)
        let menuBarHeight: CGFloat = menuBar.frame.height
        let footer: CGFloat = 40.0
        return CGSize(width: view.frame.width, height: view.frame.height - navHeight - menuBarHeight - footer)
    }
}

