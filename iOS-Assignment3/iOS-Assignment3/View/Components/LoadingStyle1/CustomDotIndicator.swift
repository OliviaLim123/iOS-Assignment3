//
//  CustomDotIndicator.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 8/5/2024.
//

import SwiftUI

//CUSTOM DOT LOADING INDICATOR for "LoadingIndicatorView" 
struct CustomDotIndicator: View {
    
    //STATE PROPERTIES of dot loading appearance
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    
    //OPTIONAL imageName parameter
    var imageName: String? = nil
    
    //DOT LOADING INDICATOR VIEW
    var body: some View {
        GeometryReader { geometry in
            Group {
                if let imageName = imageName, !imageName.isEmpty {
                    //DISPLAY the specified image
                    Image(imageName)
                        .resizable()
                } else {
                    //DISPLAY a default Circle Shape
                    Circle()
                }
            }
            //FRAME with DYNAMIC size
            .frame(width: geometry.size.width, height: geometry.size.height)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear() {
                //APPLY repeating animation using a Timer
                withAnimation (
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true)
                ) {
                    //SCALE DOWN for animation
                    self.scale = 0.8
                    //ADJUST transparency
                    self.opacity = 0.6
                }
            }
        }
    }
}

#Preview {
    CustomDotIndicator()
        .frame(width: 100, height: 100)
}
