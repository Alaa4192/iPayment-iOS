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

    @State var isLoading: Bool = true
    @State var items: Array<GroupModel> = Array()
    @State var showGroupForm: Bool = false

    var viewModel = GroupsViewModel()

    var body: some View {
        LoadingView(isShowing: .constant($isLoading.wrappedValue)) {
            ScrollView {
                VStack {
                    ForEach(items, id: \.self) { group in
                        GroupItemView(group: group)
                            .onTapGesture {
                                self.navigationModel.pushMain(view: GroupView(group: group))
                            }
                    }
                }
            }
            .onAppear {
                navigationModel.setNavigationBarItems(navigationBarItems:
                                                        AnyView(Button("Create") {
                                                            self.showGroupForm = true
                                                        })
                )

                loadGroups()
            }
        }
        .sheet(
            isPresented: self.$showGroupForm,
            onDismiss: {
                isLoading = true
                loadGroups()
            }) {
                GroupFormView()
            }
    }

    private func loadGroups() {
        viewModel.loadGroups { groups in
            isLoading = false
            items = groups
        }
    }
}

struct GroupItemView: View {
    let group: GroupModel

    var body: some View {
        HStack {
            Text(group.name)
            Spacer()

            if group.isFavorite {
                Image(systemName: "star.fill")
            }

            Image(systemName: "person.fill")
            Text("(\(group.getUsersCount()))")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
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
