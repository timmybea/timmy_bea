//
//  UIExtensions.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-11.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit
import MessageUI
import AVFoundation

//MARK: UINavigationBar Extension
extension UINavigationBar {
    
    //remove bar shadow
    static func setupCustomAppearance() {
        self.appearance().shadowImage = UIImage()
        self.appearance().setBackgroundImage(UIImage(), for: .default)
        self.appearance().barTintColor = UIColor.Theme.customWhite.color
    }
    
}

//MARK: UIImage Extension
extension UIImage {
    
    enum Theme {
        case backgroundGradient
        case contact
        case phone
        case email
        case linkedIn
        case github
        case cancel
        case skills
        case projects
        case education
        case about
        
        var name: String {
            switch self {
            case .backgroundGradient:    return "background_gradient"
            case .phone:                 return "phone"
            case .contact:               return "contact"
            case .email:                 return "contact_email"
            case .linkedIn:              return "contact_linkedIn"
            case .github:                return "contact_git"
            case .cancel:                return "contact_cancel"
            case .skills:                 return "skills"
            case .projects:               return "projects"
            case .education:              return "education"
            case .about:                  return "about"
            }
        }
        
        var image: UIImage {
            switch self {
            case .backgroundGradient:   return UIImage(named: self.name)!
            case .phone:                return UIImage(named: self.name)!
            case .contact:              return UIImage(named: self.name)!
            case .email:                return UIImage(named: self.name)!
            case .linkedIn:             return UIImage(named: self.name)!
            case .github:               return UIImage(named: self.name)!
            case .cancel:               return UIImage(named: self.name)!
            case .skills:               return UIImage(named: self.name)!
            case .projects:             return UIImage(named: self.name)!
            case .education:            return UIImage(named: self.name)!
            case .about:                return UIImage(named: self.name)!
            }
        }
    }
    
}


protocol ImageCachable {}

extension ImageCachable {
    
    func cacheImage(from endpoint: String,completion: @escaping (UIImage?) -> ()) {
        UIImage.cacheImage(from: endpoint) { (image) in
            completion(image)
        }
    }
}

extension UIImage {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
     static func cacheImage(from endPoint: String, completion: @escaping (UIImage?) -> ()) {
        
        var output: UIImage? = nil
        
        APIService.fetchData(with: .image(endPoint: endPoint)) { (data, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let currData = data else {
                return
            }
            
            guard let image = UIImage(data: currData) else {
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: endPoint as AnyObject)
            }
            
            output = image
            
        }
        completion(output)
    }
}

//MARK: UIView Extensions
extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

extension UIView {
    
    static func createAndPositionUnderline(beneath view: UIView) -> UIView {
        let underline = UIView(frame: CGRect(x: 0,
                                             y: view.frame.maxY + 2,
                                             width: view.frame.width + 4,
                                             height: 2))
        underline.backgroundColor = UIColor.Theme.customSand.color
        underline.center.x = view.center.x
        return underline
    }
    
    static func blueView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.Theme.customDarkBlue.color.withAlphaComponent(0.8)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }
    
}

//MARK: UIImageView Extension
extension UIImageView {

    static func createWith(imageName: String?, contentMode: UIViewContentMode) -> UIImageView {
        let view = UIImageView()
        if let name = imageName, let image = UIImage(named: name) {
            view.image = image
        }
        view.contentMode = contentMode
        view.backgroundColor = UIColor.clear
        return view
    }
    
}

//MARK: UILabel Extension
extension UILabel {
    
    static func createLabelWith(text: String = "", color: UIColor = UIColor.white, font: UIFont = UIFont.Theme.subHeader.font) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        return label
    }

}

//MARK: UITextView Extension
extension UITextView {
    
    static func createUneditableTextView(with text: String = "", color: UIColor = UIColor.white, font: UIFont = UIFont.Theme.subHeader.font) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.textColor = color
        textView.font = font
        textView.text = text
        textView.isEditable = false
        return textView
    }
    
}


//MARK: UICollectionView Extension
protocol UICollectionViewDelegateAndDatasource : UICollectionViewDataSource, UICollectionViewDelegate {}

extension UICollectionView {
    
    static func horizontalPagingCollectionView(in delegate: UICollectionViewDelegateAndDatasource) -> UICollectionView {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.isScrollEnabled = false
        cv.isPagingEnabled = true
        cv.delegate = delegate
        cv.dataSource = delegate
        return cv
    }
    
    static func defaultCollectionView(in delegate: UICollectionViewDelegateAndDatasource, with direction: UICollectionViewScrollDirection?) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        if let dir = direction {
            layout.scrollDirection = dir
        }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = delegate
        cv.dataSource = delegate
        return cv
    }
    
}

extension UINavigationController {
    
    static var navBarHeight: CGFloat {
        return UIDevice.current.orientation.isPortrait ? 44 : landscapeHeight
    }
    
    private static var landscapeHeight: CGFloat {
        return Device.IS_5_5_INCHES() ? 44 : 32
    }
    
}



//MARK: NSLayoutConstraint Extensions
extension NSLayoutConstraint {
    
    class func constraintsWithFormat(format: String, views: UIView...) -> [NSLayoutConstraint] {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        return constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary)
    }
    
}

extension UIScreen {
    
    static var statusHeight: CGFloat {
        if Device.isPhone() {
            return UIDevice.current.orientation.isPortrait ? 20.0 : 0.0
        } else {
            return 0.0
        }
    }

    static var safeAreaTop: CGFloat {
        if Device.isIphoneX() {
            return UIDevice.current.orientation.isPortrait ? 44 : 0.0
        } else {
            return statusHeight
        }
    }

}

extension MFMailComposeViewController {
    
    enum MessageComponent: String {
        case recipient = "tbeals@roobicreative.com"
        case subject = "Message From iOSDeveloper App"
    }
    
    static func launchNewMessage(in vc: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients([MessageComponent.recipient.rawValue])
            mail.setSubject(MessageComponent.subject.rawValue)
            vc.present(mail, animated: true)
        } else {
            if let vc = vc as? UIAlertControllerDelegate {
                UIAlertController.presentAlert(in: vc, title: "Could not launch email", message: "Please try again later", options: ["OK"], completion: nil)
            }
        }
    }
    
}


protocol UIAlertControllerDelegate {
    func selectedOption(_ option: String)
}

extension UIAlertController {
    
    static func presentAlert(in delegate: UIAlertControllerDelegate, title: String, message: String?, options: [String]?, completion: (() -> ())?) {
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if let options = options {
                for option in options {
                    let action = UIAlertAction(title: option, style: .default) { (action) in
                        delegate.selectedOption(action.title!)
                    }
                    alert.addAction(action)
                }
            }
        if let vc = delegate as? UIViewController {
            vc.present(alert, animated: true) {
                completion?()
            }
        }
    }
    
}

extension CGFloat {
    
    static let pad: CGFloat = 8.0
    
}

//MARK: UIColor Extensions
extension UIColor {
    
    static func colorWithValues(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
}


//MARK: String Extensions
extension String {
    
    static func duration(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let secondsText = String(format: "%02d", Int(totalSeconds) % 60)
        let minutesText = String(format: "%02d", Int(totalSeconds) / 60)
        return  "\(minutesText):\(secondsText)"
    }

}

//MARK: Slider Extensions
extension UISlider {
    
    func setSliderValue(for player: AVPlayer, progress: CMTime) {
        guard let duration = player.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let progressSeconds = CMTimeGetSeconds(progress)
        self.value = Float(progressSeconds / totalSeconds)
    }
}

extension AVPlayer {
    
    enum observableKey: String {
        case loadedTimeRanges = "currentItem.loadedTimeRanges"
    }
    
}

//MARK: UIApplication extension
extension UIApplication {
    
    static var isPortrait: Bool {
        return UIApplication.shared.statusBarOrientation.isPortrait
    }
    
}
