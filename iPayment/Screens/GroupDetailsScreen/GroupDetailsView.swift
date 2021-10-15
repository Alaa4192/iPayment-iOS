//
//  GroupDetailsView.swift
//  iPayment
//
//  Created by Alaa Khoury on 12/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct GroupDetailsView: BaseView {


    var viewModel = GroupDetailsViewModel()

    var body: some View {
        LoadingView(isShowing: .constant(false)) {
            VStack {
                Text("GroupDetailsView")
            }
        }
    }
}

struct GroupDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailsView()
    }
}
