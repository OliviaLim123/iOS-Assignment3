//
//  FavCountryView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

//FAVOURITE COUNTRY VIEW Struct
struct FavCountryView: View {
    
    //OBSERVED OBJECT of app view model and country manager
    @ObservedObject private var appVM: AppViewModel
    @ObservedObject private var countryAPI: CountryManager
    
    //ENVIRONMENT for presentation mode
    @Environment(\.presentationMode) var presentationMode
    
    //STATE property to DISPLAY the list of Countries
    @State private var displayList: [Country] = []

    //INIT Method to initialise the app view model
    init(appVM: AppViewModel) {
        self.appVM = appVM
        countryAPI = CountryManager()
        //CREATE Countries Code List and FETCH data
        let countriesCodeList = appVM.userFavList.joined(separator: ",")
        countryAPI.fetchCountryListByCode(countryCodes: countriesCodeList)
    }
    
    //FAVOURITE COUNTRY VIEW
    var body: some View {
        VStack {
            //FAVOURITE COUNTRY TITLE Appearance
            Text("FAVOURITE COUNTRY!")
                .font(.custom("MontserratAlternates-SemiBold", size: 45))
                .foregroundStyle(.darkPurple)
                .multilineTextAlignment(.center)
                .padding(10)
            VStack {
                //COUNTRY LISTS
                if !appVM.userFavList.isEmpty {
                    ScrollView {
                        ForEach(self.displayList) {country in
                            HStack{
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
                                //CHANGE VM Data to switch back to "Country Info View"
                                appVM.selectedCountryCode = country.cca3
                                appVM.currentTab = "Info"
                                //BACK TO HOME VIEW
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                else {
                    //SOME TEXTS when the country list is EMPTY
                    VStack {
                        Text("It's a bit lonely here...🌨️☔️")
                        Text("How about adding some countries you love?")
                    }
                }
            }
            Spacer()
        }
        .onReceive(countryAPI.$countriesList){ countryData in
            if let safeData = countryData {
                self.displayList = safeData
            }
        }
    }

    //METHOD to handle the HEART Button View
    func heartButton(country: Country) -> some View {
        //BUTTON Image will be "heart.fill" if in FAV List
        //BUTTON Image will be "heart" if not in FAV List
        Button {
            if appVM.isInFavList(countryCode: country.cca3) {
                appVM.userFavList.removeAll{
                    $0 == country.cca3
                }
                print(appVM.userFavList)
                //SAVE Fav List to APPSTORAGE
                appVM.saveFavList()
            } else {
                appVM.userFavList.append(country.cca3)
                //SAVE Fav List to APPSTORAGE
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
                    .foregroundStyle(.textColour)
            }
        }
    }
}

#Preview {
    FavCountryView(appVM: AppViewModel())
}
