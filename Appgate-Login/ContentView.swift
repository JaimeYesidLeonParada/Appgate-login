//
//  ContentView.swift
//  Appgate-Login
//
//  Created by Jaime Yesid Leon Parada on 13/08/21.
//

import SwiftUI

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    @State var maxCircleHeight: CGFloat = 0.0
    
    var body: some View {
        VStack {
            // Something nice
            GeometryReader{proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    if maxCircleHeight == 0 {
                        maxCircleHeight = height
                    }
                }
                
                return AnyView(
                    ZStack {
                        Circle()
                            .fill(Color(.black))
                            .offset(x: getRect().width / 2.0, y: -height / 1.3)
                        
                        Circle()
                            .fill(Color(.black))
                            .offset(x: -getRect().width / 2.0, y: -height / 1.5)
                        
                        Circle()
                            .fill(Color(.blue))
                            .offset(y: -height / 1.3)
                            .rotationEffect(.init(degrees: -5.0))
                    }
                )
            }
            .frame(maxHeight: getRect().width)
            
            //Content
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
            .padding(.top, -maxCircleHeight / 1.8)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            HStack {
                Text("Already Member")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button(action: {}, label: {
                    Text("Sign in")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                })
            }, alignment: .bottom
        ).background(
            HStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 70.0, height: 70.0)
                    .offset(x: -30.0, y: 0.0)
                
                Spacer(minLength: 0.0)
                
                Circle()
                    .fill(Color.black)
                    .frame(width: 110.0, height: 110.0)
                    .offset(x: 40.0, y: 20.0)
                
            }
                .offset(y: getSafeArea().bottom + 30.0)
            
            , alignment: .bottom
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0 )
    }
}
