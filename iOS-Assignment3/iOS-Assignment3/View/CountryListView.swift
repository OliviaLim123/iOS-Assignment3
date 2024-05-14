//
//  CountryListView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI

//COUNTRY LIST VIEW Struct
struct CountryListView: View {
    
    //STATE OBJECT of map view model
    @StateObject var appVM: AppViewModel
    
    //STATE Properties
    @State var countryAPI: CountryManager
    @State private var displayList: [Country] = []
    @State private var searchString: String = ""
    
    //COMPUTED Variable for filtering the list
    var filteredList: [Country] {
        if searchString.isEmpty {
            return displayList
        } else {
            return displayList.filter { country in
                country.name.common.localizedCaseInsensitiveContains(searchString)
            }
        }
    }
    
    //COUNTRY LIST VIEW
    var body: some View {
        VStack {
            searchBarView
            //LOGO IMAGE
            Image("logo")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.vertical, 10)
            //LOOPING through country array
            countryListView
        }
        .padding(.horizontal, 35)
    }
    
    //COUNTRIES List VIEW - scrolling view
    var countryListView: some View {
        ScrollView {
            ForEach(filteredList) { country in
                HStack {
                    AsyncImage(url: URL(string: country.flags.png)){ image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .border(.gray)
                    .frame(width: 55, height: 38)
                    Text("\(country.name.common)")
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .tracking(2)
                        .foregroundStyle(.textColour)
                        .padding(.horizontal, 10)
                    Spacer()
                    //HEART Button
                    heartButton(country: country)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.sweetCorn)
                        .opacity(0.55))
                //PADDING Around Button
                .padding(.vertical, 3)
                .onTapGesture {
                    appVM.selectedCountry = country.cca3
                    appVM.currentTab = "Info"
                }
            }
        }
        .onAppear() {
            countryAPI.fetchAllCountries()
        }
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData{
                displayList = safeCountryData
            }
        }
    }
    
    //METHOD for HEART Button View
    func heartButton(country: Country) -> some View {
        //BUTTON Image will be "heart.fill" if in FAV List
        //BUTTON Image will be "heart" if not in FAV List
        Button {
            if appVM.isInFavList(countryCode: country.cca3) {
                appVM.userFavList.removeAll {
                    $0 == country.cca3
                }
                //SAVE favourite list to APP STORAGE
                appVM.saveFavList()
            } else {
                appVM.userFavList.append(country.cca3)
                //SAVE favourite list to APP STORAGE
                appVM.saveFavList()
            }
        } label: {
            if appVM.isInFavList(countryCode: country.cca3) {
                Image(systemName: "heart.fill")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.red)
            } else {
                Image(systemName: "heart")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.black)
            }
        }
    }
    
    //SEARCH BAR VIEW Appearance
    var searchBarView: some View {
        ZStack {
            HStack {
                TextField("Search a country", text: $searchString)
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.textColour)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10.0)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundStyle(.textColour.opacity(0.8))
            }
            //INNER SHADOW (for Search bar)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple)
                        .frame(height: 50)
                        .padding(.horizontal, -15)
                        .overlay(
                            //The shape of the overlay should match the element
                            RoundedRectangle(cornerRadius: 10)
                                //Border color and width
                                .stroke(Color.gray, lineWidth: 4)
                                //Blur the border to create a soft shadow effect
                                .blur(radius: 3)
                                //Offset of the shadow
                                .offset(x: 0, y: 2)
                                .mask(
                                    //Mask using the same shape as the element
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)
                                        )
                                )
                                .padding(.horizontal, -15)
                        )
                }
            }
            .padding()
        }
    }
}

#Preview {
    CountryListView(appVM: AppViewModel(), countryAPI: CountryManager())
}
