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
                HomeView()
            } else {
                //  If loading is not complete, show "loadingView" Sub-View
                LoadingView
            }
        } // VStack
        .onAppear {
            //  Loading delaye using DispatchQueue
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //  SET loadingComplete to true after the delay
                loadingComplete = true // True >> Go to HomeView()
            }
        }
    }
    
    //  The view of Loading Indicator
    var LoadingView: some View {
        
        VStack {
            //  CUSTOM DOT INDICATOR VIEW
            CustomDotIndicator(imageName: "indicator") // ""
                .frame(width: 200, height: 200)
            //.foregroundColor(.pink)
            
            //  [ PACKAGE ] "ActivityIndicatorview" with scaling dots
            ActivityIndicatorView(
                isVisible: $isAnimating, // Binding to control visibility
                type: .scalingDots(count: 3, inset: 2)
            )
            .frame(width: 100, height: 100)
            .foregroundColor(.purpleOpacity1)
        } // VStack E.
        
    }
}

#Preview {
    LoadingIndicatorView()
}
