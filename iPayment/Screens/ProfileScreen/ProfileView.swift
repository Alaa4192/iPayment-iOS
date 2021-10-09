//
//  ProfileView.swift
//  iPayment
//
//  Created by Alaa Khoury on 28/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct ProfileView: BaseView {
    @EnvironmentObject var navigationModel: BaseNavigationModel

    @ObservedObject var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            Spacer()

            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign out")
            })
            .padding()
        }
        .onAppear {
            navigationModel.clearNavigationsBarItems()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
