//
//  MainView.swift
//  iPayment
//
//  Created by Alaa Khoury on 28/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct MainView: BaseView {

    var navigationModel = BaseNavigationModel()

    var viewModel = MainViewModel()

    var body: some View {
        BaseNavigationView(model: navigationModel) {
            TabView {
                GroupsView().environmentObject(self.navigationModel)
                    .onAppear {
                        navigationModel.setTitle(title: "Groups")
                    }
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Groups")
                    }

                ProfileView().environmentObject(self.navigationModel)
                    .onAppear {
                        navigationModel.setTitle(title: "Profile")
                    }
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}