//
//  MyButton.swift
//  iPayment
//
//  Created by Alaa Khoury on 30/07/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct DefaultButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(Colors.darkBlue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
}
