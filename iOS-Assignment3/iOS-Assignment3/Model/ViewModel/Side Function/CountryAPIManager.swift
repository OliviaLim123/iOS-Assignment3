//
//  CountryManager.swift
//  CountryManager
//
//  Created by Daniel on 07/05/2024.
//

import Foundation
import SwiftUI

//COUNTRY MANAGER class
class CountryManager: ObservableObject {
    
    //PUBLISHED Properties
    @Published var countriesList: [Country]?
    @Published var country: Country?
    
    //STATIC Properties
    static let countryAPI = CountryManager()
    
    //METHOD for fetching all countries information from API Rest
    func fetchAllCountries() {
        let allURL = "https://restcountries.com/v3.1/all?fields=name,currencies,capital,region,subregion,languages,latlng,borders,flags,population,cca3"
        performRequest(urlString: allURL)
    }
    
    //METHOD for fetching the information BY NAME of the country
    func fetchCountryByName(countryName: String) {
        let URL_byName = "https://restcountries.com/v3.1/name/\(countryName)?fields=name,currencies,capital,region,subregion,languages,latlng,borders,flags,population,cca3"
        performRequest(urlString: URL_byName)
    }
    
    //METHOD for fetching the information BY COUNTRY CODE
    func fetchCountryByCode(countryCode: String) {
        let URL_byCode = "https://restcountries.com/v3.1/alpha/\(countryCode)?fields=name,currencies,capital,region,subregion,languages,latlng,borders,flags,population,cca3"
        performRequestByCode(urlString: URL_byCode)
    }
    
    //METHOD for fetching the country list info BY COUNTRY CODE
    func fetchCountryListByCode(countryCodes: String) {
        let URL_byCode = "https://restcountries.com/v3.1/alpha?codes=\(countryCodes)&fields=name,currencies,capital,region,subregion,languages,latlng,borders,flags,population,cca3"
        performRequest(urlString: URL_byCode)
    }
    
    //METHOD to send FETCHING Request to API
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    self.parseJSON(countryData: safeData)
                }
            }
            task.resume()
        }
    }
    
    //METHOD to perform the request BY CODE
    func performRequestByCode(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    self.parseJSONByCode(countryData: safeData)
                }
            }
            task.resume()
        }
    }
    
    //METHOD to PARSE Data from API to Object
    func parseJSON(countryData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Country].self, from: countryData)
            DispatchQueue.main.async {
                self.countriesList = decodedData
            }
        } catch {
            print("Error:")
            print(error)
        }
    }
    
    //METHOD to parse data BY CODE
    func parseJSONByCode(countryData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Country.self, from: countryData)
            DispatchQueue.main.async {
                self.country = decodedData
            }
        } catch {
            print("Error:")
            print(error)
        }
    }
    
    //METHOD to fetch data test
    func fetchDataTest(){
        //Define the URL
        let urlString = "https://restcountries.com/v3.1/vietnam?fields=name,currencies"
        //Create a URL object from the string
        if let url = URL(string: urlString) {
            //Create a URLSession object
            let session = URLSession(configuration: .default)
            //Create a data task to fetch the data
            let task = session.dataTask(with: url) { (data, response, error) in
                //Check if there's an error
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                // Check if there's data
                if let data = data {
                    do {
                        //Decode the JSON data into a Country object
                        let country = try JSONDecoder().decode([Country].self, from: data)
                        //Access country details
                        print("Common Name: \(country[0].name.common)")
                        print("Official Name: \(country[0].name.official)")
                        for (code, currency) in country[0].currencies {
                            print("Currency Code: \(code)")
                            print("Currency Name: \(currency.name)")
                            print("Currency Symbol: \(currency.symbol)")
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            // Start the data task
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}



