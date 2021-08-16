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
    
    
    private var taskManager = TaskManager.shared
    
    var body: some View {
        VStack{
            // Sign In
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .kerning(2.0)
                .frame(maxWidth: .infinity,  alignment: .leading)
            
            // User name
            VStack(alignment: .leading, spacing: 8.0, content: {
                Text("User Name")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("Email", text: $user.email)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                
            }).padding(.top, 25.0)
            
            // Password
            VStack(alignment: .leading, spacing: 8.0, content: {
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("Password", text: $user.password)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                
            }).padding(.top, 20.0)
            
            // Validate account
            Button(action: {
                messageAlert = "Verify that the data is not empty and try again."
                
                if !user.email.isEmpty && !user.password.isEmpty{
                    if taskManager.checkUserCreated(user: user){
                        messageAlert = "Successful validation, congratulations."
                        user.email = ""
                        user.password = ""
                        UIApplication.shared.endEditing()
                        taskManager.saveAttempt(user: user, success: true)
                    } else {
                        messageAlert = "Validation failed, user not found. Try again."
                        taskManager.saveAttempt(user: user, success: false)
                    }
                }
                showingAlert = true
            }, label: {
                Text("Validate")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .font(.system(size: 20.0, weight: .semibold))
            })
                .clipShape(Capsule())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10.0)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Validation"), message: Text(messageAlert), dismissButton: .default(Text("Close")))
                }
                
            // Show Attemps
            Button(action: {
                isPresentedAttempt.toggle()
            }, label: {
                Text("Show Attemps")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.system(size: 20.0, weight: .bold))
            })
                .clipShape(Capsule())
                .frame(maxWidth: .infinity, alignment: .bottom)
                .padding(.top, 100.0)
            
                .fullScreenCover(isPresented: $isPresentedAttempt, content: Attempt.init)
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
