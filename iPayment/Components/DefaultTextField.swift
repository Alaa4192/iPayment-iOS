//
//  DefaultTextField.swift
//  iPayment
//
//  Created by Alaa Khoury on 30/07/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct DefaultTextField: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(8)
    }
}

extension Text {
    func configAsTitle() -> some View {
        return self
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(Colors.darkBlue)
            .modifier(DefaultTextField())
    }
}
