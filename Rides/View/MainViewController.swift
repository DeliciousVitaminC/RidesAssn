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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        searchTextField.keyboardType = .numberPad
        searchTextField.addDoneButtonOnKeyBoardWithControl()
        
        spinner.isHidden = true
        
        vehicleService.delegate = self
        
        tableView.layer.cornerRadius = 25
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alpha = 0
        
    }
}
//MARK: - TableView Extensions
extension MainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vehicle = vehicleList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCellId, for: indexPath)
        
        cell.textLabel!.numberOfLines = 2
        cell.textLabel!.text = vehicle.getVehicleInfo().make_and_model + "\n" + vehicle.getVehicleInfo().vin
        return cell
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueId, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectVehicle(for: vehicleList[indexPath.row])
        }
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
            self.spinner.isHidden = true
            self.tableView.alpha = 1
            self.tableView.reloadData()
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
            spinner.isHidden = false
            tableView.alpha = 0
            spinner.startAnimating()
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

