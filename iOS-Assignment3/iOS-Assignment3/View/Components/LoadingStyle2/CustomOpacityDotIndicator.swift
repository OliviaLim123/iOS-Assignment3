//
//  CustomOpacityDotIndicator.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 8/5/2024.
//

import SwiftUI

//CUSTOM DOT INDICATOR View for "LoadingIndicatorView2"
struct CustomOpacityDotIndicator: View {
    
    //PROPERTIES of custom dot indicator
    let count: Int
    let inset: Int
    let imageName: String?
    
    //CUSTOM DOT INDICATOR VIEW
    var body: some View {
        GeometryReader {
            geometry in ForEach(0..<count, id: \.self) {
                index in CustomDotLoading(index: index, count: count, inset: inset, size: geometry.size, imageName: imageName)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

//CUSTOM DOT LOADING Struct
struct CustomDotLoading: View {
    
    //PROPERTIES to handle the appearance
    let index: Int
    let count: Int
    let inset: Int
    let size: CGSize
    let imageName: String?
    
    //STATE properties to handle the scale and opacity
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    
    //CUSTOM DOT LOADING VIEW
    var body: some View {
        let itemSize = (size.width - CGFloat(inset) * CGFloat(count - 1)) / CGFloat(count)
        let animation = Animation.easeOut
            .repeatForever(autoreverses: true)
            .delay(index % 2 == 0 ? 0.2 : 0)
        return Group {
            if let imageName = imageName, !imageName.isEmpty {
                Image(imageName)
                    .resizable()
            } else {
                Circle()
            }
        }
        .frame(width: itemSize, height: itemSize)
        .scaleEffect(scale)
        .opacity(opacity)
        .onAppear {
            scale = 1
            opacity = 1
            //APPLY some animation to the scale and opacity 
            withAnimation(animation) {
                scale = 0.9
                opacity = 0.3
            }
        }
        .offset(x: (itemSize + CGFloat(inset)) * CGFloat(index) - size.width / 2 + itemSize / 2 )
    }
}

#Preview {
    CustomOpacityDotIndicator(count: 3, inset: 2, imageName: "indicatorIcon2")
        .frame(width: 300, height: 100)
}
