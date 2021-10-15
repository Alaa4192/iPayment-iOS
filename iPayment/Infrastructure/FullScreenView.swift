//
//  FullScreenView.swift
//  iPayment
//
//  Created by Alaa Khoury on 15/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct FullScreenView<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentation

    var content: () -> Content

    var body: some View {
        VStack {
            HStack {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    HStack {
                      Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                      Text("Back")
                        .foregroundColor(.blue)
                    }
                }
                Spacer()
            }

            content()
        }
        .navigationBarHidden(true)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

//struct FullScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenView()
//    }
//}
