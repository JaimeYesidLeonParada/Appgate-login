//
//  QueryService.swift
//  QueryService
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import Foundation

class QueryService {
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
        
    func getTime(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "http://api.geonames.org/timezoneJSON") {
            urlComponents.query = "formatted=true&lat=\(latitude)&lng=\(longitude)&username=qa_mobile_easy&style=full"
            
            guard let url = urlComponents.url else {
                return
            }
            
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer { self?.dataTask = nil }
                
                if let dataLocation = data, let response = response as? HTTPURLResponse, response.statusCode == 200, let location = try? JSONDecoder().decode(Location.self, from: dataLocation) {
                    completion(Date().currentTime(time: location.time))
                }
                else {
                    completion(Date().currentTime())
                }
            }
            dataTask?.resume()
        }
    }
}
