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
                    Button {
                        self.viewModel.setFavorite(group.id, !group.isFavorite)
                    } label: {
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
                        Button {
                            self.showWarningDialog = true
                        } label: {
                            HStack {
                                Image(systemName: "trash.slash.fill")
                                Text("Remove")
                            }
                        }
                    }
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
        }
    }

    private var emptyView: some View {
        Group {
            Spacer(minLength: 50)
            Text("Create your first group")
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
                    HStack {
                        Group {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)

                            Text("(\(group.getUsersCount()))")
                                .font(.caption)
                        }
                        .opacity(group.getUsersCount() > 1 ? 1 : 0)

                        if group.isFavorite {
                            Image(systemName: "star.fill")
                        }
                    }

                    Text(getDate(group.createdDate))
                        .font(.caption)
                        .padding(.top, 2)
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

    private func getDate(_ createdDate: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        let time = Double(createdDate / 1000)

        return dateFormatter.string(from: Date(timeIntervalSince1970: time))
    }
}


struct GroupItemView_Previews: PreviewProvider {
    static var previews: some View {

        GroupItemView(group: GroupModel.create(name: "Test 1", isFavorite: false))
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
