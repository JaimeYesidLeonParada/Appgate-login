//
//  KeyChainStoreTests.swift
//  KeyChainStoreTests
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import XCTest
@testable import Appgate_Login

//@testable import KeyChainStore

class KeyChainStoreTests: XCTestCase {
    
    var keychainStore: KeyChainStore!
    
    override func setUpWithError() throws {
        let genericPwdQueryable = GenericPasswordQueryable(service: "someService")
        keychainStore = KeyChainStore(secureStoreQueryable: genericPwdQueryable)
    }
    
    override func tearDownWithError() throws {
        try? keychainStore.removeAllValues()
    }
    
    func testSaveGenericPassword() {
        do {
            try keychainStore.setValue("pwd_1234", for: "genericPassword")
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testSaveGenericData() {
        let user = User(email: "lionel.messi@gmail.com", password: "barcelona")
               
        do {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(user) {
                try keychainStore.setData(encoded, for: "SavedPerson")
            }            
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testReadGenericData() {
        let user = User(email: "lionel.messi@gmail.com", password: "barcelona")
        
        do {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(user) {
                try keychainStore.setData(encoded, for: "SavedPerson")
            }
            
            if let savedPerson = try keychainStore.getData(for: "SavedPerson") {
                let decoder = JSONDecoder()
                if let loadedUser = try? decoder.decode(User.self, from: savedPerson) {
                    XCTAssertEqual(user.email, loadedUser.email)
                    XCTAssertEqual(user.password, loadedUser.password)
                }
            } else {
                XCTFail()
            }
            
        } catch (let e) {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testReadGenericPassword() {
        do {
            try keychainStore.setValue("pwd_1234", for: "genericPassword")
            let password = try keychainStore.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1234", password)
        } catch (let e) {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testUpdateGenericPassword() {
        do {
            try keychainStore.setValue("pwd_1234", for: "genericPassword")
            try keychainStore.setValue("pwd_1235", for: "genericPassword")
            
            let password = try keychainStore.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1235", password)
        } catch (let e) {
            XCTFail("Updating generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testRemoveGenericPassword() {
        do {
            try keychainStore.setValue("pwd_1234", for: "genericPassword")
            try keychainStore.removeValue(for: "genericPassword")
            XCTAssertNil(try keychainStore.getValue(for: "genericPassword"))
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testRemoveAllGenericPasswords() {
        do {
            try keychainStore.setValue("pwd_1234", for: "genericPassword")
            try keychainStore.setValue("pwd_1235", for: "genericPassword2")
            try keychainStore.removeAllValues()
            
            XCTAssertNil(try keychainStore.getValue(for: "genericPassword"))
            XCTAssertNil(try keychainStore.getValue(for: "genericPassword2"))
        } catch (let e) {
            XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
        }
    }
}
