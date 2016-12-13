//
//  TableImageViewController.swift
//  ImageLoader
//
//  Created by Paul-Emmanuel on 11/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit

class TableImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ImageTableViewCell
        
        cell.title = String(indexPath.row)
        cell.imageURL = "https://placehold.it/50x50?text=\(indexPath.row)"

        return cell
    }
}
