//
//  SignUp.swift
//  SignUp
//
//  Created by Jaime Yesid Leon Parada on 13/08/21.
//

import SwiftUI

struct SignUp: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var emailAlert = ""
    @State var passwordAlert = ""
    @State var confirmPasswordAlert = ""
    @State var isPresentedAttempt = false
    
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
            VStack(alignment: .leading, spacing: 8.0, content: {
                HStack{
                    Text("User Name")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text(emailAlert)
                        .font(.system(size: 12.0, weight: .bold))
                        .foregroundColor(.red)
                        .padding()
                }
                
                TextField("Email", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                    .onChange(of: email){ newValue in
                        emailAlert = ""
                        
                        if !newValue.isValidEmail{
                            emailAlert = "Insert a valid email"
                        }
                    }
                
            }).padding(.top, 25.0)
            
            // Password
            VStack(alignment: .leading, spacing: 8.0, content: {
                HStack{
                    Text("Password")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text(passwordAlert)
                        .foregroundColor(.red)
                        .font(.system(size: 12.0, weight: .bold))
                        .padding()
                }
                
                SecureField("Password", text: $password)
                    .font(.system(size: 20.0, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                    .onChange(of: password) { newValue in
                        passwordAlert = ""
                        
                        if !newValue.isValidPassword {
                            passwordAlert = "At least 8 characters, uppercase, lowercase,numbers and special characters"
                        }
                    }
                
            }).padding(.top, 20.0)
            
            // Confirm Password
            VStack(alignment: .leading, spacing: 8.0, content: {
                HStack{
                    Text("Confirm Password")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text(confirmPasswordAlert)
                        .font(.system(size: 16.0, weight: .bold))
                        .foregroundColor(.red)
                        .padding()
                }
                
                SecureField("Password", text: $confirmPassword)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                    .onChange(of: confirmPassword) { newValue in
                        if confirmPassword == password{
                            confirmPasswordAlert = "✅"
                        } else {
                            confirmPasswordAlert = "Need to match"
                        }
                    }
                
            }).padding(.top, 20.0)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10.0)
            
            // Next Button
            Button(action: {
                isPresentedAttempt.toggle()
            }, label: {
                Text("Create Account")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .font(.system(size: 20.0, weight: .semibold))
            })
                .clipShape(Capsule())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 20.0)
                .fullScreenCover(isPresented: $isPresentedAttempt, content: Attempt.init)

        }
        .padding()
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
