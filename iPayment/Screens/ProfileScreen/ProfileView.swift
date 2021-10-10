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
    @EnvironmentObject var userSession: UserSession

    @ObservedObject var viewModel = ProfileViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            if self.$viewModel.userProfile.wrappedValue != nil {
                HStack {
                    Text(self.viewModel.userProfile?.firstName.wrappedValue ?? "")
                    Text(self.viewModel.userProfile?.lastName.wrappedValue ?? "")
                }

                Text("Groups: \(self.viewModel.userProfile?.groupsCount.wrappedValue ?? 0)")
                    .padding(.top, 8)
            }

            Spacer()

            Group {
                Button(action: {
                    viewModel.signOut {
                        userSession.session = nil
                    }
                }, label: {
                    Text("Sign out")
                })
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
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
