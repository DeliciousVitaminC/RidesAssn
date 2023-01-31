//
//  CarbonEmissionTests.swift
//  RidesTests
//
//  Created by zhaohe on 2023-01-30.
//

import XCTest
@testable import Rides

final class CarbonEmissionTests: XCTestCase {
    
    var sut: VehicleModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCEUnder5000() {
        let vehicleInfo = VehicleData(vin: "", make_and_model: "", color: "", car_type: "", kilometrage: 2300)
        sut = VehicleModel(vehicleInfo)
        XCTAssertEqual(sut.getCarbonEmission(), 2300.0)
    }
    
    func testCEEqual5000() {
        let vehicleInfo = VehicleData(vin: "", make_and_model: "", color: "", car_type: "", kilometrage: 5000)
        sut = VehicleModel(vehicleInfo)
        XCTAssertEqual(sut.getCarbonEmission(), 5000.0)
    }
    
    func testCEMore5000() {
        let vehicleInfo = VehicleData(vin: "", make_and_model: "", color: "", car_type: "", kilometrage: 6500)
        sut = VehicleModel(vehicleInfo)
        XCTAssertEqual(sut.getCarbonEmission(), 7250.0)
    }
    
    func testCEZero() {
        let vehicleInfo = VehicleData(vin: "", make_and_model: "", color: "", car_type: "", kilometrage: 0)
        sut = VehicleModel(vehicleInfo)
        XCTAssertEqual(sut.getCarbonEmission(), 0.0)
    }
    
    func testCENegative() {
        let vehicleInfo = VehicleData(vin: "", make_and_model: "", color: "", car_type: "", kilometrage: -114514)
        sut = VehicleModel(vehicleInfo)
        XCTAssertEqual(sut.getCarbonEmission(), -1.0)
    }
    
}
