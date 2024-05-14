//
//  LoadingIndicator.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 8/5/2024.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingIndicatorView: View {
    
    //  State variable to CONTROL animation of Package "ActivityIndicatorView"
    @State private var isAnimating = true
    
    //  State variable to TRACK loading completetion
    @State private var loadingComplete = false // false >> keep loading
    
    var body: some View {
        
        VStack {
            //  SHOW either "HomeView" page or "LoadingView" Sub-View based on loadingComplete state
            if loadingComplete {
                //  If loading complete, show "HomeView" page
                HomeView(mapViewVM: MapViewModel())
            } else {
                //  If loading is not complete, show "loadingView" Sub-View
                LoadingView
            }
        } // VStack
        .onAppear {
            //  Loading delaye using DispatchQueue
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                //  SET loadingComplete to true after the delay
                loadingComplete = true // True >> Go to HomeView()
            }
        }
    }
    
    //  The view of Loading Indicator
    var LoadingView: some View {
        
        VStack {
            //  CUSTOM DOT INDICATOR VIEW
            CustomDotIndicator(imageName: "indicatorIcon") // ""
                .frame(width: 250, height: 250)
            //.foregroundColor(.pink)
            
            //  [ PACKAGE ] "ActivityIndicatorview" with scaling dots
            ActivityIndicatorView(
                isVisible: $isAnimating, // Binding to control visibility
                type: .scalingDots(count: 3, inset: 2)
            )
            .frame(width: 100, height: 100)
            .foregroundStyle(RGB_Gradient)
        } // VStack E.
        
    }
}

//  CUSTOM GRADIENT COLORS
func customGradient(_ colors: [Color], center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat) -> RadialGradient {
    return RadialGradient(colors: colors, center: center, startRadius: startRadius, endRadius: endRadius)
}

let colors: [Color] = [.orange,.pink,.blue,.purple]
let RGB_Gradient = customGradient(colors, center: .center,startRadius: 10, endRadius: 9) //StartRadius: 10-orange //5-purple


#Preview {
    LoadingIndicatorView()
}
