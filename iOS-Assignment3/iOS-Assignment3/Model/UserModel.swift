//
//  UserModel.swift
//  iOS-Assignment3
//
//  Created by Daniel on 06/05/2024.
//

import Foundation

//USER MODEL
class User {
    
    //PROPERTIES
    private var favCountries: [String] = []
    
    //GET user's favourite country
    func getFavCountries() -> [String] {
        return self.favCountries
    }
    
    //ADD favourite country
    func addFavCountry(with newCountry: String) {
        //CONTROL favorite countries List at most 10 Countries
        if(self.favCountries.count >= 10) {
            return
        }
        self.favCountries.append(newCountry)
        self.favCountries.sort()
    }
    
    //REMOVE favourite country
    func removeFavCountry(country: String) {
        self.favCountries.removeAll(where: {
            country == $0
        })
    }
}
