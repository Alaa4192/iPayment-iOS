//
//  GroupInfoView.swift
//  iPayment
//
//  Created by Alaa Khoury on 12/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupInfoView: BaseView {
    var group: GroupModel

    @ObservedObject var viewModel = GroupInfoViewModel()

    var body: some View {
         LoadingView(isShowing: self.$viewModel.isLoading) {
            VStack(alignment: .leading) {
                Text("Users")
                    .font(.title)

                VStack(alignment: .leading) {
                    ForEach(self.viewModel.groupInfo?.groupUsers ?? Array(), id: \.self) { user in
                        UserGroupView(user: user)
                    }

                }

                Spacer()
            }
            .padding()
         }
        .onAppear {
            viewModel.loadGroupInfo(id: group.id)
        }
    }
}

struct UserGroupView: View {
    let user: GroupUser

    var body: some View {
        HStack {
            if user.isYou {
                Text("You")
            } else {
                Text(user.firstName)
                Text(user.lastName)
            }

            Spacer()
        }
        .frame(height: 40)
    }
}

struct GroupInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GroupInfoView(group: GroupModel.create(name: "Test Group", isFavorite: true))
    }
}
