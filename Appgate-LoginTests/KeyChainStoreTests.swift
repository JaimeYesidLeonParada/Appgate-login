//
//  KeyChainStoreTests.swift
//  KeyChainStoreTests
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import XCTest

//@testable import KeyChainStore

class KeyChainStoreTests: XCTestCase {
    
    var secureStoreWithGenericPwd: KeyChainStore!
    
    override func setUpWithError() throws {
        let genericPwdQueryable = GenericPasswordQueryable(service: "someService")
        secureStoreWithGenericPwd = KeyChainStore(secureStoreQueryable: genericPwdQueryable)
    }
    
    override func tearDownWithError() throws {
        try? secureStoreWithGenericPwd.removeAllValues()
    }
    
    func testSaveGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testSaveGenericData() {
        
        struct Person: Codable {
            var name: String
        }

        let taylor = Person(name: "Taylor Swift")
        
        do {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(taylor) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "SavedPerson")
                
                try secureStoreWithGenericPwd.setData(encoded, for: "SavedPerson")
            }            
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testReadGenericData() {
        struct Person: Codable {
            var name: String
        }

        let taylor = Person(name: "Taylor Swift")
        
        do {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(taylor) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "SavedPerson")
                
                try secureStoreWithGenericPwd.setData(encoded, for: "SavedPerson")
            }
            
            if let savedPerson = try secureStoreWithGenericPwd.getData(for: "SavedPerson") {
                let decoder = JSONDecoder()
                if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                    XCTAssertEqual("Taylor Swift", loadedPerson.name)
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
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1234", password)
        } catch (let e) {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testUpdateGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
            
            let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1235", password)
        } catch (let e) {
            XCTFail("Updating generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testRemoveGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.removeValue(for: "genericPassword")
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testRemoveAllGenericPasswords() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
            try secureStoreWithGenericPwd.removeAllValues()
            
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword2"))
        } catch (let e) {
            XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
        }
    }
}
