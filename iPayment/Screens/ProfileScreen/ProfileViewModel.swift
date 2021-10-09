//
//  ProfileViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 28/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI
import Firebase

class ProfileViewModel: BaseViewModel, ObservableObject {

    override init() {
        super.init()
    }

    func signOut() {
        do {
            try Auth.auth().signOut()

        } catch {

        }
    }

}
