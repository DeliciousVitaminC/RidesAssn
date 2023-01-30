//
//  VehicleModel.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import Foundation

class VehicleModel {
    private var vehicleInfo : VehicleData
    private var carbonEmission : Double = 0.0
    
    init(_ vehicleInfo: VehicleData) {
        self.vehicleInfo = vehicleInfo
        self.carbonEmission = estimateCarbonEmission(vehicleInfo.kilometrage)
    }
    
    private func estimateCarbonEmission(_ kilo : Int) -> Double {
        if kilo <= 5000 {
            return Double(kilo) * 1.0
        } else {
            return Double((kilo - 5000)) * 1.5 + 5000.0
        }
    }
    
    func getVehicleInfo() -> VehicleData {
        return self.vehicleInfo
    }
    
    func getCarbonEmission() -> Double {
        return self.carbonEmission
    }
    
}
