//
//  Login.swift
//  Login
//
//  Created by Jaime Yesid Leon Parada on 13/08/21.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var password = ""
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
                
                TextField("Email", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                
            }).padding(.top, 25.0)
            
            // Password
            VStack(alignment: .leading, spacing: 8.0, content: {
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("Password", text: $password)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                
            }).padding(.top, 20.0)
            
            // Validate account
            Button(action: {
                if !email.isEmpty && !password.isEmpty{
                    let user = User(email: email, password: password)
                    if taskManager.checkUserCreated(user: user){
                        print("Si seññooorrrrr")
                        email = ""
                        password = ""
                        UIApplication.shared.endEditing()
                    } else {
                        print("Usuario no creado")
                    }
                }
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
