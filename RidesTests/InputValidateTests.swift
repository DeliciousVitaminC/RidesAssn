//
//  InputValidateTests.swift
//  RidesTests
//
//  Created by zhaohe on 2023-01-30.
//

import XCTest
@testable import Rides

final class InputValidateTests: XCTestCase {
    
    var sut : VehicleService!

    override func setUpWithError() throws {
        sut = VehicleService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testWithChar() {
        XCTAssertFalse(sut.validateInput("asd"))
    }
    
    func testWithCharAndNum() {
        XCTAssertFalse(sut.validateInput("hahaha+123"))
    }
    
    func testWithNumOver100() {
        XCTAssertFalse(sut.validateInput("1234"))
    }
    
    func testWithNegative() {
        XCTAssertFalse(sut.validateInput("-123"))
    }
    
    func testWithNonInt() {
        XCTAssertFalse(sut.validateInput("1.234"))
    }
    
    func testWithPositiveIntUnder100() {
        XCTAssertTrue(sut.validateInput("56"))
    }
    
    func testWithBoundValue() {
        XCTAssertTrue(sut.validateInput("1"))
        XCTAssertTrue(sut.validateInput("100"))
    }
    
    func testWithZero() {
        XCTAssertFalse(sut.validateInput("0.0"))
    }
}
