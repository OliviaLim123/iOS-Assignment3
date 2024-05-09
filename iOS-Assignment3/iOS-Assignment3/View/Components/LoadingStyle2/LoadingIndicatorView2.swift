//
//  LoadingIndicatorView2.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 8/5/2024.
//

import SwiftUI

// Loading Indicator View with Destination
struct LoadingIndicatorView2<Destination: View>: View {
    
    @State private var loadingComplete = false
    let destination: Destination
    let onLoadingComplete: () -> Void // Closure to be executed when loading is complete
    
    init(destination: Destination, onLoadingComplete: @escaping () -> Void) {
        self.destination = destination
        self.onLoadingComplete = onLoadingComplete
    }
    
    var body: some View {
//        CustomOpacityDotIndicator(count: 3, inset: 2, imageName: "indicator")
//            .frame(width: 250, height: 200)
        VStack {
            if loadingComplete {
                //  SHOW the provided destination after loading is complete
                destination
            } else {
                CustomOpacityDotIndicator(count: 3, inset: 2, imageName: "indicatorIcon2")
                    .frame(width: 250, height: 200)
            }
        }
        .onAppear {
            //  Simulate loading delay and update loadingComplete state
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                loadingComplete = true
                onLoadingComplete() // EXECUTE the closure when loading is complete
            }
        }
    }
}

//#Preview {
//    LoadingIndicatorView2()
//}
