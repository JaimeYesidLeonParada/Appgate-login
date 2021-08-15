//
//  Appgate_LoginTests_String_Helper.swift
//  Appgate_LoginTests_String_Helper
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import XCTest

class Appgate_LoginTests_String_Helper: XCTestCase {

    func testIsValidEmail(){
        let validEmail = "email@gmail.com"
        XCTAssertTrue(validEmail.isValidEmail)
    }
    
    func testIsInvalidEmail(){
        let invalidEmail = "noemailhere"
        XCTAssertFalse(invalidEmail.isValidEmail)
    }
    
    func testIsValidPassword(){
        let validPassword = "JYlp123@#"
        XCTAssertTrue(validPassword.isValidPassword)
    }
    
    func testIsInvalidValidPassword(){
        let invalidPassword = "admin123"
        XCTAssertFalse(invalidPassword.isValidPassword)
    }

}
