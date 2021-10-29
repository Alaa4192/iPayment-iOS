//
//  DoubleExtentions.swift
//  iPayment
//
//  Created by Alaa Khoury on 29/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

extension Double {
    func roundToTwoDecimals() -> String {
        return String(format: "%.2f", self)
    }
}
