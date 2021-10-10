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
    @Published var userProfile: Binding<UserProfileModel>? = nil


    override init() {
        super.init()

        self.loadProfile()
    }

    func signOut(onSuccess: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch {

        }
    }

    private func loadProfile() {
        UsersRepository().getUserProfile { result in
            self.userProfile = .constant(result)
        }
    }

}
