//
//  GroupFormViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 06/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

class GroupFormViewModel: BaseViewModel, ObservableObject {
    @Published public var users: Array<UserViewModel> = Array()
    @Published var isLoading: Bool = false

    override init() {
        super.init()

        UsersRepository().getUsers { result in
            self.users = result.items.map { $0.convert()}
        }
    }

    func onUserSelected(uid: String) {
        if var userViewModel = users.first(where: { $0.userModel.uid == uid }) {
            userViewModel.isSelected.toggle()
        }

    }

    func createGroup(groupName: String, isSharedGroup: Bool, type: String, onSuccess: @escaping () -> Void) {
        isLoading = true
        let usersId = self.users.filter({ $0.isSelected }).map { $0.userModel.uid }

        GroupsRepository().createGroup(
            group: CreateGroup(name: groupName, usersId: usersId, isShared: isSharedGroup, type: type)) { _ in
                self.isLoading = false

                onSuccess()
            }
    }
}
