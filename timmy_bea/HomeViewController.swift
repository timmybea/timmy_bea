//
//  ViewController.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background_gradient")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let tempID = "tempID"
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    
    let headings: [String] = ["Skills", "Projects", "Education & Work", "About"]
    var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = ColorManager.whiteNavBar()
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel?.textColor = UIColor.white
        titleLabel?.text = "  Skills"
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupBackgroundView()
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }

    func setupBackgroundView() {
        //backgroundImage.frame = UIScreen.main.bounds
        view.addSubview(backgroundImage)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImage)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImage)
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(TemporaryCell.self, forCellWithReuseIdentifier: tempID)
        
        //make collectionview begin beneath the menu bar
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    private func setupNavBarButtons() {
        
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        moreBarButtonItem.tintColor = UIColor.white
        searchBarButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    func handleSearch() {
        print(123)
    }
    
    func handleMore() {
        //show menu with options
     //   settingsLauncher.launchSettings()
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
        let heading = "  \(headings[index])"
        titleLabel?.text = heading
    }

    //MARK: Create cells to correspond with each button in the MenuBar
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tempID, for: indexPath) as! TemporaryCell
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
}

