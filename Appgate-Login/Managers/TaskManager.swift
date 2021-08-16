//
//  TaskManager.swift
//  TaskManager
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import Foundation

struct Constants {
    static let keyChainStoreService = "AppgateLoginService"
    static let keyChainStoreKeyAttempts = "Attempts"
}

class TaskManager {
    static let shared = TaskManager()
    
    var keyChainStore: KeyChainStore!
    
    init() {
      loadTasks()
    }
    
    func loadTasks() {
        let genericPwdQueryable = GenericPasswordQueryable(service: Constants.keyChainStoreService)
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
        do {
            if let attempts = try keyChainStore.getData(for: Constants.keyChainStoreKeyAttempts) {
                if var usersAttempts = try? JSONDecoder().decode([UserAttempt].self, from: attempts) {
                    let attempt = UserAttempt(success: success, time: readCurrentTime(), user: user)
                    usersAttempts.append(attempt)
                    
                    if let encoded = try? JSONEncoder().encode(usersAttempts) {
                        try keyChainStore.setData(encoded, for: Constants.keyChainStoreKeyAttempts)
                    }
                }
            } else {
                let attempt = UserAttempt(success: success, time: readCurrentTime(), user: user)
                if let encoded = try? JSONEncoder().encode([attempt]) {
                    try keyChainStore.setData(encoded, for: Constants.keyChainStoreKeyAttempts)
                }
            }
        } catch (let e) {
            print(e.localizedDescription)
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
    
    func readCurrentTime() -> String {
        let timestamp = DateFormatter.localizedString(from: Date(),
                                                      dateStyle: .short,
                                                      timeStyle: .short)
        
        return timestamp
    }
}
