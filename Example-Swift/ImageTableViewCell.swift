//
//  ImageTableViewCell.swift
//  ImageLoader
//
//  Created by Paul-Emmanuel on 11/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit
import ImageLoader

class ImageTableViewCell: UITableViewCell {

    private var shouldCacheImage: Bool = false
    
    public var title: String? {
        set {
            titleLabel.text = newValue
//            if let row = Int(newValue!), row % 2 == 0 {
//                shouldCacheImage = true
//            }
        }
        get {
            return titleLabel.text
        }
    }
    
    private var _imageURL: String?
    public var imageURL: String? {
        set {
            _imageURL = newValue
            imageRequest = ImageLoader.default.request(image: newValue!) {
                [weak self] image, error in
                self?.pictureView.image = image
            }
            imageRequest?.shouldCacheResult = shouldCacheImage
        }
        get {
            return _imageURL
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pictureView: UIImageView!
    private weak var imageRequest: ImageRequest?
    
    override func prepareForReuse() {
        imageRequest?.cancel()
        pictureView.image = nil
        shouldCacheImage = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
