//
//  Login.swift
//  Login
//
//  Created by Jaime Yesid Leon Parada on 13/08/21.
//

import SwiftUI

struct Login: View {
    @State var user = User(email: "", password: "")
    @State var showingAlert = false
    @State var messageAlert = ""
    @State var isPresentedAttempt = false
    
    var body: some View {
        VStack{
            Text("Sign In").headerStyle()
            
            VStack(alignment: .leading, spacing: 8.0, content: {
                Text("User Name").labelStyle()
                TextField("Email", text: $user.email).emailStyle()
            }).padding(.top, 25.0)
            
            // Password
            VStack(alignment: .leading, spacing: 8.0, content: {
                Text("Password").labelStyle()
                SecureField("Password", text: $user.password).passwordStyle()
            }).padding(.top, 20.0)
            
            // Validate account
            Button(action: {
                messageAlert = "Verify that the data is not empty and try again."
                
                if !user.email.isEmpty && !user.password.isEmpty{
                    saveUser()
                }
                showingAlert = true
            }, label: {
                Text("Validate").primaryButton()
            })
                .primaryStyle()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Validation"), message: Text(messageAlert), dismissButton: .default(Text("Close")))
                }
                
            // Show Attemps
            Button(action: {
                isPresentedAttempt.toggle()
            }, label: {
                Text("Show Attemps").secondaryButton()
            })
                .primaryStyle()
                .fullScreenCover(isPresented: $isPresentedAttempt, content: Attempt.init)
        }
        .padding()
    }
    
    func saveUser() {
        user.email = user.email.lowercased()
        if TaskManager.shared.checkUserCreated(user: user){
            TaskManager.shared.saveAttempt(user: user, success: true)
            messageAlert = "Successful validation, congratulations."
            UIApplication.shared.endEditing()
            user.email = ""
            user.password = ""
        } else {
            messageAlert = "Validation failed, user not found. Try again."
            TaskManager.shared.saveAttempt(user: user, success: false)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
