//
//  CachedImageView.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-20.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    
    private var imageEndPoint: String?
    
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
        
        if self.image == nil {
            activityIndicatorView.startAnimating()
        }
    }
    
    func loadImage(from endPoint: String, with renderingMode: UIImageRenderingMode?) {
        
        self.imageEndPoint = endPoint
        
        func setImage(_ image: UIImage) {
            
            var img = image
            
            if let rend = renderingMode {
                img = img.withRenderingMode(rend)
            }
            
            self.image = img
            activityIndicatorView.stopAnimating()
        }
        
        if let imageFromCache = UIImage.imageCache.object(forKey: endPoint as AnyObject) as? UIImage {
            setImage(imageFromCache)
            return
        }
        
        UIImage.cacheImage(from: endPoint) { (image) in
            
            guard let imageFromCache = image else {
                return
            }
            setImage(imageFromCache)
        }
    }
    
}
