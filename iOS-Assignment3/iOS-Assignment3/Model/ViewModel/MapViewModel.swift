//
//  MapViewModel.swift
//  iOS-Assignment3
//
//  Created by Daniel on 10/05/2024.
//

import Foundation
import MapKit
import SwiftUI

//PROPERTY of emtpy country
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
                           cca3: "NULL")

//MAP VIEW MODEL - handling the map in this application
class MapViewModel: ObservableObject {
    
    //USER CREDENTIAL VIEW MODEL
    var userCredentialVM = UserCredentialViewModel()
    
    //PUBLISHED Properties
    @Published var currentTab: String = "Map"
    @Published var selectedCountry: String = ""
    @Published var userFavList: [String] = []
    
    //MAP KIT Properties
    @Published var mapCameraPosition: MapCameraPosition
    let defaultCoordinates: CLLocationCoordinate2D
    let geocoder = CLGeocoder()
    
    //INIT method for MAP VIEW properties
    init() {
        userFavList = userCredentialVM.loadFavCountriesArray()
        self.defaultCoordinates = CLLocationCoordinate2D(latitude: 16.16666666, longitude: 107.83333333)
        self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: defaultCoordinates, distance: 10000000))
    }
    
    //METHOD for saving the favourite country list
    func saveFavList() {
        userCredentialVM.saveFavCountriesArray(favList: userFavList)
    }
    
    //METHOD for checking if the user favourite country is in the list
    func isInFavList(countryCode: String) -> Bool {
        return userFavList.contains(countryCode)
    }
}
