//
//  KeyChainStoreQueryable.swift
//  KeyChainStoreQueryable
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import Foundation

public protocol KeyChainStoreQueryable {
  var query: [String: Any] { get }
}

public struct keyChainQueryable {
    let service: String
    let accessGroup: String?
    
    init(service: String, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }
}

extension keyChainQueryable: KeyChainStoreQueryable {
    public var query: [String: Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        
        #if !targetEnvironment(simulator)
        if let accessGroup = accessGroup {
            query[String(kSecAttrAccessGroup)] = accessGroup
        }
        #endif
        return query
    }
}
