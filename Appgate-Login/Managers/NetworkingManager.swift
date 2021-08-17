//
//  ServiceManager.swift
//  ServiceManager
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import Foundation

private struct Constants {
    static let urlLocationRequest = "http://api.geonames.org/timezoneJSON"
}

class NetworkingManager {
    private let queryService = QueryService()
    private let locationService = LocationService()
    
    init() {
    }
    
    func getCurrentTime(completion: @escaping (String) -> Void) {
        if var urlComponents = URLComponents(string: Constants.urlLocationRequest) {
            let coordinate = locationService.getCurrentLocation()
            urlComponents.query = "formatted=true&lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&username=qa_mobile_easy&style=full"
            if let url = urlComponents.url{
                queryService.request(with: url) { data, error in
                    if let dataLocation = data, let location = try? JSONDecoder().decode(Location.self, from: dataLocation) {
                        completion(Date().currentTime(time: location.time))
                    }
                    else {
                        completion(Date().currentTime())
                    }
                }
            }
        
        }else{
            completion(Date().currentTime())
        }
    }
}
