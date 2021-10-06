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
