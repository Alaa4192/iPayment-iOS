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
        
    func performLogin(_ username: String, _ password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if error != nil {
                
            }
            if authResult != nil {
                
            } else {
                
            }
        }
    }
    
}
