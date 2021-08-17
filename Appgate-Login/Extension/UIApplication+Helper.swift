//
//  UIApplication+Helper.swift
//  UIApplication+Helper
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
