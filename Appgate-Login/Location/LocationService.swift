//
//  LocationService.swift
//  LocationService
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    private let locationManager = CLLocationManager()
    private var coordinate = Coordinate(latitude: 0.0, longitude: 0.0)
    
    override init(){
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    public func getCurrentLocation() -> Coordinate {
        return coordinate
    }
    
    deinit{
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            coordinate.latitude = location.coordinate.latitude
            coordinate.longitude = location.coordinate.longitude
        }
    }
}
