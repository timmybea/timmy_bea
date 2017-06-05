//
//  SettingLauncher.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-04-03.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class Contact: NSObject {
    let name: ContactName
    let imageName: String
    
    init(name: ContactName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum ContactName: String {
    case mobile = "Mobile"
    case email = "Email"
    case linkedIn = "LinkedIn"
    case github = "GitHub"
    case cancel = "Cancel"
}

class ContactsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var isContactsLaunched = false
    
    var homeController: HomeViewController?
    
    private let blackView = UIView()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    private let cellId = "cellId"
    private let cellHeight: CGFloat = 45
    
    private let contactsArray: [Contact] = [Contact(name: .mobile, imageName: "phone"), Contact(name: .email, imageName: "contact_email"), Contact(name: .linkedIn, imageName: "contact_linkedIn"), Contact(name: .github, imageName: "contact_git"), Contact(name: .cancel, imageName: "contact_cancel")]

    
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
    
    @objc private func dismissNoSetting() {
        handleDismiss(contact: contactsArray[3])
    }
    
    private func handleDismiss(contact: Contact) {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
            }
        }) { (completed: Bool) in
            if contact.name != .cancel {
                
                self.homeController?.pushToContact(contact: contact)
            }
        }
        isContactsLaunched = false
    }
    
    //MARK: CollectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contactsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contact: Contact = contactsArray[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactsCell
        
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
        let contact = contactsArray[indexPath.item]
        
        handleDismiss(contact: contact)
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContactsCell.self, forCellWithReuseIdentifier: cellId)
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
