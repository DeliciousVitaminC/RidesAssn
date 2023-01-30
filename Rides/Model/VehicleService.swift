//
//  VehicleService.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import Foundation

protocol VehicleServiceDelegate {
    func didFetchdata( vehicleList : [VehicleModel] )
}

class VehicleService {
    private var vehicleList = [VehicleModel]()
    var delegate : VehicleServiceDelegate?
    
//    func fetchData(size batch: Int, maxAttemp limit : Int) -> Bool {
//        var callCount = 0
//        while vehicleList.count == 0 && callCount <= limit {
//            print("querying........................")
//            callCount += 1
//            self.queryData(size: batch)
//        }
//        print("Completed loop with call count of \(callCount)")
//        if callCount <= limit{
//            return true
//        }else{
//            return false
//        }
//    }
    
    func fetchData(size : Int) {
        let urlString = Constants.requestURL + String(size)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                } else {
                    if let safeData = data {
                        if let vehicleInfo = self.parseJSON(data: safeData){
                            self.vehicleList = vehicleInfo.map({return VehicleModel($0)})
                            self.delegate?.didFetchdata(vehicleList: self.vehicleList)
                        }
                    }
                }
            }.resume()
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
