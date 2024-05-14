//
//  LoadingIndicator.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 8/5/2024.
//

import SwiftUI
import ActivityIndicatorView

//LOADING INDICATOR VIEW Struct
struct LoadingIndicatorView: View {
    
    //STATE variable to CONTROL animation of Package "ActivityIndicatorView"
    @State private var isAnimating = true
    
    //STATE variable to TRACK loading completetion
    //If it is FALSE, it will keep loading
    @State private var loadingComplete = false
    
    //LOADING INDICATOR VIEW
    var body: some View {
        VStack {
            //SHOW either "HomeView" page or "LoadingView" Sub-View based on loadingComplete state
            if loadingComplete {
                //If loading complete, show "HomeView" page
                HomeView(appVM: AppViewModel())
            } else {
                //If loading is not complete, show "loadingView" Sub-View
                LoadingView
            }
        }
        .onAppear {
            //Loading delaye using DispatchQueue
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                //SET loadingComplete to true after the delay
                //If it is TRUE, it will go to HomeView()
                loadingComplete = true
            }
        }
    }
    
    //LOADING INDICATOR Appearance
    var LoadingView: some View {
        VStack {
            //CUSTOM DOT INDICATOR VIEW
            CustomDotIndicator(imageName: "indicatorIcon")
                .frame(width: 250, height: 250)
            //[ PACKAGE ] "ActivityIndicatorview" with scaling dots
            ActivityIndicatorView(
                //Binding to control visibility
                isVisible: $isAnimating,
                type: .scalingDots(count: 3, inset: 2)
            )
            .frame(width: 100, height: 100)
            .foregroundStyle(RGB_Gradient)
        }
    }
}

//CUSTOM GRADIENT COLORS
func customGradient(_ colors: [Color], center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat) -> RadialGradient {
    return RadialGradient(colors: colors, center: center, startRadius: startRadius, endRadius: endRadius)
}

//PROPERTIES to handle the colour of LOADING INDICATOR
let colors: [Color] = [.orange,.pink,.blue,.purple]
let RGB_Gradient = customGradient(colors, center: .center,startRadius: 10, endRadius: 9)


#Preview {
    LoadingIndicatorView()
}
