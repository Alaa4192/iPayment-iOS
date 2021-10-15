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

struct GroupInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GroupInfoView(group: GroupModel.create(name: "Test Group", isFavorite: true))
    }
}
