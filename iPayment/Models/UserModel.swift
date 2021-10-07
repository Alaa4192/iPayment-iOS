//
//  UserModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 06/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation
import SwiftUI

struct UserModel: Codable, Hashable {
    var uid: String
    var firstName: String?
    var lastName: String?
    var email: String?

    static func create(firstName: String) -> UserModel {
        return UserModel(uid: "UID", firstName: firstName, lastName: "Last Name", email: "Email")
    }
}

//struct UserViewModel: Codable, Hashable {
//    var userModel: UserModel
//    var isSelected: Bool
//
//    static func create(firstName: String) -> UserViewModel {
//        return UserViewModel(
//            userModel: UserModel(uid: "UID", firstName: firstName, lastName: "Last Name", email: "Email"),
//            isSelected: true)
//    }
//}

class UserViewModel : ObservableObject {

    @Published var userModel: UserModel
    @Published var isSelected: Bool

    init(userModel: UserModel) {
        self.userModel = userModel
        self.isSelected = false
    }

    static func create(firstName: String) -> UserViewModel {
        return UserViewModel(userModel: UserModel.create(firstName: "Alaa"))
    }
}

extension UserModel {
    func convert() -> UserViewModel {
        return UserViewModel(userModel: self)
    }
}
