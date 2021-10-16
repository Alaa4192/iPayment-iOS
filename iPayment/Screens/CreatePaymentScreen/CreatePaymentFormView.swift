//
//  CreatePaymentFormView.swift
//  iPayment
//
//  Created by Alaa Khoury on 16/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct CreatePaymentFormView: View {
    var group: GroupModel
    
    var body: some View {
        FullScreenFormView {
            VStack {
                Text("CreatePaymentFormView")
            }
        }
    }
}

struct CreatePaymentFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePaymentFormView(group: GroupModel.create(name: "Test", isFavorite: false))
    }
}
