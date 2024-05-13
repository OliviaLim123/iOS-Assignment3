//
//  AppViewModel.swift
//  iOS-Assignment3
//
//  Created by Huynh Phuong Thao Nhi on 10/05/2024.
//

import Foundation
let emptyCountry = Country(flags: Flag(png: ""),
                           name: Name(common: "", official: ""),
                           currencies: [:],
                           capital: [],
                           region: "",
                           subregion: "",
                           languages: [:],
                           latlng: [],
                           borders: [],
                           population: 0,
                           cca3: "NULL");

class AppViewModel: ObservableObject{
    //  PROPERTIES
    var userCredentialVM = UserCredentialViewModel();
    
    @Published var currentTab: String = "Map"
    @Published var selectedCountry: String = "";
    @Published var userFavList: [String] = [];
    
    init(){
        userFavList = userCredentialVM.loadFavCountriesArray();
        print(userFavList);
    }
    
    func isInFavList(countryCode: String) -> Bool{
        return userFavList.contains(countryCode);
    }
}
