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
    @ObservedObject var appVM: AppViewModel
    
    //INIT Method to initialse the app view model
    init(appVM: AppViewModel) {
        //HIDES the system tab bar across the entire application
        UITabBar.appearance().isHidden = true
        self.appVM = appVM
    }
    
    //INTEGRATE Tab bar to the HOME VIEW along with the MAP VIEW
    var body: some View {
        NavigationStack {
            TabBar(viewModel: self.appVM)
        }
    }
}

#Preview {
    HomeView(appVM: AppViewModel())
}
