//
//  LoadingView.swift
//  iPayment
//
//  Created by Alaa Khoury on 14/10/2020.
//  Copyright © 2020 Alaa Khoury. All rights reserved.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geomtry in
            ZStack(alignment: .center) {
                self.content()
                    .frame(maxWidth: .infinity)
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 5 : 0)
                
                VStack(spacing: 16) {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                    Text("Loading")
                }
                .frame(width: geomtry.size.width / 2, height: geomtry.size.height / 5)
                .background(Colors.darkBlue)
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        uiView.color = UIColor.white
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isShowing: .constant(true)) {
            Text("test")
        }
    }
}
