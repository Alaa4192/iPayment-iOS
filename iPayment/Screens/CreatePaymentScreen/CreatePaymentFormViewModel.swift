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
    @Published var imagesInProgress = Array<NewImageModel>()

    func onImageAdded(_ image: UIImage) {
        images.append(image)

        let data = image.pngData()
        let imageModel = NewImageModel(image)
        imagesInProgress.append(imageModel)

        UploadFileUtils().upload(data) { progress in
            imageModel.progress = progress
            
        }
    }
}
