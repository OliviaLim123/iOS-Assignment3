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
    @Published var currentTab: String = "Map"
    @Published var selectedCountry: String = "";
}
