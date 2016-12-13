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
    private var imageRequest: ImageRequest? {
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
    class func imageView(with urlString: String) -> UIImageView {
        var imageView = UIImageView()
        
        imageView.load(with: urlString)

        return imageView
    }

    /// Load the image of the UIImageView asynchronously
    /// will automaticaly cancel the previous request if there was one.
    ///
    /// - Parameter urlString: The url of the image
    func load(with urlString: String) {
        imageRequest?.cancel()

        imageRequest = ImageLoader.default.request(image: urlString) {
            [weak self] remoteImage, error in

            self?.image = remoteImage
            self?.imageRequest = nil
        }
    }
}
