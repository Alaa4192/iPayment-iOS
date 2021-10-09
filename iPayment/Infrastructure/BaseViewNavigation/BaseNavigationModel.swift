//
//  BaseNavigationModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 04/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

class BaseNavigationModel : ObservableObject {
    @Published var isPushActive : Bool = false
    @Published private (set)var mainView : AnyView?
    @Published var title : String = ""
    @Published var leadingNavigationBarItems: AnyView? = nil
    @Published var trailingNavigationBarItems: AnyView? = nil

    public func pushMain<Main: View>(view: Main) {
        // First pop if any other view has been pushed
        isPushActive = false
        let container = PushContainer (content: view)
        self.mainView = AnyView (container)
        // Push view
        isPushActive = true
    }

    public func setTitle(title: String) {
        self.title = title
    }


    public func setLeadingNavigationBarItems(navigationBarItems: AnyView) {
        self.leadingNavigationBarItems = navigationBarItems
    }

    public func setTrailingNavigationBarItems(navigationBarItems: AnyView) {
        self.trailingNavigationBarItems = navigationBarItems
    }

    public func clearNavigationsBarItems() {
        self.leadingNavigationBarItems = nil
        self.trailingNavigationBarItems = nil
    }
}

