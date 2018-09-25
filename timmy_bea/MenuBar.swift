//
//  MenuBar.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Menu Bar Delegate
protocol MenuBarDelegate {
    var pageTracker: Int { get set }
    func scrollToItemAt(index: Int)
}

class MenuBar: UIView {
    
    //MARK: UI Properties
    lazy var collectionView: UICollectionView = UICollectionView.defaultCollectionView(in: self, with: .horizontal)
    
    private let horizontalView: UIView = {
        let horizontalView = UIView()
        horizontalView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return horizontalView
    }()
    
    //MARK: Non-UI Properties
    private var cvWidth: CGFloat {
        return min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
    }
    
    private var cellID = "menuCell"
    
    static var menuBarHeight = 44
    
    var delegate: MenuBarDelegate?
    
    var horizontalViewLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutCollectionView()
        layoutHorizontalView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: Factory Method
extension MenuBar {

    static func create(in delegate: MenuBarDelegate) -> MenuBar {
        let menuBar = MenuBar()
        menuBar.delegate = delegate
        return menuBar
    }
    
}

//MARK: Layout Subviews
extension MenuBar {
    
    private func layoutCollectionView() {
        
        self.backgroundColor = UIColor.Theme.customWhite.color
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: self.cvWidth)
            ])
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        
        //select the first tab when the vc loads
        let selectedPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    private func layoutHorizontalView() {
        addSubview(horizontalView)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        horizontalViewLeftAnchor = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalViewLeftAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            horizontalView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1/4),
            horizontalView.heightAnchor.constraint(equalToConstant: 4)
            ])
    }
    
}

//MARK: CollectionView Methods
extension MenuBar : UICollectionViewDelegateAndDatasource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NavigationItem.orderedItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.imageView.image = NavigationItem.orderedItems()[indexPath.row].iconImage.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.scrollToItemAt(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cvWidth / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
