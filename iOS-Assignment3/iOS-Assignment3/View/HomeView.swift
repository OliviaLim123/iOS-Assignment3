//
//  HomeView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

//HOME VIEW Struct
struct HomeView: View {
    
    //OBSERVED OBJECT of map view model
    @ObservedObject var mapViewVM: MapViewModel
    
    //HIDES the system tab bar across the entire application
    init(mapViewVM: MapViewModel) {
        UITabBar.appearance().isHidden = true
        self.mapViewVM = mapViewVM
    }
    
    //INTEGRATE Tab bar to the HOME VIEW along with the MAP VIEW
    var body: some View {
        NavigationStack {
            TabBar(viewModel: self.mapViewVM)
        }
    }
}

#Preview {
    HomeView(mapViewVM: MapViewModel())
}
