//
//  GroupView.swift
//  iPayment
//
//  Created by Alaa Khoury on 16/10/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupsView: BaseView {
    @EnvironmentObject var navigationModel: BaseNavigationModel

    @State var showGroupForm: Bool = false
    @State var showWarningDialog: Bool = false
    @State var createFormIsPresented: Bool = false
    @State var usersIsPresented: Bool = false

    @ObservedObject var viewModel = GroupsViewModel()

    var body: some View {
        LoadingView(isShowing: self.$viewModel.isLoading) {
            ScrollView {
                VStack {
                    if self.viewModel.groups.count > 0 {
                        listView
                    } else {
                        emptyView
                    }
                }
            }
            .onAppear {
                navigationModel.setLeadingNavigationBarItems(navigationBarItems:
                                                        AnyView(Button("Refresh") {
                    viewModel.loadGroups()
                }))

                navigationModel.setTrailingNavigationBarItems(navigationBarItems:
                                                        AnyView(Button("Create") {
                    self.showGroupForm = true
                }))

                viewModel.loadGroups()
            }

        }
        .sheet(
            isPresented: self.$showGroupForm,
            onDismiss: {
                viewModel.loadGroups()
            }) {
                GroupFormView()
            }
    }

    private var listView: some View {
        ForEach(self.viewModel.groups, id: \.self) { group in
            GroupItemView(group: group)
                .onTapGesture {
                    self.navigationModel.pushMain(view: GroupView(group: group))
                }
                .contextMenu {
                    contextMenu(group)
                }
                .alert(isPresented: self.$showWarningDialog, content: {
                    Alert(
                        title: Text("Remove Group"),
                        message: Text("Are you sure?"),
                        primaryButton: Alert.Button.default(Text("Yes")) {
                            viewModel.removeGroup(group.id)
                        },
                        secondaryButton: Alert.Button.cancel())
                })
                .sheet(isPresented: self.$createFormIsPresented, onDismiss: { self.createFormIsPresented = false }) {
                    CreatePaymentFormView(group: group, expenseType: self.viewModel.expenseType)
                }
                .sheet(isPresented: self.$usersIsPresented, onDismiss: { self.usersIsPresented = false }) {
                    GroupUsersView(group: group)
                }
        }
    }

    private var emptyView: some View {
        Group {
            Spacer(minLength: 50)
            Text("Create your first group")
        }
    }

    private func addExpenseContextMenu(_ group: GroupModel) -> some View {
        return Group {
            Button(action: {
                self.viewModel.expenseType = .expense
                self.createFormIsPresented = true
            }) {
                Image(systemName: "creditcard.fill")
                Text(ExpenseType.expense.rawValue)
            }

            if "Car" == group.data.type {
                Button(action: {
                    self.viewModel.expenseType = .service
                    self.createFormIsPresented = true
                }) {
                    Image(systemName: "wand.and.rays")
                    Text(ExpenseType.service.rawValue)
                }

                Button(action: {
                    self.viewModel.expenseType = .refueling
                    self.createFormIsPresented = true
                }) {
                    Image(systemName: "gauge")
                    Text(ExpenseType.refueling.rawValue)
                }
            }
        }
    }

    private func contextMenu(_ group: GroupModel) -> some View {
        return Group {
            Button(action: {}) {
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Add expense")
                }
            }
            .contextMenu {
                addExpenseContextMenu(group)
            }

            Divider()

            if group.usersId?.count ?? 0 > 1 && false {
                Button(action: {
                    self.usersIsPresented = true
                }) {
                    HStack {
                        Image(systemName: "person.3.sequence.fill")
                        Text("Users")
                    }
                }

                Divider()
            }

            Button(action: {
                self.viewModel.setFavorite(group.id, !group.isFavorite)
            }) {
                HStack {
                    Image(systemName: "star.fill")
                    if !group.isFavorite {
                        Text("Add to favorites")
                    } else {
                        Text("Remove from favorites")
                    }
                }
            }

            if group.permissions?.canDelete ?? false {
                Button(action: {
                    self.showWarningDialog = true
                }) {
                    HStack {
                        Image(systemName: "trash.slash.fill")
                        Text("Remove")
                    }
                }
            }
        }
    }
}

struct GroupItemView: View {
    let group: GroupModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(group.name)

                    Text(group.data.type)
                        .font(.caption)
                        .padding(.top, 2)
                        .foregroundColor(.gray)
                }
                Spacer()

                VStack(alignment: .trailing) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .opacity(group.isFavorite ? 1 : 0)

                    HStack {
                        Text("(\(group.getUsersCount()))")
                            .font(.caption)

                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                    }
                    .padding(.top, 1)
                    .opacity(group.getUsersCount() > 1 ? 1 : 0)

                    Text(TimeUtils.getDate(group.createdDate))
                        .font(.caption)
                        .padding(.top, 1)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            .background(Colors.white)

            Divider()
                .padding(.horizontal)
                .opacity(0.4)
        }
    }
}


struct GroupItemView_Previews: PreviewProvider {
    static var previews: some View {

        GroupItemView(group: GroupModel.create(name: "Test 1", isFavorite: true))
            .previewLayout(.sizeThatFits)
    }
}

//struct GroupsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupsView(
//            isLoading: false,
//            items: [
//                GroupModel.create(name: "Test 1", isFavorite: false),
//                GroupModel.create(name: "Test 2", isFavorite: false)
//            ])
//    }
//}
