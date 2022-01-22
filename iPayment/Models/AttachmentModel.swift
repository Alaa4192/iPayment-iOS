//
//  AttachmentModel.swift
//  iPayment
//
//  Created by Alaa Khoury on 22/01/2022.
//  Copyright © 2022 Alaa Khoury. All rights reserved.
//

import Foundation
import SwiftUI

class NewImageModel: Hashable {

    static func == (lhs: NewImageModel, rhs: NewImageModel) -> Bool {
        return lhs.image == rhs.image
    }

    let image: UIImage
    var progress: Int

    var hashValue: Int {
        return image.hash
    }

    func hash(into hasher: inout Hasher) {
        self.image.hash(into: &hasher)
    }

    init(_ image: UIImage) {
        self.image = image
        self.progress = 0
    }

    init(_ image: UIImage, _ progress: Int) {
        self.image = image
        self.progress = progress
    }

    func setProgress(_ progress: Int) {
        self.progress = progress
    }

}
