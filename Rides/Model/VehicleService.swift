//
//  VehicleService.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import Foundation

protocol VehicleServiceDelegate {
    func didFetchData(vehicleList : [VehicleModel])
    func failedFetchData()
    func failedParseData()
}

class VehicleService {
    private var vehicleList = [VehicleModel]()
    private var currentAttempts = 0
    
    var delegate : VehicleServiceDelegate?
    
    func fetchData(size batchSize: Int) {
        attemptGuard(size: batchSize)
        print("Completed loop with call count of \(currentAttempts)")
    }
    
    func queryData(size : Int) {
        currentAttempts += 1
        let urlString = Constants.requestURL + String(size)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                    self.attemptGuard(size: size)
                } else {
                    if let safeData = data {
                        if let vehicleInfo = self.parseJSON(data: safeData){
                            self.vehicleList = vehicleInfo.map({return VehicleModel($0)})
                            self.currentAttempts = 0
                            self.delegate?.didFetchData(vehicleList: self.vehicleList)
                        }
                        else {
                            self.delegate?.failedParseData()
                        }
                    }
                }
            }.resume()
        }
    }
    
    func attemptGuard(size : Int) {
        if currentAttempts <= Constants.maxAttemptAllowed {
            queryData(size: size)
        } else {
            delegate?.failedFetchData()
        }
    }
    
    private func parseJSON(data : Data) -> [VehicleData]? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([VehicleData].self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
