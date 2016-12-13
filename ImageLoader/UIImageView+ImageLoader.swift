//
//  UIImage+ImageLoader.swift
//  ImageLoader
//
//  Created by Paul-Emmanuel on 13/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit

// MARK: - UIImageView Extension
public extension UIImageView {
    
    /// Key for associated object
    private struct AssociatedKeys {
        static var ImageRequestKey: Int8 = 0
    }

    /// The image request to load image asynchronously
    public private(set) var imageRequest: ImageRequest? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ImageRequestKey) as? ImageRequest
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImageRequestKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// Instanciate an UIImageView and loading asynchronously its image.
    ///
    /// - Parameter urlString: The url of the image
    /// - Returns: the newly instanciated UIImageView
    public class func imageView(with urlString: String, autoStart: Bool = true) -> UIImageView {
        var imageView = UIImageView()

        imageView.load(with: urlString, autoStart: autoStart)

        return imageView
    }

    /// Convenience init to instanciate an UIImageView
    /// with the url of a remote image.
    /// It will automatically start the image downloading.
    /// You should set the frame manually as it won't be setted.
    ///
    /// - Parameter urlString: The url of the image.
    public convenience init(imageUrl urlString: String, autoStart: Bool = true) {
        self.init(image: nil)

        load(with: urlString, autoStart: autoStart)
    }

    /// Load the image of the UIImageView asynchronously
    /// will automaticaly cancel the previous request if there was one.
    ///
    /// - Parameter urlString: The url of the image
    public func load(with urlString: String, autoStart: Bool = true) {
        imageRequest?.cancel()
        
        imageRequest = ImageLoader.default.request(image: urlString, autoStart: autoStart) {
            [weak self] remoteImage, error in
            
            self?.image = remoteImage
            
            self?.imageRequest = nil
        }
    }
}
