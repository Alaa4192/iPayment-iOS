//
//  CreatePaymentFormView.swift
//  iPayment
//
//  Created by Alaa Khoury on 16/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct CreatePaymentFormView: BaseView {
    var group: GroupModel
    var expenseType: ExpenseType = .defaultType

    @State private var price = ""
    @State private var liters = ""
    @State private var priceLiter = ""
    @State private var odometer = ""
    @State private var note = ""
    @State private var service = ""
    @State private var expense = ""

    var viewModel = CreatePaymentFormViewModel()

    var body: some View {
        FullScreenFormView(actionButton: actionButton) {
            mainSection(type: expenseType)
            additionlInfoSection(type: expenseType)
        }
    }

    private var actionButton: Button<Text> {
        return Button(action: { }, label: { Text("Add") })
    }

    private func mainSection(type: ExpenseType) -> some View {
        return Section(header: Text(type.rawValue)) {
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)

            switch type {
            case ExpenseType.refueling:
                HStack {
                    TextField("Liters", text: $liters)
                        .keyboardType(.decimalPad)

                    Divider()

                    TextField("Price/Liter", text: $priceLiter)
                        .keyboardType(.decimalPad)
                }

                TextField("Odometer", text: $odometer)
                    .keyboardType(.decimalPad)

            case ExpenseType.service:
                TextField("Service", text: $service)
                    .keyboardType(.decimalPad)

                TextField("Odometer", text: $odometer)
                    .keyboardType(.decimalPad)

            case ExpenseType.expense:
                TextField("Expense", text: $expense)
                    .keyboardType(.decimalPad)

                TextField("Odometer", text: $odometer)
                    .keyboardType(.decimalPad)

            default:
                Group {}
            }
        }
    }

    private func additionlInfoSection(type: ExpenseType) -> some View {
        return Section(header: Text("Additional Info")) {
                TextField("Note", text: $note)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)

                HStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
            }
        }
    }
}

enum ExpenseType: String {
    case defaultType = "Default"
    case refueling = "Refueling"
    case service = "Service"
    case expense = "Expense"
}

struct CreatePaymentFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePaymentFormView(group: GroupModel.create(name: "Test", isFavorite: false))
    }
}
