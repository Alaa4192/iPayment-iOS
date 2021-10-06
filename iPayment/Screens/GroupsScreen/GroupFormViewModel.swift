//
//  GroupFormViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 06/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

class GroupFormViewModel: BaseViewModel {

    @Published public var users: Array<UserModel> = Array()

    override init() {
        super.init()

        UsersRepository().getUsers { result in
            self.users = result.items
        }
    }
    
}
