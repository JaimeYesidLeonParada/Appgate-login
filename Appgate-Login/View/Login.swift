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
                
                TextField("jaime.leon@gmail.com", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                
            }).padding(.top, 25.0)
            
            // Password
            VStack(alignment: .leading, spacing: 8.0, content: {
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("12345", text: $password)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 5.0)
                
            }).padding(.top, 20.0)
            
            // Forget password
            Button(action: {}, label: {
                Text("Forgot password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10.0)
            
            // Next Button
            Button(action: {}, label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 20.0, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.black))
                    .clipShape(Circle())
                    .shadow(color: Color(.blue).opacity(0.6), radius: 5.0, x: 0.0, y: 0.0)
            })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10.0)
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
