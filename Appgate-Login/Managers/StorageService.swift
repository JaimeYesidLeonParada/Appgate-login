//
//  StorageService.swift
//  StorageService
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import Foundation
import KeyChainService

class StorageService {
    
    private struct Constants {
        static let keyChainStoreService = "AppgateLoginService"
        static let keyChainStoreKeyAttempts = "Attempts"
    }
    
    private var keyChainStore: KeyChainStore!
    private let networkingManager = NetworkingManager()
    
    init() {
      loadTasks()
    }
    
    func loadTasks() {
        let genericPwdQueryable = keyChainQueryable(service: Constants.keyChainStoreService)
        keyChainStore = KeyChainStore(secureStoreQueryable: genericPwdQueryable)
    }
    
    func createUser(user: User) {
        do {
            try keyChainStore.setValue(user.password, for: user.email)
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    
    func checkUserCreated(user: User) -> Bool {
        do {
            let password = try keyChainStore.getValue(for: user.email)
            return password == user.password
        } catch (let e) {
            print(e.localizedDescription)
        }
        
        return false
    }
    
    func saveAttempt(user: User, success: Bool) {
        getTime { [weak self] time in
            do {
                if let attempts = try self?.keyChainStore.getData(for: Constants.keyChainStoreKeyAttempts) {
                    if var usersAttempts = try? JSONDecoder().decode([UserAttempt].self, from: attempts) {
                        let attempt = UserAttempt(success: success, time: time, user: user)
                        usersAttempts.append(attempt)
                        
                        if let encoded = try? JSONEncoder().encode(usersAttempts) {
                            try self?.keyChainStore.setData(encoded, for: Constants.keyChainStoreKeyAttempts)
                        }
                    }
                } else {
                    let attempt = UserAttempt(success: success, time: time, user: user)
                    if let encoded = try? JSONEncoder().encode([attempt]) {
                        try self?.keyChainStore.setData(encoded, for: Constants.keyChainStoreKeyAttempts)
                    }
                }
            } catch (let e) {
                print(e.localizedDescription)
            }
        }
    }
    
    func getAllAttempts() -> [UserAttempt]{
        do {
            guard let attempts = try keyChainStore.getData(for: Constants.keyChainStoreKeyAttempts),
            let usersAttempts = try? JSONDecoder().decode([UserAttempt].self, from: attempts) else {
                return []
            }
            return usersAttempts
            
        } catch (let e) {
            print(e.localizedDescription)
        }
        return []
    }
    
    private func getTime(completion: @escaping (String) -> Void) {
        networkingManager.getCurrentTime(completion: completion)
    }
}
