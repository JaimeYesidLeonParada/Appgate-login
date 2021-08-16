//
//  LocationService.swift
//  LocationService
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import Foundation
import CoreLocation

public class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    var coordinate = Coordinate(latitude: 0.0, longitude: 0.0)
    
    override init(){
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
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
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}
