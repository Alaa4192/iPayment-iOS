//
//  ExpenseModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 29/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

struct ExpenseModel: Codable, Hashable {

    var id: String
    var title: String?
    var groupId: String
    var price: Double
    var isDeleted: Bool
    var note: String
    var odometer: Double
    var creationDate: Int64
    var type: String
    var users: Array<String>


    func getType() -> String {
        return ExpenseType.init(rawValue: type.lowercased().capitalized)?.rawValue ?? "Default"
    }
}

enum ExpenseType: String, Codable {
    case defaultType = "Default"
    case refueling = "Refueling"
    case service = "Service"
    case expense = "Expense"
}

struct GetGroupExpensesRequest: Codable {
    var groupId: String
}
