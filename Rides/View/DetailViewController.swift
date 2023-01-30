//
//  DetailViewController.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import UIKit

class DetailViewController: UIViewController {
    private var selectedVehicle : VehicleModel?
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func selectVehicle(for vehicle : VehicleModel){
        self.selectedVehicle = vehicle
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ContentPageViewController
        destinationVC.selectVehicle(for: selectedVehicle!)
        
    }
}
