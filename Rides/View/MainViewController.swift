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
    @IBOutlet weak var sortPopupButton: UIButton!
    
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
        
        popupMenuInit()
    }
}
//MARK: - Popup Menu Extensions
extension MainViewController {
    func popupMenuInit() {
        let completionHandler = { (action : UIAction) in
            if action.title == Constants.titleType{
                self.vehicleList.sort {
                    $0.getVehicleInfo().car_type < $1.getVehicleInfo().car_type
                }
            } else if action.title == Constants.titleVin {
                self.vehicleList.sort {
                    $0.getVehicleInfo().vin < $1.getVehicleInfo().vin
                }
            } else {
                fatalError("Popup option does not match any available sorting method")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        sortPopupButton.menu = UIMenu(children:[
            UIAction(title: Constants.titleVin, state: .on, handler: completionHandler),
            UIAction(title: Constants.titleType, handler: completionHandler)
        ])
        sortPopupButton.showsMenuAsPrimaryAction = true
        sortPopupButton.changesSelectionAsPrimaryAction = true
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
    func didFetchData(vehicleList: [VehicleModel]) {
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
    
    func failedFetchData() {
        DispatchQueue.main.async {
//            self.presentAlert(with: Constants.maxAttemptErrorMessage)
            self.spinner.isHidden = true
        }
    }
    
    func failedParseData() {
        DispatchQueue.main.async {
            //self.presentAlert(with: Constants.incorrectDataFormatErrorMessage)
            self.spinner.isHidden = true
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
            if validateInput(searchTextField.text!){
                vehicleService.fetchData(size: Int(searchTextField.text!)!)
                spinner.isHidden = false
            }
            searchTextField.text = ""
            tableView.alpha = 0
            spinner.startAnimating()
        }
    }
    
    func validateInput(_ inputString: String) -> Bool {
        if let querySize = Int(inputString) {
            if querySize >= 1 && querySize <= 100{
                return true
            }
        }
        presentAlert(with: Constants.inputInvalidErrorMessage)
        return false
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

extension MainViewController{
    private func presentAlert(with message : String){
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
