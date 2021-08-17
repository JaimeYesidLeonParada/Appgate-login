//
//  SignUp.swift
//  SignUp
//
//  Created by Jaime Yesid Leon Parada on 13/08/21.
//

import SwiftUI

struct SignUp: View {
    @State var user = User(email: "", password: "")
    @State var confirmPassword = ""
    @State var emailAlert = ""
    @State var passwordAlert = ""
    @State var confirmPasswordAlert = ""
    @State var showingAlert = false
    @State var messageAlert = ""
    
    var body: some View {
        VStack{
            Text("Sign Up").headerStyle()
            VStack(alignment: .leading, spacing: 4.0, content: {
                HStack{
                    Text("User Name").labelStyle()
                    Text(emailAlert).alertStyle()
                }
                
                TextField("Email", text: $user.email)
                    .emailStyle()
                    .onChange(of: user.email){ newValue in
                        emailAlert = ""
                        if !newValue.isValidEmail && !newValue.isEmpty {
                            emailAlert = "Insert a valid email"
                        }
                    }
            }).padding(.top, 20.0)
            
            // Password
            VStack(alignment: .leading, spacing: 4.0, content: {
                HStack{
                    Text("Password").labelStyle()
                    Text(passwordAlert).alertStyle()
                }
                
                SecureField("Password", text: $user.password)
                    .passwordStyle()
                    .onChange(of: user.password) { newValue in
                        passwordAlert = ""
                        
                        if !newValue.isValidPassword && !newValue.isEmpty {
                            passwordAlert = "At least 8 characters, uppercase, lowercase,numbers and special characters"
                        }
                    }
            }).padding(.top, 5.0)
            
            // Confirm Password
            VStack(alignment: .leading, spacing: 4.0, content: {
                HStack{
                    Text("Confirm Password").labelStyle()
                    Text(confirmPasswordAlert).alertStyle()
                }
                
                SecureField("Password", text: $confirmPassword)
                    .passwordStyle()
                    .onChange(of: confirmPassword) { newValue in
                        if newValue.isEmpty { return }
                        if confirmPassword == user.password {
                            confirmPasswordAlert = "✅"
                        } else {
                            confirmPasswordAlert = "Need to match"
                        }
                    }
            }).padding(.top, 5.0)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            // Next Button
            Button(action: {
                messageAlert = "Verify that the data is not empty and try again."
                if user.email.isValidEmail && user.password.isValidPassword && user.password == confirmPassword {
                    createUser()
                }
                showingAlert = true
            }, label: {
                Text("Create Account").primaryButton()
            })
                .primaryStyle()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Validation"), message: Text(messageAlert), dismissButton: .default(Text("Close")))
                }
        }
        .padding()
    }
    
    func createUser(){
        user.email = user.email.lowercased()
        TaskManager.shared.createUser(user: user)
        user.email = ""
        user.password = ""
        confirmPassword = ""
        emailAlert = ""
        passwordAlert = ""
        confirmPasswordAlert = ""
        
        UIApplication.shared.endEditing()
        
        messageAlert = "User created successfully, congratulations."
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
