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
    @EnvironmentObject var navigationModel: BaseNavigationModel
    
    var body: some View {
        Button(action: {
            do {
                try Auth.auth().signOut()
            } catch {

            }
        }, label: {
            Text("Sign out")
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
