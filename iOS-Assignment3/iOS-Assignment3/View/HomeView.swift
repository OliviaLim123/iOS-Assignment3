//
//  HomeView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

struct HomeView: View {
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        TabBar()
    }
}

#Preview {
    HomeView()
}
