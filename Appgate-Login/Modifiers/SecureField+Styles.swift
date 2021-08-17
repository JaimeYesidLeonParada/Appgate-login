//
//  SecureField+Styles.swift
//  SecureField+Styles
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import SwiftUI

extension SecureField {
    func passwordStyle() -> some View {
        self
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(Color.black)
            .padding(.top, 5.0)
    }
}
