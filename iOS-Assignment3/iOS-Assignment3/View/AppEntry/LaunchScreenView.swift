//
//  LaunchScreenView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 7/5/2024.
//

import SwiftUI

struct LaunchScreenView: View {
    
    //A state variable to track whether the view is active
    @State private var isActive = false
    //A state variable to manage the size of the view
    @State private var size = 0.8
    //A state variable to control the opacity of the view
    @State private var opacity = 0.5
    
    //The body of view:
    //Represents how the launch screen looks like
    var body: some View {
        //Navigates to the AppEntry view after the launch screen
        if isActive {
            AppEntry()
        } else {
            VStack {
                appLogo
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    //Providing the animation to the app logo
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                //Animation to the next view
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    //The appearance of app logo
    var appLogo: some View {
        VStack {
            Image(.appLogo)
                .resizable()
                .frame(width: 250, height: 250)
            Text("Country Discovery")
                .font(.custom("MontserratAlternates-SemiBold", size: 26))
                .foregroundStyle(.black.opacity(0.80))
            
        }
    }
}

#Preview {
    LaunchScreenView()
}
