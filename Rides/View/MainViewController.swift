//
//  ViewController.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import UIKit

class MainViewController: UIViewController {
    
    private var vehicleList = [VehicleModel]()
    private var vehicleService = VehicleService()

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        searchTextField.keyboardType = .numberPad
        searchTextField.addDoneButtonOnKeyBoardWithControl()
        
        vehicleService.delegate = self
        
        tableView.layer.cornerRadius = 25
        
    }
}

//MARK: - VehicleService Extensions

extension MainViewController : VehicleServiceDelegate {
    func didFetchdata(vehicleList: [VehicleModel]) {
        DispatchQueue.main.async {
            self.vehicleList = vehicleList
            self.vehicleList.sort {
                $0.getVehicleInfo().vin < $1.getVehicleInfo().vin
            }
            print(vehicleList.count)
            print(vehicleList[vehicleList.count - 1].getCarbonEmission())
        }
    }
}

//MARK: - UITextField Extensions

extension MainViewController : UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchTextField.text != "" {
            vehicleService.fetchData(size: Int(searchTextField.text!)!)
            searchTextField.text = ""
        }
    }
}

extension UITextField {
    func addDoneButtonOnKeyBoardWithControl() {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: safeAreaLayoutGuide.layoutFrame.width, height: 44))
        keyboardToolbar.sizeToFit()
        keyboardToolbar.barStyle = .default
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
}

