//
//  TextField+Styles.swift
//  TextField+Styles
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import SwiftUI

extension TextField {
    func emailStyle() -> some View {
        self
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(Color.black)
            .textContentType(.emailAddress)
            .padding(.top, 5.0)
    }
}
