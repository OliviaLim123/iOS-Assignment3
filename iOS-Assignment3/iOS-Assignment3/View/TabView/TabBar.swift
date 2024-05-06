//
//  TabBar.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

struct TabBar: View {
    @State var current = "Map"
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
            TabView(selection: $current){
                MapView()
                    .tag("Map")
                
                CountryListView()
                    .tag("List")
                
                CountryInfoView()
                    .tag("Info")
                
                ProfileView()
                    .tag("Profile")
                
            }
            HStack(spacing: 0){
                TabButton(title: "Map", image: "map.fill", selected: $current)
                Spacer(minLength: 0)
                TabButton(title: "List", image: "list.bullet", selected: $current)
                Spacer(minLength: 0)
                TabButton(title: "Info", image: "globe", selected: $current)
                Spacer(minLength: 0)
                TabButton(title: "Profile", image: "person.fill", selected: $current)
            }
            .padding(.vertical,12)
            .padding(.horizontal)
            .background(.mauve.opacity(0.3))
            .clipShape(Capsule())
            .padding(.horizontal, 25)
        }
    }
}
#Preview {
    TabBar(current: "Map")
}

