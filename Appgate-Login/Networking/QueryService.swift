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
    
    typealias QueryResult = (Data?, String) -> Void
        
    func request(with url: URL, completion: @escaping QueryResult) {
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.dataTask = nil }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(data, "")
            }
            else {
                completion(nil, error?.localizedDescription ?? "error")
            }
        }
        dataTask?.resume()
    }
}
