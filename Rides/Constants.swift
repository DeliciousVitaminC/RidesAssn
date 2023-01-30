//
//  Constants.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import Foundation

struct Constants {
    static let appName = "Rides"
    static let requestURL = "https://random-data-api.com/api/vehicle/random_vehicle?size="
    static let segueId = "goToDetail"
    static let searchFieldPlaceholder = "Num to Query"
    static let maxAttemptAllowed = 5
    static let maxAttemptErrorMessage = "A network issue have occurred. Please check your network and try again later."
    static let incorrectDataFormatErrorMessage = "Data format mismatch. Please contact support and provide this information."
    static let inputInvalidErrorMessage = "Please input an integer between 1 and 100"
    static let reusableCellId = "ItemCell"
    static let titleVin = "Vehicle ID"
    static let titleMake = "Make and Model"
    static let titleColor = "Color"
    static let titleType = "Car Type"
    
    static let page01Id = "Page01ViewController"
    static let page02Id = "Page02ViewController"
    
}
