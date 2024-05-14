//
//  TabBar.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

//TAB BAR Struct
struct TabBar: View {
    
    //PROPERTIES
    @StateObject var viewModel: AppViewModel
    
    //TAB BAR View
    var body: some View {
        VStack(spacing: 0) {
            tabView
            tabButton
        }
    }
    
    //TAB VIEW for navigates each icon to its view
    var tabView: some View {
        TabView(selection: $viewModel.currentTab) {
            //"Map" icon navigates to MAP VIEW
            MapView(appVM: self.viewModel)
                .tag("Map")
            //"List" icon navigates to COUNTRY LIST VIEW
            CountryListView(appVM: self.viewModel, countryAPI: CountryManager())
                .defaultScrollAnchor(.top)
                .tag("List")
            //"Info" icon navigates to COUNTRY INFO VIEW
            CountryInfoView(countryCode: self.viewModel.selectedCountry, viewModel: self.viewModel)
                .defaultScrollAnchor(.top)
                .tag("Info")
            //"Setting" icon navigates to SETTING VIEW
            SettingView(viewModel: self.viewModel)
                .tag("Setting")
        }
    }
    
    //TAB BUTTON Appearance
    var tabButton: some View {
        HStack(spacing: 0){
            TabButton(title: "Map", image: "map.fill", selected: $viewModel.currentTab)
            Spacer(minLength: 0)
            TabButton(title: "List", image: "list.bullet", selected: $viewModel.currentTab)
            Spacer(minLength: 0)
            TabButton(title: "Info", image: "globe", selected: $viewModel.currentTab)
                //Disable BUTTON if no country is selected
                .disabled(viewModel.selectedCountry == "")
            Spacer(minLength: 0)
            TabButton(title: "Setting", image: "gearshape.fill", selected: $viewModel.currentTab)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(.mauve.opacity(0.3))
        .clipShape(Capsule())
        .padding(.horizontal, 25)
        .padding(.top);
    }
}

#Preview {
    TabBar(viewModel: AppViewModel())
}

