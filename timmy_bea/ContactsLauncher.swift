//
//  SettingLauncher.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-03.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//MARK: Contacts Launcher Delegate
protocol ContactsLauncherDelegate {
    func pushToContact(contact: ContactOption)
}

class ContactsLauncher: NSObject {
    
    //MARK: UI Properties
    private let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    //MARK: Non-UI Properties
    var isContactsLaunched = false
    
    var delegate: ContactsLauncherDelegate?
    
    private let cellHeight: CGFloat = 45
    
    private let contactsArray: [ContactOption] = ContactOption.allContactOptions()
    
    //MARK: Singleton setup
    static let shared = ContactsLauncher()
    
    override private init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContactsCell.self, forCellWithReuseIdentifier: ContactsCell.cellId)
    }
    
}

//MARK: Handle Launching
extension ContactsLauncher {
    
    func launchContacts() {
        //Animate black transparent view to cover entire window.
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(contactsArray.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissNoSetting)))
            isContactsLaunched = true
        }
        
    }
    
    //MARK: Delegate method for device orientation change
    func redrawContacts(withSize: CGSize) {
        if isContactsLaunched {
            if let window = UIApplication.shared.keyWindow {
                let height: CGFloat = CGFloat(contactsArray.count) * cellHeight
                let y = window.bounds.width - height
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.bounds.height, height: height)
                
                self.blackView.frame = CGRect(x: 0, y: 0, width: window.bounds.height, height: window.bounds.width)
            }
            
            collectionView.collectionViewLayout.invalidateLayout()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

//MARK: Handle Selection and Dismissal
extension ContactsLauncher {
    @objc private func dismissNoSetting() {
        handleSelection(contactOption: ContactOption.cancel)
    }
    
    private func handleSelection(contactOption: ContactOption) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
            }
        }) { (completed: Bool) in
            if contactOption != ContactOption.cancel{
                self.delegate?.pushToContact(contact: contactOption)
            }
        }
        isContactsLaunched = false
    }
}

//MARK: CollectionView delegate methods
extension ContactsLauncher : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contactsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contactOption = contactsArray[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactsCell.cellId, for: indexPath) as! ContactsCell
        cell.contactOption = contactOption
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contactOption = contactsArray[indexPath.item]
        handleSelection(contactOption: contactOption)
    }

}
