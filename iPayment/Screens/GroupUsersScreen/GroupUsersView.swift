//
//  GroupUsersView.swift
//  iPayment
//
//  Created by Alaa Khoury on 15/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupUsersView: BaseView {
    var group: GroupModel

    @ObservedObject var viewModel = GroupUsersViewModel()

    var body: some View {
         LoadingView(isShowing: self.$viewModel.isLoading) {
            VStack(alignment: .leading) {
                UsersView(groupUsers: self.viewModel.groupInfo?.groupUsers)

                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
         }
        .onAppear {
            viewModel.loadGroupInfo(id: group.id)
        }
        .navigationBarHidden(true)
    }
}

struct UsersView: View {
    var groupUsers: Array<GroupUser>?

    var body: some View {
        HStack {
            Text("Users")
                .font(.title)

            Spacer()

            Text("\(groupUsers?.count ?? 0)")
        }

        VStack(alignment: .leading) {
            ForEach(groupUsers ?? Array(), id: \.self) { user in
                UserView(user: user)
            }
        }
    }
}

struct UserView: View {
    let user: GroupUser

    var body: some View {
        HStack {
            if user.isYou {
                Text("You")
            } else {
                Text(user.firstName)
                Text(user.lastName)
            }
            
            if user.isAdmin ?? false {
                Image(systemName: "person.fill")
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

//struct GroupUsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupUsersView()
//    }
//}
