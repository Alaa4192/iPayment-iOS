//
//  UserProfileModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 10/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

struct UserProfileModel: Codable, Hashable {
    var firstName: String
    var lastName: String
    var groupsCount: Int
}
