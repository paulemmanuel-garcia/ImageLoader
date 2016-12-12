//
//  ViewController.swift
//  Example-Swift
//
//  Created by Paul-Emmanuel on 11/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit
import ImageLoader

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadImage()
    }

    override func viewWillDisappear(_ animated: Bool) {
        imageView.image = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reloadImage(_ sender: Any) {
        loadImage()
    }

    func loadImage() {
        // https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg
        ImageLoader.default.load(image: "https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg") {
            image, error in
            self.imageView.image = image
        }
    }
}

