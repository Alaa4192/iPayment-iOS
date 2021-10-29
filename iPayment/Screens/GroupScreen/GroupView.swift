//
//  GroupView.swift
//  iPayment
//
//  Created by Alaa Khoury on 28/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupView: BaseView {
    var group: GroupModel

    @ObservedObject var viewModel = GroupViewModel()

    @State var usersIsPresented: Bool = false
    @State var infoIsPresented: Bool = false
    @State var createFormIsPresented: Bool = false
    @State var addExpenseMenuIsPresented: Bool = false

    var body: some View {
        FullScreenView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(group.name)
                            .font(.custom("SomeTitle", size: 20))
                            .fontWeight(.bold)

                        Text(group.data.type)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                    GroupIconView(name: group.name)
                }

                HStack {
                    if group.usersId?.count ?? 0 > 1 {
                        Spacer()
                        ItemView(text: "Users", imageSystemName: "person.3.sequence.fill") {
                            self.usersIsPresented = true
                        }
                    }

                    Spacer()
                    ItemView(text: "Info", imageSystemName: "chart.bar.fill") {
                        self.infoIsPresented = true
                    }
                    Spacer()
                }
                .padding(.top)

                Divider()

                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(self.viewModel.expenses, id: \.id) { expense in
                            ExpenseItemView(expense: expense)
                        }
                    }
                }

                Divider()

                Button(action: {
                    self.addExpenseMenuIsPresented = true
                }) {
                    Text("Add Expense")
                }
                .modifier(InverseButton(isWide: true))

            }
            .onAppear {
                self.viewModel.loadExpenses(group.id)
            }
        }
        .sheet(isPresented: self.$usersIsPresented, onDismiss: { self.usersIsPresented = false }) {
            GroupUsersView(group: self.group)
        }
        .sheet(isPresented: self.$infoIsPresented, onDismiss: { self.infoIsPresented = false }) {
            GroupInfoView(group: self.group)
        }
        .sheet(isPresented: self.$createFormIsPresented, onDismiss: { self.createFormIsPresented = false }) {
            CreatePaymentFormView(group: group, expenseType: self.viewModel.expenseType)
        }
        .actionSheet(isPresented: self.$addExpenseMenuIsPresented, content: {
            ActionSheet(
                title: Text("Add Expense"),
                buttons: getAddExpenseButtons(group)
            )
        })
    }

    private func getAddExpenseButtons(_ group: GroupModel) -> [ActionSheet.Button] {
        var buttons = [
            ActionSheet.Button.default(Text("Expense")) {
                viewModel.expenseType = .expense
                self.createFormIsPresented = true
            }
        ]

        if "Car" == group.data.type {
            buttons.append(ActionSheet.Button.default(Text("Service")) {
                viewModel.expenseType = .service
                self.createFormIsPresented = true
            })

            buttons.append(ActionSheet.Button.default(Text("Refueling")) {
                viewModel.expenseType = .refueling
                self.createFormIsPresented = true
            })
        }

        buttons.append(ActionSheet.Button.cancel())
        return buttons
    }
}

struct GroupIconView: View {
    let name: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Colors.darkBlue)
                .frame(width: 70, height: 70, alignment: .center)

            Circle()
                .foregroundColor(Colors.white)
                .frame(width: 64, height: 64, alignment: .center)

            Text(getInitial())
                .foregroundColor(Colors.darkBlue)
                .font(.title)
                .fontWeight(.bold)
        }
    }

    private func getInitial() -> String {
        let firstLetter = self.name.first?.uppercased() ?? ""

        return "\(firstLetter)"
    }
}

struct ItemView: View {
    let text: String
    let imageSystemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageSystemName)
                Text(text)
                    .padding(.top, 2)
                    .font(.caption)
            }
        }
        .foregroundColor(Colors.black)
    }
}

struct ExpenseItemView: View {
    let expense: ExpenseModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(expense.title ?? "Title")

                    Text("₪ \(expense.price.roundToTwoDecimals())")
                        .font(.caption)
                        .padding(.top, 2)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(expense.getType())

                    Text(TimeUtils.getDate(expense.creationDate))
                        .font(.caption)
                        .padding(.top, 2)
                }
            }
            .padding(.vertical, 4)

            Divider()
                .opacity(0.4)

        }
        
    }
}


