//
//  CreatePaymentFormViewModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 16/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

class CreatePaymentFormViewModel: BaseViewModel, ObservableObject {

    @Published var images = Array<UIImage>()

    func onImageAdded(_ image: UIImage) {
        images.append(image)
    }
}
