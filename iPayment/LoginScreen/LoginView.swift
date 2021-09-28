//
//  LoginView.swift
//  iPayment
//
//  Created by Alaa Khoury on 29/07/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: BaseView {
    @State var email: String = ""
    @State var password: String = ""
    @State var hintText: String = ""
    @State var hintColor: Color = .red
    @State var isLoading: Bool = true
    @State var isAlreadyLoggedIn: Bool = false
    
    var viewModel = LoginViewModel()
        
    var body: some View {
        if !$isAlreadyLoggedIn.wrappedValue {
            LoadingView(isShowing: .constant($isLoading.wrappedValue)) {
                NavigationView {
                    VStack(alignment: .center) {
                        Group {
                            TextField("Email", text: $email)
                                .modifier(DefaultTextField())
                                .keyboardType(.emailAddress)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            SecureField("Password", text: $password)
                                .modifier(DefaultSecureField())
                            
                            Text($hintText.wrappedValue)
                                .foregroundColor(hintColor)
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
                    .onAppear(perform: {
                        print("LoginView", "loginIsNeeded")
                        viewModel.loginIsNeeded(onResult: { isNeeded in
                            self.isAlreadyLoggedIn = !isNeeded
                            self.isLoading = !isNeeded
                        })
                    })
                }
            }
        } else {
            MainView()
        }
    }
    
    func login() {
        self.isLoading = true
        viewModel.performLogin(self.email, self.password,
                               onError: { error in
                                self.isLoading = false
                                
                                switch error.code {
                                case AuthErrorCode.invalidEmail.rawValue:
                                    hintText = "Invalid email"
                                    
                                case AuthErrorCode.wrongPassword.rawValue:
                                    hintText = "Invalid email or password"
                                    
                                case AuthErrorCode.userNotFound.rawValue:
                                    hintText = "Invalid email or password"
                                    
                                default:
                                    hintText = "Error"
                                }
                               },
                               onSuccess: {
                                self.isLoading = false
                                self.isAlreadyLoggedIn = true
                               }
        )
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
