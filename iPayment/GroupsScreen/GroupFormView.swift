//
//  GroupFormView.swift
//  iPayment
//
//  Created by Alaa Khoury on 05/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupFormView: BaseView {
    @State private var groupName = ""
    @State private var searchedText = ""
    @State private var sharedGroup = false
    @State private var groupType = "" // GroupType.allTypes[0]

    var viewModel = GroupFormViewModel()

    var body: some View {
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
                            ForEach(GroupType.allTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                    }

                    if self.$sharedGroup.wrappedValue {
                        Section(header: Text("Group Members")) {
                            TextField("Search", text: $searchedText)
                        }
                    }

                }
            }
            .navigationBarTitle("Create Group")
            .navigationBarItems(trailing: getCreateButton)
        }
    }

    private var getCreateButton: some View {
        Button(action: {
            print("Create Group")
        }, label: {
            Text("Create")
        })
        .disabled(!self.isInformationValid())
    }

    private func isInformationValid() -> Bool {
        if groupName.isEmpty {
            return false
        }

        if groupType.isEmpty {
            return false
        }

        return true
    }
}

struct GroupType {
    static let allTypes = [
        "General",
        "Home",
        "Car"
    ]
}

struct GroupFormView_Previews: PreviewProvider {
    static var previews: some View {
        GroupFormView()
    }
}
