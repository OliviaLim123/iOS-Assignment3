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
                           population: 0)

class AppViewModel: ObservableObject{
    @Published var borderList: [Country] = [];
    @Published var selectedCountry: Country = emptyCountry;
    
    static let shared = AppViewModel();
    
}
