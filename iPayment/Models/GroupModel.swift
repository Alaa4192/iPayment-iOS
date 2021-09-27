//
//  Group.swift
//  iPayment
//
//  Created by Alaa Khoury on 26/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

struct GroupModel: Codable, Hashable {
    var id: String
    var name: String
    var isFavorite: Bool
    var usersId: Array<String>?

    static func create(name: String, isFavorite: Bool) -> GroupModel {
        return GroupModel(id: "ID", name: name, isFavorite: isFavorite, usersId: [])
    }
}

