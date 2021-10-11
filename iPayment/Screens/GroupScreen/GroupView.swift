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

    var viewModel = GroupViewModel()

    var groupDetailsView = GroupDetailsView()
    var groupInfoView = GroupInfoView()

    var body: some View {
        NavigationView {
            TabView {
                groupDetailsView
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Group")
                    }

                groupInfoView
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("Info")
                    }
            }
        }
        // .navigationBarTitle("Group")

    }
}
