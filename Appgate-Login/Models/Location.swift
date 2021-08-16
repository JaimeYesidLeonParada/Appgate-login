//
//  Georeference.swift
//  Georeference
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import Foundation

struct Location: Codable {
    var sunrise: String
    var lng: Double
    var countryCode : String
    var gmtOffset : Double
    var rawOffset : Double
    var sunset : String
    var timezoneId : String
    var dstOffset : Double
    var countryName : String
    var time : String
    var lat : Double
}
