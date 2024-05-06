//
//  HomeView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

//A view of home screen
struct HomeView: View {
    
    //Hides the system tab bar across the entire application
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    //The body of the view:
    //Represent how the tab bar looks like and navigates to the specific screen
    var body: some View {
        NavigationStack {
            TabBar()
        }
    }
}

#Preview {
    HomeView()
}
