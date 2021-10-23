//
//  FullScreenFormView.swift
//  iPayment
//
//  Created by Alaa Khoury on 16/10/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct FullScreenFormView<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentation

    var actionButton: Button<Text>? = nil
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Text("Close")
                        .foregroundColor(.blue)
                }

                Spacer()

                if actionButton != nil {
                    actionButton
                        .foregroundColor(.blue)
                }
            }
            .padding(.top)
            .padding(.horizontal)

            Form {
                content()
            }
        }

//        VStack {
//            HStack {
//                Button(action: { presentation.wrappedValue.dismiss() }) {
//                    HStack {
////                      Image(systemName: "xmark.circle.fill")
////                        .foregroundColor(.blue)
////                        .imageScale(.large)
//                      Text("Close")
//                        .foregroundColor(.blue)
//                    }
//                }
//                Spacer()
//            }
//            .padding(.bottom, 8)
//
//            content()
//        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

//struct FullScreenFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenFormView()
//    }
//}
