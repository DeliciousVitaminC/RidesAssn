//
//  VehicleData.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import Foundation

struct VehicleData : Codable {
    let vin : String
    let make_and_model : String
    let color : String
    let car_type : String
    let kilometrage : Int
}
