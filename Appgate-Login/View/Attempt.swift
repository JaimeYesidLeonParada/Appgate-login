//
//  Attempt.swift
//  Attempt
//
//  Created by Jaime Yesid Leon Parada on 15/08/21.
//

import SwiftUI

struct Attempt: View {
    @Environment(\.presentationMode) var presentationMode
    
    //Mock Data
    let modelData : [UserAttempt] = [
        UserAttempt(success: true, time: "11:32 pm", email: "james.rodriguez@gmail.com"),
        UserAttempt(success: false, time: "11:33 pm", email: "pedro.escamoso@gmail.com"),
        UserAttempt(success: true, time: "11:34 pm", email: "lionel.messi@gmail.com")
    ]
    
    var body: some View {
        NavigationView {
            List(modelData) { attempt in
                HStack {
                    Image(systemName: attempt.success ? "hand.thumbsup" : "hand.thumbsdown.fill" )
                        .frame(width: 20.0, height: 15.0, alignment: .leading)
                    Text(attempt.time)
                        .lineLimit(1)
                        .font(.system(size: 14.0, weight: .semibold))
                        .foregroundColor(Color.black)
                    Text(attempt.email)
                        .lineLimit(1)
                        .font(.system(size: 14.0, weight: .semibold))
                        .foregroundColor(Color.gray)
                }
            }
            
            .navigationBarTitle("Attempts")
            .navigationBarItems(trailing: Button("Close"){
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct Attempt_Previews: PreviewProvider {
    static var previews: some View {
        Attempt()
    }
}
