//
//  TextTitle.swift
//  TextTitle
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import SwiftUI

extension Text {
    func headerStyle() -> some View {
        self
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.black)
            .kerning(2.0)
            .frame(maxWidth: .infinity,  alignment: .leading)
    }
    
    func labelStyle() -> some View {
        self
            .fontWeight(.bold)
            .foregroundColor(.gray)
    }
    
    func alertStyle() -> some View {
        self
            .font(.system(size: 14.0, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.red)
            .padding()
    }
    
    func primaryButton() -> some View {
        self
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .font(.system(size: 20.0, weight: .semibold))
    }
    func secondaryButton() -> some View {
        self
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.system(size: 20.0, weight: .bold))
    }
        
}

