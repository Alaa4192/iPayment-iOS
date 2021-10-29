//
//  TimeUtils.swift
//  iPayment
//
//  Created by Alaa Khoury on 29/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import Foundation

class TimeUtils {

    public static func getDate(_ createdDate: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        let time = Double(createdDate / 1000)

        return dateFormatter.string(from: Date(timeIntervalSince1970: time))
    }
}
