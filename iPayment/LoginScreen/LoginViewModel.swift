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
        
    func performLogin(_ username: String, _ password: String, onError: @escaping (NSError) -> Void) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            
            
            guard let err = error as NSError? else {
                guard let result = authResult else { return }
                print(result)
                
                return
            }
            
            onError(err)
            
//            if err.code == AuthErrorCode.invalidEmail.rawValue {
//
//            }
            
        }
    }
    
}
