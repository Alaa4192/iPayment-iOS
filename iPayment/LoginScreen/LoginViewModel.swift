//
//  LoginViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 06/08/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI
import Firebase

class LoginViewModel {
    
    func performLogin(_ username: String, _ password: String, onError: @escaping (NSError) -> Void, onSuccess: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            
            
            guard let err = error as NSError? else {
                guard let result = authResult else { return }
                
                onSuccess()
                return
            }
            print("LoginViewModel", err)
            onError(err)
        }
    }
    
}
