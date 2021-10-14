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
        VStack {
            if self.$viewModel.userProfile.wrappedValue != nil {
                Group {
                    VStack {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("Welcome back,")
                                    .font(.headline)
                                Text("\(self.viewModel.userProfile?.firstName.wrappedValue ?? "")!")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top, 1)
                            }
                            Spacer()

                            ProfileIconView(
                                firstName: self.viewModel.userProfile?.firstName.wrappedValue,
                                lastName: self.viewModel.userProfile?.lastName.wrappedValue
                            )
                        }

                        HStack {
                            SubItemView(key: "Groups", value: "\(self.viewModel.userProfile?.groupsCount.wrappedValue ?? 0)")
                        }
                        .padding(.top, 32)

                        Divider()
                            .padding(.top, 4)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }

            Spacer()

            SignoutView(viewModel: viewModel, userSession: userSession)
        }
        .onAppear {
            navigationModel.clearNavigationsBarItems()
        }
    }
}

struct SubItemView: View {
    let key: String
    let value: String

    var body: some View {
        VStack {
            Text(value)
                .fontWeight(.medium)
            Text(key)
                .font(.caption)
                // .padding(.top)
        }
    }
}

struct ProfileIconView: View {
    let firstName: String?
    let lastName: String?

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Colors.darkBlue)
                .frame(width: 70, height: 70, alignment: .center)

            Circle()
                .foregroundColor(Colors.white)
                .frame(width: 64, height: 64, alignment: .center)

            Text(getInitials())
                .foregroundColor(Colors.darkBlue)
                .font(.title)
                .fontWeight(.bold)
        }
    }

    private func getInitials() -> String {
        let firstLetter = self.firstName?.first?.uppercased() ?? ""
        let secondLetter = self.lastName?.first?.uppercased() ?? ""

        return "\(firstLetter)\(secondLetter)"
    }
}

struct SignoutView: View {
    let viewModel: ProfileViewModel
    let userSession: UserSession

    @State var showWarningDialog: Bool = false

    var body: some View {
        Group {
            Button(action: {
                self.showWarningDialog = true

            }, label: {
                Text("Sign out")
            })
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .alert(isPresented: self.$showWarningDialog) {
            Alert(
                title: Text("Sign out"),
                message: Text("Are you sure?"),
                primaryButton: Alert.Button.default(Text("Yes")) {
                    viewModel.signOut {
                        userSession.session = nil
                    }
                },
                secondaryButton: Alert.Button.cancel())
        }
    }
}

struct SubItemView_Previews: PreviewProvider {
    static var previews: some View {
        SubItemView(key: "Groups", value: "80")
            .previewLayout(.sizeThatFits)
    }
}

struct ProfileIconView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileIconView(firstName: "Alaa", lastName: "Khoury")
            .previewLayout(.sizeThatFits)
    }
}


//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
