//
//  ViewController.swift
//  Example-Swift
//
//  Created by Paul-Emmanuel on 11/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit
import ImageLoader

class ViewController: UIViewController, ImageRequestDelegate {

    @IBOutlet weak var imageView: UIImageView!
    weak var imageRequest: ImageRequest?
    
    var programaticImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        loadImage()
        
        programaticImageView = UIImageView(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg", autoStart: false)
        programaticImageView.frame = CGRect(x: 20.0, y: 20.0, width: 100.0, height: 100.0)
        programaticImageView.imageRequest?.delegate = self
        
        view.addSubview(programaticImageView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        imageView.image = nil
        programaticImageView = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reloadImage(_ sender: Any) {
        loadImage()
    }

    func loadImage() {
        programaticImageView.imageRequest?.start()
        // https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg
        
//        imageRequest = ImageLoader.default.request(image: "https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg", autoStart: false) {
//            image, error in
//            self.imageView.image = image
//        }
//        imageRequest?.delegate = self
//        imageRequest?.start()
    }

    func progress(_ request: ImageRequest, totalBytesSent: Int64, totalBytesExpected: Int64) {
        print("\(Double(totalBytesSent) / Double(totalBytesExpected) * 100.0)%")
    }
}

