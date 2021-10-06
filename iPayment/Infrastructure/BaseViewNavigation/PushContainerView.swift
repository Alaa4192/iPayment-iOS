//
//  PushContainerView.swift
//  iPayment
//
//  Created by Alaa Khoury on 04/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct PushContainer<Content: View> : View {
    let main: AnyView

    var body: some View {
        GeometryReader { proxy in
            self.generateBody(proxy: proxy)
        }
        // .animation(.default)
    }

    init(content: Content) {
        self.main = AnyView.init(content)
    }

    func generateBody(proxy: GeometryProxy) -> some View {
        return ZStack {
            self.main
        }
    }
}

