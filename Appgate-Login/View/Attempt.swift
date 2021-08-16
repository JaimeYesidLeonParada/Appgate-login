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
//    let data : [UserAttempt] = [
//        UserAttempt(success: true, time: "11:28", user: User(email: "james.rodriguez@gmail.com", password: "12345")),
//        UserAttempt(success: false, time: "11:33 pm", user: User(email: "pedro.escamoso@gmail.com", password: "12345")),
//        UserAttempt(success: false, time: "11:34 pm", user: User(email: "lionel.messi@gmail.com", password: "12345"))
//    ]
    
    let data = TaskManager.shared.getAllAttempts()
    
    var body: some View {
        NavigationView {
            List(data) { attempt in
                HStack {
                    Image(systemName: attempt.success ? "hand.thumbsup" : "hand.thumbsdown.fill" )
                        .frame(width: 20.0, height: 15.0, alignment: .leading)
                    Text(attempt.time)
                        .lineLimit(1)
                        .font(.system(size: 14.0, weight: .semibold))
                        .foregroundColor(Color.black)
                    Text(attempt.user.email)
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
