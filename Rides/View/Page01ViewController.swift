//
//  Page01ViewController.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import UIKit

class Page01ViewController: UIViewController {
    
    private var selectedVehicle : VehicleData?
    
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let vin = selectedVehicle?.vin,
           let make = selectedVehicle?.make_and_model,
           let color = selectedVehicle?.color,
           let carType = selectedVehicle?.car_type else {
            fatalError("Vehicle model passed in is corrupted")
        }
        vinLabel.text = "\(Constants.titleVin): \n\(vin)"
        makeLabel.text = "\(Constants.titleMake): \n\(make)"
        colorLabel.text = "\(Constants.titleColor): \n\(color)"
        typeLabel.text = "\(Constants.titleType): \n\(carType)"
    }
    
    func initData(with data : VehicleData?) -> Bool{
        if let safeData = data{
            selectedVehicle = safeData
            return true
        }
        else {
            return false
        }
    }
}
