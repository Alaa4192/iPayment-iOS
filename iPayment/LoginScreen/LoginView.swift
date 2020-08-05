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
                Text("Login")
                    .configAsTitle()
                    .padding(.bottom, 32)
                    
                Group {
                    TextField("Email", text: $email)
                        .modifier(DefaultTextField())
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .modifier(DefaultSecureField())
                }
                
                Button(action: {
                    self.login()
                }, label: {
                    Text("Login")
                    })
                .modifier(DefaultButton())
                
            }
            .frame(width: 300)
            .padding(.vertical, 32.0)
            .padding(.horizontal, 16.0)
            .cornerRadius(5)
            .border(Colors.darkBlue, width: 2)
            .cornerRadius(5)
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
