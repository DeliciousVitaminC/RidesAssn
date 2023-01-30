//
//  DetailViewController.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import UIKit

class DetailViewController: UIViewController {
    private var selectedVehicle : VehicleModel?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 45
        
        if let vin = selectedVehicle?.getVehicleInfo().vin,
           let make = selectedVehicle?.getVehicleInfo().make_and_model,
           let color = selectedVehicle?.getVehicleInfo().color,
           let carType = selectedVehicle?.getVehicleInfo().car_type {
            vinLabel.text = "\(Constants.cellTitleVin): \n\(vin)"
            makeLabel.text = "\(Constants.cellTitleMake): \n\(make)"
            colorLabel.text = "\(Constants.cellTitleColor): \n\(color)"
            typeLabel.text = "\(Constants.cellTitleType): \n\(carType)"
        }
        
        print(selectedVehicle!.getCarbonEmission())
    }
    
    func selectVehicle(for vehicle : VehicleModel){
        self.selectedVehicle = vehicle
    }
}
