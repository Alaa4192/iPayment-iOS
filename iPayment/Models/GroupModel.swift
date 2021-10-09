//
//  Group.swift
//  iPayment
//
//  Created by Alaa Khoury on 26/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

struct GroupData: Codable, Hashable {
    var isShared: Bool
    var type: String

    static func create() -> GroupData {
        return GroupData(isShared: false, type: "CAR")
    }
}

struct Permissions: Codable, Hashable {
    var canDelete: Bool
}

struct GroupModel: Codable, Hashable {
    var id: String
    var name: String
    var data: GroupData
    var isFavorite: Bool
    var isDeleted: Bool
    var createdDate: Int64?
    var usersId: Array<String>?
    var adminsId: Array<String>?

    var permissions: Permissions?

    static func create(name: String, isFavorite: Bool) -> GroupModel {
        return GroupModel(
            id: "ID",
            name: name,
            data: GroupData.create(),
            isFavorite: isFavorite,
            isDeleted: false,
            createdDate: 0,
            usersId: [],
            adminsId: []
        )
    }

    func getUsersCount() -> Int {
        return usersId!.count
    }
}

struct CreateGroup: Codable {
    let name: String
    let usersId: Array<String>
    let isShared: Bool
    let type: String
}

struct CreateGroupResponse: Codable {
    var id: String
}

struct SetGroupFavoriteRequest: Codable {
    var id: String
    var isFavorite: Bool
}

struct SetGroupFavoriteResponse: Codable {
    var id: String
}

struct RemoveGroupRequest: Codable {
    var id: String
}

struct RemoveGroupResponse: Codable {
    var id: String
}
