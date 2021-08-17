//
//  UIView+Helper.swift
//  UIView+Helper
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import SwiftUI

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0 )
    }
}
