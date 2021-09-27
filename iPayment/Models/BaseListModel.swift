//
//  ListModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 26/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

struct BaseListModel<T: Decodable>: Decodable {
    var count: Int
    var items: Array<T>

    enum CodingKeys: String, CodingKey {
        case count
        case items
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decode(Int.self, forKey: .count)
        self.items = try values.decode(Array<T>.self, forKey: .items)
    }
}

