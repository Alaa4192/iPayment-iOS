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

    @State private var price = ""
    @State private var liters = ""
    @State private var priceLiter = ""
    @State private var odometer = ""
    @State private var note = ""

    var viewModel = CreatePaymentFormViewModel()

    var body: some View {
        FullScreenFormView(actionButton: actionButton) {
            mainSection(type: group.data.type)
            additionlInfoSection(type: group.data.type)
        }
    }

    private var actionButton: Button<Text> {
        return Button(action: { }, label: { Text("Add") })
    }

    private func mainSection(type: String) -> some View {
        return Section(header: Text("Refueling")) {
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)

            HStack {
                TextField("Liters", text: $liters)
                    .keyboardType(.decimalPad)

                Divider()

                TextField("Price/Liter", text: $priceLiter)
                    .keyboardType(.decimalPad)
            }

            TextField("Odometer", text: $odometer)
                .keyboardType(.decimalPad)
        }
    }

    private func additionlInfoSection(type: String) -> some View {
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

struct CreatePaymentFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePaymentFormView(group: GroupModel.create(name: "Test", isFavorite: false))
    }
}
