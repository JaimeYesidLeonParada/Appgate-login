//
//  UserAttempt.swift
//  UserAttempt
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import Foundation

struct UserAttempt: Codable, Identifiable {
    var id = UUID().uuidString
    var success: Bool
    var time: String
    var user: User
}
