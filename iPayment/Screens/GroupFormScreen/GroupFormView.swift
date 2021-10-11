//
//  GroupFormView.swift
//  iPayment
//
//  Created by Alaa Khoury on 05/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupFormView: BaseView {
    @Environment(\.presentationMode) var showGroupForm
    
    @State private var groupName = ""
    @State private var searchedText = ""
    @State private var sharedGroup = false
    @State private var groupType: GroupType = GroupType.general

    @ObservedObject var viewModel = GroupFormViewModel()

    var body: some View {
        LoadingView(isShowing: self.$viewModel.isLoading) {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            TextField("Name", text: $groupName)
                        }

                        Section(header: Text("Group Details")) {
                            Toggle(isOn: self.$sharedGroup) {
                                Text("Shared group")
                            }

                            Picker(selection: $groupType, label: Text("Type")) {
                                ForEach(GroupType.allValues, id: \.self) {
                                    Text($0.rawValue).tag($0)
                                }
                            }
                        }

                        if self.$sharedGroup.wrappedValue {
                            Section(header: Text("Group Members")) {
                                TextField("Search", text: $searchedText)

                                VStack(alignment: .leading, spacing: 4) {
                                    ForEach(self.viewModel.users, id: \.self.userModel.uid) { user in
                                        UserItemView(user: user)
                                            .onTapGesture {
                                                viewModel.onUserSelected(uid: user.userModel.uid)
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Create Group")
                .navigationBarItems(trailing: getCreateButton)
            }
        }
    }

    private var getCreateButton: some View {
        Button(action: {
            viewModel.createGroup(
                groupName: self.groupName,
                isSharedGroup: self.sharedGroup,
                type: self.groupType.rawValue) {
                    self.showGroupForm.wrappedValue.dismiss()
                }

        }, label: {
            Text("Create")
        })
        .disabled(!self.isInformationValid())
    }

    private func isInformationValid() -> Bool {
        if groupName.isEmpty {
            return false
        }

//        if groupType == nil {
//            return false
//        }

        return true
    }
}

struct UserItemView: View {
    @ObservedObject var user: UserViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(user.userModel.firstName ?? "") \(user.userModel.lastName ?? "")")
                Text("\(user.userModel.email ?? "Email")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()

            if $user.isSelected.wrappedValue {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Colors.darkBlue)

            }
        }
        .padding(8)
        .background(Colors.white)
    }
}

enum GroupType: String {
    case general = "General"
    case home = "Home"
    case car = "Car"

    static let allValues: [GroupType] = [GroupType.general, GroupType.home, GroupType.car]
}

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {

        UserItemView(user: UserViewModel.create(firstName: "Alaa"))
            .previewLayout(.sizeThatFits)
    }
}

struct GroupFormView_Previews: PreviewProvider {
    static var previews: some View {
        GroupFormView()
            .previewLayout(.sizeThatFits)
    }
}
