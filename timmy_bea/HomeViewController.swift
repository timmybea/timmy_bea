//
//  ViewController.swift
//  timmy_bea
//
//  Created by Tim Beals on 2017-03-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import MessageUI


//MARK: HomeViewControllerDelegate
protocol HomeViewControllerDelegate {
    func viewControllerDidChangeOrientation()
}

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {

    //MARK: UI Properties
    private var backgroundImage = UIImageView.createWith(imageName: UIImage.Theme.backgroundGradient.rawValue, contentMode: .scaleAspectFill)
    
    lazy var menuBar: MenuBar = {
        return MenuBar.create(in: self)
    }()
    
    private let headings = NavigationItem.orderedHeadings()
    
    private var titleLabel = UILabel.createLabelWith(text: NavigationItem.skills.heading, color: UIColor.white, font: UIFont.Theme.navText.font)

    private let footerLabel = UILabel.createLabelWith(text: "Tim Beals • iOS Developer", color: UIColor.Theme.customDarkBlue.color, font: UIFont.Theme.subHeader.font)
    
    private var footerHorizontal = [NSLayoutConstraint]()
    
    private var footerVertical = [NSLayoutConstraint]()
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView.horizontalPagingCollectionView(in: self)
    }()
    
    //MARK: Non-UI Properties
    private var navHeight: CGFloat {
        return self.navigationController!.navigationBar.bounds.height
    }
    
    private var menuHeight: CGFloat {
        return menuBar.frame.height
    }
    
    private var statusHeight: CGFloat {
        return UIDevice.current.orientation.isPortrait ? 20.0 : 0.0
    }
    
    var homeViewControllerDelegate: HomeViewControllerDelegate?
    
    var pageTracker: Int = 0
    
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


    
    //MARK: Auto rotate options
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return [.portrait, .landscape]
    }
    
    //MARK: orientation change methods
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        setupFooterLabel()
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
//MARK: UIViewController Life-Cycle Methods
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(menuBar)
        view.addSubview(footerLabel)
        
        setupBackgroundView()
        setupFooterLabel()
        setupNavBar()
        setupMenuBar(withSize: CGSize(width: view.bounds.width, height: view.bounds.height))
        setupCollectionView()
    }
    
}


//MARK: UI Layout
extension HomeViewController {

    private func setupBackgroundView() {
        view.addSubview(backgroundImage)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImage)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImage)
        view.sendSubview(toBack: backgroundImage)
    }
    
    private func setupCollectionView() {
        collectionView.register(SkillsCell.self, forCellWithReuseIdentifier: NavigationItem.skills.cellID)
        collectionView.register(ProjectsCell.self, forCellWithReuseIdentifier: NavigationItem.projects.cellID)
        collectionView.register(EducationCell.self, forCellWithReuseIdentifier: NavigationItem.education_work.cellID)
        collectionView.register(AboutCell.self, forCellWithReuseIdentifier: NavigationItem.about.cellID)
        
        view.insertSubview(collectionView, belowSubview: menuBar)
        setCollectionViewFrame(withSize: view.frame.size)
    }
    
    private func setupNavBar() {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.Theme.customWhite.color
        navigationController?.view.addSubview(titleLabel)
        setTitleLabelPosition(withSize: view.frame.size)
        
        let contactImage = UIImage(named: UIImage.Theme.contact.rawValue)?.withRenderingMode(.alwaysTemplate)
        let contactBarButton = UIBarButtonItem(image: contactImage, style: .plain, target: self, action: #selector(handleContact))
        contactBarButton.tintColor = UIColor.Theme.customDarkBlue.color
        navigationItem.rightBarButtonItems = [contactBarButton]
    }
    
    private func setTitleLabelPosition(withSize size: CGSize) {
        let labelX: CGFloat = -13.0 + (min(size.width, size.height) / 8)
        let labelY: CGFloat = 10 + statusHeight
        titleLabel.frame = CGRect(x: labelX, y: labelY, width: 250, height: 25)
    }

    private func setupMenuBar(withSize size: CGSize) {
        menuBar.frame = CGRect(x: 0, y: navHeight + statusHeight, width: size.width, height: 50)
    }
    
    private func setupFooterLabel() {
        view.removeConstraints(footerHorizontal)
        view.removeConstraints(footerVertical)
        
        if UIDevice.current.orientation.isPortrait {
            footerLabel.textColor = UIColor.Theme.customPeach.color
            footerLabel.textAlignment = .center
            footerHorizontal = NSLayoutConstraint.constraintsWithFormat(format: "H:|[v0]|", views: footerLabel)
            footerVertical = NSLayoutConstraint.constraintsWithFormat(format: "V:[v0]-8-|", views: footerLabel)
        } else {
            footerLabel.textColor = UIColor.Theme.customDarkBlue.color
            footerLabel.textAlignment = .right
            footerHorizontal = NSLayoutConstraint.constraintsWithFormat(format: "H:[v0]-24-|", views: footerLabel)
            footerVertical = NSLayoutConstraint.constraintsWithFormat(format: "V:|-60-[v0]", views: footerLabel)
        }
        view.addConstraints(footerHorizontal)
        view.addConstraints(footerVertical)
    }

    //MARK: Orientation UI Change
    private func setCollectionViewFrame(withSize size: CGSize) {
        collectionView.frame = CGRect(x: 0, y: menuHeight + navHeight + statusHeight, width: size.width, height: size.height - menuHeight - navHeight - statusHeight)
    }
    
}

//MARK: CollectionView Delegate and Datasource
extension HomeViewController : UICollectionViewDelegateAndDatasource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NavigationItem.orderedHeadings().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIDs: [String] = NavigationItem.orderedCellIDs()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDs[indexPath.row], for: indexPath)
        
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
}

//MARK: MenuBarDelegate
extension HomeViewController : MenuBarDelegate {
    
    func scrollToItemAt(index: Int) {
        pageTracker = index
        let indexPath: NSIndexPath = NSIndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleFor(index: index)
    }

}
