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


struct InverseButton: ViewModifier {
    var isWide: Bool = false

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, isWide ? 72 : 24)
            .padding(.vertical, 8)
            .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Colors.darkBlue, lineWidth: 3))
            .background(Colors.white)
            .foregroundColor(Colors.darkBlue)
            .cornerRadius(5)
    }
}

struct DefaultButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Test")
        }
        .modifier(DefaultButton())
        .previewLayout(.sizeThatFits)
    }
}


struct InverseButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Test")
        }
        .modifier(InverseButton())
        .previewLayout(.sizeThatFits)

        Button(action: {}) {
            Text("Test")
        }
        .modifier(InverseButton(isWide: true))
        .previewLayout(.sizeThatFits)
    }
}
