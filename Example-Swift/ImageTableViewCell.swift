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

    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }

    private var _imageURL: String?
    public var imageURL: String? {
        set {
            _imageURL = newValue
            pictureView.load(with: newValue!)
        }
        get {
            return _imageURL
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pictureView: UIImageView!
    
    override func prepareForReuse() {
        pictureView.image = nil
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
