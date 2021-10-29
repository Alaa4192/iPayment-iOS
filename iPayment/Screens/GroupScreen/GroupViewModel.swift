//
//  File.swift
//  iPayment
//
//  Created by Alaa Khoury on 28/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

class GroupViewModel: BaseViewModel, ObservableObject {

    var expenseType: ExpenseType = .defaultType

    @Published var expenses = Array<ExpenseModel>()

    func loadExpenses(_ groupId: String) {
        ExpensesRepository().getExpenses(request: GetGroupExpensesRequest(groupId: groupId)) { expenses in
            self.expenses = expenses.items
        }
    }
}
