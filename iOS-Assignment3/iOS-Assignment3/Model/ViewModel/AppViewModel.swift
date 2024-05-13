//
//  AppViewModel.swift
//  iOS-Assignment3
//
//  Created by Huynh Phuong Thao Nhi on 10/05/2024.
//

import Foundation
import MapKit
import SwiftUI

let emptyCountry = Country(flags: Flag(png: ""),
                           name: Name(common: "", official: ""),
                           currencies: [:],
                           capital: [],
                           region: "",
                           subregion: "",
                           languages: [:],
                           latlng: [0,0],
                           borders: [],
                           population: 0,
                           cca3: "NULL");

class AppViewModel: ObservableObject{
    //  PROPERTIES
    var userCredentialVM = UserCredentialViewModel();
    
    @Published var currentTab: String = "Map"
    @Published var selectedCountry: String = "";
    @Published var userFavList: [String] = [];
    
    //  MAP KIT Properties
    @Published var mapCameraPosition: MapCameraPosition
    let defaultCoordinates: CLLocationCoordinate2D
    let geocoder = CLGeocoder()
    
    init(){
        //  APP View Model Properties
        userFavList = userCredentialVM.loadFavCountriesArray();
        
        //  INIT MAP View Properties
        self.defaultCoordinates = CLLocationCoordinate2D(latitude: 16.16666666, longitude: 107.83333333)
        self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: defaultCoordinates, distance: 10000000))
        
        //  DEBUG
//        print(self.userFavList);
    }
    
    func isInFavList(countryCode: String) -> Bool{
        return userFavList.contains(countryCode);
    }
}
