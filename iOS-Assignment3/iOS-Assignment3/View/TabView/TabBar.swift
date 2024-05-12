//
//  TabBar.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

//A view of tab bar
struct TabBar: View {

    @StateObject var viewModel: AppViewModel;
    
    //The body of the view:
    //Represent how the tab bar looks like
    var body: some View {
        VStack{
            tabView
            tabButton
        }
    }
    
    //Navigation to each screen 
    var tabView: some View {
        TabView(selection: $viewModel.currentTab){
            MapView()
                .tag("Map")
            
            CountryListView(viewModel: self.viewModel, countryAPI: CountryManager())
                .defaultScrollAnchor(.top)
                .tag("List")
            
            CountryInfoView(countryCode: self.viewModel.selectedCountry)
                .defaultScrollAnchor(.top)
                .tag("Info")
            
            SettingView()
                .tag("Setting")
            
        }
    }
    
    //The appearance of tab Buttons
    var tabButton: some View {
        HStack(spacing: 0){
            TabButton(title: "Map", image: "map.fill", selected: $viewModel.currentTab)
            Spacer(minLength: 0)
            TabButton(title: "List", image: "list.bullet", selected: $viewModel.currentTab)
            Spacer(minLength: 0)
            TabButton(title: "Info", image: "globe", selected: $viewModel.currentTab)
            Spacer(minLength: 0)
            TabButton(title: "Setting", image: "gearshape.fill", selected: $viewModel.currentTab)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(.mauve.opacity(0.3))
        .clipShape(Capsule())
        .padding(.horizontal, 25)
    }
}
#Preview {
    TabBar(viewModel: AppViewModel())
}

