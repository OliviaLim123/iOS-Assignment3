//
//  LoadingIndicatorView2.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 8/5/2024.
//

import SwiftUI

//Loading Indicator View with DESTINATION Struct
struct LoadingIndicatorView2<Destination: View>: View {
    
    //STATE property to track if the loading is complete
    @State private var loadingComplete = false
    
    //PROPERTIES of destination
    let destination: Destination
    //CLOSURE to be executed when loading is complete
    let onLoadingComplete: () -> Void
    
    //INIT method to initialise the destination and onLoadingComplete
    init(destination: Destination, onLoadingComplete: @escaping () -> Void) {
        self.destination = destination
        self.onLoadingComplete = onLoadingComplete
    }
    
    //LOADING INDICATOR VIEW
    var body: some View {
        VStack {
            if loadingComplete {
                //SHOW the provided destination after loading is complete
                destination
            } else {
                CustomOpacityDotIndicator(count: 3, inset: 2, imageName: "indicatorIcon2")
                    .frame(width: 250, height: 200)
            }
        }
        .onAppear {
            //SIMULATE loading delay and update loadingComplete state
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                loadingComplete = true
                //EXECUTE the closure when loading is complete
                onLoadingComplete()
            }
        }
    }
}
