//
//  CustomDotIndicator.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 8/5/2024.
//

import SwiftUI

//  A View of Custom Dot Loading Indicator for "LoadingIndicatorView"
struct CustomDotIndicator: View {
    
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    var imageName: String? = nil // Optinal imageName parameter
    
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if let imageName = imageName, !imageName.isEmpty {
                    //  Displayed the specified image
                    Image(imageName)
                        .resizable()
                } else {
                    //  Display a default Circle Shape
                    Circle()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height) //Dynamic size
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear() {
                //  Apply repeating animation using a Timer
                withAnimation (
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true)
                ) {
                    self.scale = 0.8 // Scale down for animation
                    self.opacity = 0.6 // Adjust transparency
                }
        }
        }
    }
}

#Preview {
    CustomDotIndicator()
        .frame(width: 100, height: 100)
}
