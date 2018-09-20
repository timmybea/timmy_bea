//
//  CachedImageView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-20.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    
    var imageEndPoint: String? {
        didSet {
            if let endPoint = imageEndPoint {
                loadImage(from: endPoint)
            }
        }
    }
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override func layoutSubviews() {
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        
        activityIndicatorView.removeFromSuperview()
        
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        
        activityIndicatorView.startAnimating()
        
        if let endPoint = imageEndPoint {
            loadImage(from: endPoint)
        }
    }
    
    private func loadImage(from endPoint: String) {
        
        if let imageFromCache = UIImage.imageCache.object(forKey: endPoint as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicatorView.stopAnimating()
            return
        }
        
        UIImage.cacheImage(from: endPoint) { (image) in
            
            guard let image = image else {
                return
            }
            
            self.image = image
            self.activityIndicatorView.stopAnimating()
        }
    }
    
}
