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
            // Sign In
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .kerning(2.0)
                .frame(maxWidth: .infinity,  alignment: .leading)
            
            // User name
            VStack(alignment: .leading, spacing: 4.0, content: {
                HStack{
                    Text("User Name")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text(emailAlert)
                        .font(.system(size: 10.0, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.red)
                        .padding()
                }
                
                TextField("Email", text: $user.email)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .onChange(of: user.email){ newValue in
                        emailAlert = ""
                        
                        if !newValue.isValidEmail && !newValue.isEmpty {
                            emailAlert = "Insert a valid email"
                        }
                    }
            }).padding(.top, 5.0)
            
            // Password
            VStack(alignment: .leading, spacing: 4.0, content: {
                HStack{
                    Text("Password")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text(passwordAlert)
                        .foregroundColor(.red)
                        .font(.system(size: 10.0, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                
                SecureField("Password", text: $user.password)
                    .font(.system(size: 20.0, weight: .semibold))
                    .foregroundColor(Color.black)
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
                    Text("Confirm Password")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text(confirmPasswordAlert)
                        .font(.system(size: 10.0, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.red)
                        .padding()
                }
                
                SecureField("Password", text: $confirmPassword)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
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
                showingAlert = true
            }, label: {
                Text("Create Account")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .font(.system(size: 20.0, weight: .semibold))
            })
                .clipShape(Capsule())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Validation"), message: Text(messageAlert), dismissButton: .default(Text("Close")))
                }
        }
        .padding()
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
