//
//  LoginView.swift
//  iPayment
//
//  Created by Alaa Khoury on 29/07/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                    
                Group {
                    TextField("Email", text: $email)
                        .modifier(DefaultTextField())
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .modifier(DefaultSecureField())
                }
                    .autocapitalization(.none)
                
                Rectangle()
                    .frame(height: 32)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    self.login()
                }, label: {
                    Text("Login")
                    })
                    .modifier(DefaultButton())
                
                Rectangle()
                    .frame(height: 16)
                    .foregroundColor(.white)
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Forgot your password?")
                            .font(.footnote)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Sign-up")
                            .font(.footnote)
                    })
                }
                
            }
            .frame(width: 300)
            .padding(.vertical, 32.0)
            .padding(.horizontal, 16.0)
            .navigationBarTitle("Login")
            
        }
    }
    
    func login() {
        viewModel.performLogin(self.email, self.password)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
