//
//  LoginViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 06/08/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI
import Firebase

class LoginViewModel: BaseViewModel {
    
    func loginIsNeeded(_ userSession: UserSession, onResult: @escaping (_ isNeeded: Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let user = Auth.auth().currentUser
            
            if user != nil {
                print("LoginViewModel", "loginIsNeeded", false)
                onResult(false)

                DispatchQueue.main.async {
                    userSession.session = user?.uid
                }

            } else {
                print("LoginViewModel", "loginIsNeeded", true)
                onResult(true)

                DispatchQueue.main.async {
                    userSession.session = nil
                }
            }
        }
    }
    
    func performLogin(_ userSession: UserSession, _ username: String, _ password: String, onError: @escaping (NSError) -> Void, onSuccess: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            
            
            guard let err = error as NSError? else {
                guard let result = authResult else { return }
                
                print("result", result)

                userSession.session = result.user.uid

                onSuccess()
                return
            }
            print("LoginViewModel", err)
            onError(err)
        }
    }
    
}
