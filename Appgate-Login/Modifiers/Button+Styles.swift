//
//  Button+Styles.swift
//  Button+Styles
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import SwiftUI

extension Button {
    func primaryStyle() -> some View {
        self
            .clipShape(Capsule())
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
