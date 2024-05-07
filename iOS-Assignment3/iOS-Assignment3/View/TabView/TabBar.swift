//
//  TabBar.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

//A view of tab bar
struct TabBar: View {
    @State var current: String
    
    //The body of the view:
    //Represent how the tab bar looks like
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
            tabView
            tabButton
        }
    }
    
    //Navigation to each screen 
    var tabView: some View {
        TabView(selection: $current){
            MapView()
                .tag("Map")
            
            CountryListView()
                .tag("List")
            
            CountryInfoView()
                .tag("Info")
            
            SettingView()
                .tag("Setting")
            
        }
    }
    
    //The appearance of tab Buttons
    var tabButton: some View {
        HStack(spacing: 0){
            TabButton(title: "Map", image: "map.fill", selected: $current)
            Spacer(minLength: 0)
            TabButton(title: "List", image: "list.bullet", selected: $current)
            Spacer(minLength: 0)
            TabButton(title: "Info", image: "globe", selected: $current)
            Spacer(minLength: 0)
            TabButton(title: "Setting", image: "gearshape.fill", selected: $current)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(.mauve.opacity(0.3))
        .clipShape(Capsule())
        .padding(.horizontal, 25)
    }
}
#Preview {
    TabBar(current: "Map")
}

