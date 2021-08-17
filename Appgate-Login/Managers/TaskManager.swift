//
//  TaskManager.swift
//  TaskManager
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    private let storageService = StorageService()
    
    func createUser(user: User) {
        storageService.createUser(user: user)
    }
    
    func checkUserCreated(user: User) -> Bool {
        return storageService.checkUserCreated(user: user)
    }
    
    func saveAttempt(user: User, success: Bool) {
        storageService.saveAttempt(user: user, success: success)
    }
    
    func getAllAttempts() -> [UserAttempt] {
        return storageService.getAllAttempts()
    }
}
