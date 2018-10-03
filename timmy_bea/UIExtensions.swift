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
        case speechBubble
        case tail
        case medium
        case gitIcon
        case appleIcon
        
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
            case .speechBubble:          return "speech_bubble"
            case .tail:                 return "tail"
            case .medium:               return "contact_medium"
            case .gitIcon:              return "git_icon"
            case .appleIcon:            return "apple_icon"
            }
        }
        
        var image: UIImage {
            return UIImage(named: self.name)!
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


extension UITextView {
    
    func adjustFontSize() {
        
        DispatchQueue.main.async {
            guard let text = self.text else { return }
            guard let font = self.font else { return }
            guard let pointSize = self.font?.pointSize else { return }
            print(text)
            
            let height = text.getHeight(withWidth: self.bounds.width, font: font)
            
            if height + 30 > self.bounds.height {
                self.font = self.font?.withSize(pointSize - 1)
                self.adjustFontSize()
            }
        }
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
        if direction == nil {
            cv.isScrollEnabled = false
        }
        cv.delegate = delegate
        cv.dataSource = delegate
        return cv
    }
    
}

//MARK: UINavigationController extension
extension UINavigationController {
    
    static var navBarHeight: CGFloat {
        return UIDevice.current.orientation.isPortrait ? 44 : navBarHeightLandscape
    }
    
    private static var navBarHeightLandscape: CGFloat {
        return Device.IS_5_5_INCHES_OR_LARGER() ? 44 : 32
    }

    private static var navBarHeightPortrait : CGFloat {
        return 0
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
            return UIDevice.isPortrait ? 20.0 : 0.0
        } else {
            return 0.0
        }
    }
    
    static var safeAreaTop: CGFloat {
        let val: CGFloat
        if Device.isIPhoneXOrLater() {
             val = UIDevice.current.orientation.isPortrait ? 44 : 0.0
        } else {
            val = statusHeight
        }
        return val
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
                UIAlertController.presentAlert(in: vc,
                                               title: "Could not launch email",
                                               message: "Please try again later",
                                               options: [.ok],
                                               completion: nil)
            }
        }
    }
    
}

extension UIAlertAction {
    
    enum OptionType {
        case cancel
        case ok
        case delete
        case option(name: String)
        
        var title: String {
            switch self {
            case .cancel: return "Cancel"
            case .ok: return "OK"
            case .delete: return "Delete"
            case .option(let name): return name
            }
        }
        
        var style: UIAlertActionStyle {
            switch self {
            case .cancel: return .default
            case .ok: return .default
            case .delete: return .destructive
            case .option(_): return .default
            }
        }
        
        func action(handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
            return UIAlertAction(title: self.title, style: self.style, handler: { (alert) in
                handler(alert)
            })
        }
    }

}

protocol UIAlertControllerDelegate {
    
    func selectedOption(_ option: UIAlertAction.OptionType)

}

extension UIAlertController {
    
    static func presentAlert(in delegate: UIAlertControllerDelegate, title: String, message: String?, options: [UIAlertAction.OptionType], completion: (() -> ())?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for option in options {
            let action = option.action { (_) in
                delegate.selectedOption(option)
            }
            alert.addAction(action)
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
extension UIDevice {
    
    static var isPortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
}

//MARK: Scrollable protocol
protocol Scrollable {
    var pageTracker: Int { get set }
    func scrollToItemAt(index: Int)
}

//MARK: String extensions
extension String {
    
    func getHeight(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
        return actualSize.height
    }
    
    
    func getWidth(withHeight height: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
        return actualSize.width
    }
    
}
