//
//  ContentView.swift
//  Appgate-Login
//
//  Created by Jaime Yesid Leon Parada on 13/08/21.
//

import SwiftUI

struct Home: View {
   
    @State var maxCircleHeight: CGFloat = 0.0
    @State var showSignUp = false
    
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
            ZStack {
                if showSignUp {
                    SignUp()
                        .transition(.move(edge: .trailing))
                } else {
                    Login()
                        .transition(.move(edge: .trailing))
                }
            }
            
            .padding(.top, -maxCircleHeight / (getRect().height < 750 ? 1.5 : 1.6))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            HStack {
                Text(showSignUp ? "New Member" : "Already Member")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button(action: {
                    withAnimation{
                        showSignUp.toggle()
                    }
                }, label: {
                    Text(showSignUp ? "Sign In" : "Sign up")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                })
            }
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 0)
            
            , alignment: .bottom
        )
        .background(
            HStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 70.0, height: 70.0)
                    .offset(x: -30.0, y: getRect().height < 750 ? 10 : 0)
                
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
        Home()
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
