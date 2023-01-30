//
//  ViewController.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.layer.cornerRadius = 25
        
    }


}

