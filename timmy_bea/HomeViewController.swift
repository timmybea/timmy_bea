//
//  ViewController.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import MessageUI

enum CellID: String {
    case skills, projects, education_work, about
}

protocol HomeViewControllerDelegate {
    func viewControllerDidChangeOrientation()
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {

    private var backgroundImage: UIImageView = {
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
    
    private let headings: [String] = ["Skills", "Projects", "Education & Work", "About"]
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Skills"
        titleLabel.font = UIFont.Theme.navText.font
        return titleLabel
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Tim Beals • iOS Developer"
        label.font = UIFont.Theme.subHeader.font
        return label
    }()
    
    private var footerH = [NSLayoutConstraint]()
    private var footerV = [NSLayoutConstraint]()
    
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
    
    private var navPortraitHeight: CGFloat = 44
    private var navLandscapeHeight: CGFloat = 44
    
    private var menuHeight: CGFloat {
        return menuBar.frame.height
    }
    
    var homeViewControllerDelegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Device.isSizeOrSmaller(height: .Inches_4_7) {
          navLandscapeHeight = 32
        }

        view.addSubview(menuBar)
        view.addSubview(footerLabel)
    
        setupBackgroundView()
        setupNavBar()
        setupMenuBar(withSize: CGSize(width: view.bounds.width, height: view.bounds.height))
        setupCollectionView()
    }

    private func setupBackgroundView() {
        view.addSubview(backgroundImage)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImage)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImage)
        view.sendSubview(toBack: backgroundImage)
    }
    
    private func setupCollectionView() {
        
        collectionView.register(SkillsCell.self, forCellWithReuseIdentifier: CellID.skills.rawValue)
        collectionView.register(ProjectsCell.self, forCellWithReuseIdentifier: CellID.projects.rawValue)
        collectionView.register(EducationCell.self, forCellWithReuseIdentifier: CellID.education_work.rawValue)
        collectionView.register(AboutCell.self, forCellWithReuseIdentifier: CellID.about.rawValue)

        view.insertSubview(collectionView, belowSubview: menuBar)
        setCollectionViewFrame(withSize: view.frame.size)
    }
    
    //MARK: set frame of collectionView for orientation
    private func setCollectionViewFrame(withSize size: CGSize) {
        if UIDevice.current.orientation.isPortrait {
            collectionView.frame = CGRect(x: 0, y: menuHeight + navPortraitHeight + 20, width: size.width, height: size.height - menuHeight - navPortraitHeight - 20)
        } else {
            collectionView.frame = CGRect(x: 0, y: menuHeight + navLandscapeHeight, width: size.width, height: size.height - menuHeight - navLandscapeHeight)
        }
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.Theme.customWhite.color

        navigationController?.view.addSubview(titleLabel)
        
        setTitleLabelPosition(withSize: view.frame.size)
        
        let contactImage = UIImage(named: "contact")?.withRenderingMode(.alwaysTemplate)
        let contactBarButton = UIBarButtonItem(image: contactImage, style: .plain, target: self, action: #selector(handleContact))
        contactBarButton.tintColor = UIColor.Theme.customDarkBlue.color
        navigationItem.rightBarButtonItems = [contactBarButton]
    }
    
    private func setTitleLabelPosition(withSize size: CGSize) {
        var labelX: CGFloat = -13.0 //half the width of the imageView in the menuBar cell
        var labelY: CGFloat = 10
        
        if UIDevice.current.orientation.isPortrait {
            labelX += size.width / 8
            labelY += 20
        } else {
            labelX += size.height / 8
        }
        
        titleLabel.frame = CGRect(x: labelX, y: labelY, width: 250, height: 25)
    }
    
    //MARK: Contact menu setup
    @objc private func handleContact() {
        contactsLauncher.launchContacts()
    }
    
    lazy var contactsLauncher: ContactsLauncher = {
        let launcher = ContactsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    func pushToContact(contact: Contact) {
        if contact.name == .email {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["tim.beals@gmail.com"])
                mail.setSubject("Message From iOSDeveloper App")
                present(mail, animated: true)
            } else {
                print("Error launching email")
            }
        } else if contact.name == .linkedIn {
            if let url = URL(string: "https://www.linkedin.com/in/tim-beals-a058b218/") {
                UIApplication.shared.open(url)
            }
        } else if contact.name == .github {
            if let url = URL(string: "https://github.com/timmybea") {
                UIApplication.shared.open(url)
            }
        } else if contact.name == .mobile {
            callNumber(phoneNumber: "5148168809")
        }
    }
    
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    //MARK: dismiss email app
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    //MARK: Setup menu bar
    private func setupMenuBar(withSize size: CGSize) {
        var height = navPortraitHeight
        
        if UIDevice.current.orientation.isPortrait {
            height += CGFloat(20.0)
            
            footerLabel.textColor = UIColor.Theme.customPeach.color
            footerLabel.textAlignment = .center
            footerH = NSLayoutConstraint.constraintsWithFormat(format: "H:|[v0]|", views: footerLabel)
            footerV = NSLayoutConstraint.constraintsWithFormat(format: "V:[v0]-8-|", views: footerLabel)
            view.addConstraints(footerH)
            view.addConstraints(footerV)
            
        } else {
            height = navLandscapeHeight
            footerLabel.textColor = UIColor.Theme.customDarkBlue.color
            footerLabel.textAlignment = .right
            footerH = NSLayoutConstraint.constraintsWithFormat(format: "H:[v0]-24-|", views: footerLabel)
            footerV = NSLayoutConstraint.constraintsWithFormat(format: "V:|-60-[v0]", views: footerLabel)
            
            view.addConstraints(footerH)
            view.addConstraints(footerV)
        }
        
        menuBar.frame = CGRect(x: 0, y: height, width: size.width, height: 50)
    }

    private var pageTracker: Int = 0
    
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
    
    private func setTitleFor(index: Int) {
        let heading = "\(headings[index])"
        titleLabel.text = heading
    }

    //MARK: Create cells to correspond with each button in the MenuBar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellIDs: [CellID] = [.skills, .projects, .education_work, .about]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDs[indexPath.row].rawValue, for: indexPath)
        
        if let currentCell = cell as? CustomCollectionViewCell {
            currentCell.redrawCell()
        }

        if let currentCell = cell as? ProjectsCell {
            self.homeViewControllerDelegate = currentCell
        }
        
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
    
    //MARK: orientation change methods
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        view.removeConstraints(footerV)
        view.removeConstraints(footerH)
        setupMenuBar(withSize: size)
        
        setCollectionViewFrame(withSize: size)
        
        setTitleLabelPosition(withSize: size)
        
        if let delegate = self.homeViewControllerDelegate {
            delegate.viewControllerDidChangeOrientation()
        }
        
        if contactsLauncher.isContactsLaunched {
            contactsLauncher.redrawContacts(withSize: size)
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()

        DispatchQueue.main.async {
            self.scrollToItemAt(index: self.pageTracker)
            self.collectionView.reloadData() //fires the dequeue reusable cell method
        }
    }
}
