//
//  GroupFormViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 06/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

class GroupFormViewModel: BaseViewModel {

    @Published public var users: Array<UserViewModel> = Array()

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
    
}
