//
//  ProfileView.swift
//  iPayment
//
//  Created by Alaa Khoury on 28/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Button(action: {
                do {
                    try Auth.auth().signOut()
                } catch {

                }
            }, label: {
                Text("Sign out")
            })

            .navigationBarTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
