//
//  BaseNavigationView.swift
//  iPayment
//
//  Created by Alaa Khoury on 04/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct BaseNavigationView<Content>: View where Content: View {
    @ObservedObject var model: BaseNavigationModel
    var content: () -> Content

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    self.content()
                    if self.model.mainView != nil {
                        NavigationLink(destination: self.model.mainView!, isActive: self.$model.isPushActive, label: {
                            EmptyView()
                        })
                        .isDetailLink(false)
                    }
                }
            }
            .navigationBarTitle(Text(self.$model.title.wrappedValue))
            .navigationBarItems(trailing: self.$model.navigationBarItems.wrappedValue)
        }
    }
}
