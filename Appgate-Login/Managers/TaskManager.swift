//
//  TaskManager.swift
//  TaskManager
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    
    var secureStoreWithGenericPwd: KeyChainStore!
    
    init() {
      loadTasks()
    }
    
    func loadTasks() {
        let genericPwdQueryable = GenericPasswordQueryable(service: "someService")
        secureStoreWithGenericPwd = KeyChainStore(secureStoreQueryable: genericPwdQueryable)
    }
}
