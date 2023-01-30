//
//  Page02ViewController.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import UIKit

class Page02ViewController: UIViewController {
    private var carbonEmissionData : Double?

    @IBOutlet weak var CarbonEmissionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let ce = carbonEmissionData else{
            fatalError("Error in estimated carbon emission")
        }
        CarbonEmissionLabel.text = "Estimated Carbon Emission:\n\(String(ce)) Unit(s)"
    }
    
    func initData(with data : Double?) -> Bool{
        if let safeData = data{
            carbonEmissionData = safeData
            return true
        }
        else {
            return false
        }
    }
}
