//
//  SettingLauncher.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-03.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class Contact: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case email = "Email"
    case linkedIn = "LinkedIn"
    case github = "GitHub"
    case cancel = "Cancel"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeViewController?
    
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 45
    
    let settingsArray: [Contact] = [Contact(name: .email, imageName: "contact_email"), Contact(name: .linkedIn, imageName: "contact_linkedIn"), Contact(name: .github, imageName: "contact_git"), Contact(name: .cancel, imageName: "contact_cancel")]

    
    func launchSettings() {
        //Animate black transparent view to cover entire window.
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settingsArray.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissNoSetting)))
        }
    }
    
    func dismissNoSetting() {
        handleDismiss(contact: settingsArray[3])
    }
    
    func handleDismiss(contact: Contact) {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
            }
        }) { (completed: Bool) in
            if contact.name != .cancel {
                self.homeController?.pushToSettingsController(contact: contact)
            }
        }
    }
    
    //MARK: CollectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.settingsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contact: Contact = settingsArray[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        cell.contact = contact
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contact = settingsArray[indexPath.item]
        
        handleDismiss(contact: contact)
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
