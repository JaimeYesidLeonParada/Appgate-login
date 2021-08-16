//
//  TaskManager.swift
//  TaskManager
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    
    var keyChainStore: KeyChainStore!
    
    init() {
      loadTasks()
    }
    
    func loadTasks() {
        let genericPwdQueryable = GenericPasswordQueryable(service: "someService")
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
}
