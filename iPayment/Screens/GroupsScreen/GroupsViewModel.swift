//
//  GroupsViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 26/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

class GroupsViewModel: BaseViewModel{

    func loadGroups(groups: @escaping (Array<GroupModel>) -> Void) {
        GroupsRepository().getGroups { result in
            groups(result.items)
        }
    }

}
