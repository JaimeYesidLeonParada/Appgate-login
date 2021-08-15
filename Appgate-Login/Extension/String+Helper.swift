//
//  Validation.swift
//  Validation
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import Foundation

extension String {
    func matches(_ expression: String) -> Bool {
        if let range = range(of: expression, options: .regularExpression, range: nil, locale: nil) {
            return range.lowerBound == startIndex && range.upperBound == endIndex
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
    var isValidPassword: Bool {
        matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$")
    }
}
