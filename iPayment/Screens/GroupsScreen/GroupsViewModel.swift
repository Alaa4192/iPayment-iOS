//
//  GroupsViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 26/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

class GroupsViewModel: BaseViewModel, ObservableObject {
    @Published var groups = Array<GroupModel>()
    @Published var isLoading: Bool = false

    override init() {
        super.init()

        loadGroups()
    }

    func loadGroups() {
        self.isLoading = true
        GroupsRepository().getGroups { result in
            self.groups = result.items.filter({ !$0.isDeleted })
            self.isLoading = false
        }
    }

    func setFavorite(_ id: String, _ isFavorite: Bool) {
        self.isLoading = true

        GroupsRepository().setGroupFavorite(
            request: SetGroupFavoriteRequest(id: id, isFavorite: isFavorite)) { _ in
                self.loadGroups()
        }
    }

    func removeGroup(_ id: String) {
        self.isLoading = true

        GroupsRepository().removeGroup(request: RemoveGroupRequest(id: id)) { _ in
            self.loadGroups()
        }
    }

}
