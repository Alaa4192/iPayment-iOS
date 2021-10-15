//
//  GroupUsersViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 15/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

class GroupUsersViewModel: BaseViewModel, ObservableObject {

    @Published var groupInfo: GroupInfoModel? = nil
    @Published var isLoading: Bool = false

    func loadGroupInfo(id: String) {
        isLoading = true
        GroupsRepository().getGroupInfo(request: GetGroupInfoRequest(id: id)) { groupInfo in
            self.groupInfo = groupInfo
            self.isLoading = false
        }
    }
}
