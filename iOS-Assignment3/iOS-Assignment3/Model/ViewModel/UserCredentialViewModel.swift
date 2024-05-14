//
//  LoginViewModel.swift
//
//  iOS-Assignment3
//
//  Created by Hang Vu on 7/5/2024.
//

import SwiftUI

//USER CREDENTIAL VIEW MODEL - handling user credential model
class UserCredentialViewModel: ObservableObject {
    
    //APPSTORAGE for storing user's username, password, id and favouriteList
    @AppStorage("username") var storedUsername: String = ""
    @AppStorage("password") var storedPassword: String = ""
    @AppStorage("id") var id: Int = 0
    @AppStorage("favList") var favList: String = "[]"
    
    //PUBLISHED PROPERTIES for user input fields - "binding" to the login/sign-up view
    //So when refreshed the app, the user credential not show again in the "login", blank
    @Published var usernameInput = ""
    @Published var passwordInput = ""
    @Published var newUsername = ""
    @Published var newPassword = ""
    
    //METHOD to STORE NEW USER credentials after sign-up
    //Saved the user input to the Appstorage
    func signUp() {
        //Store input credentials
        storedUsername = usernameInput
        storedPassword = passwordInput
        
        //Reset FAV List data
        self.favList = "[]"
    }
    
    //METHOD to VERIFY CREDENTIAL from storage (to check if the userInput is matched with the information in the Database)
    func validateCredentials() -> Bool {
        return usernameInput == storedUsername && passwordInput == storedPassword
    }
    
    //METHOD for generating the ID automatically from the system
    func getID() -> Int {
        return Int.random(in: 0...100)
    }
    
    //METHOD to save the generated ID into the APP storage
    //Makes the ID permanent throughout the App
    func saveID(){
        id = getID()
    }
    
    //METHOD to save the new username - for EditProfileView
    func saveNewDetails() {
        storedUsername = newUsername
        storedPassword = newPassword
    }
    
    //METHOD to save the favourite country
    func saveFavCountriesArray(favList: [String]) {
        do {
            let data = try JSONEncoder().encode(favList)
            self.favList = String(data: data, encoding: .utf8)!
        } catch {
            print("Error encoding array:", error)
        }
    }
    
    //METHOD to load the favourite country
    func loadFavCountriesArray() -> [String] {
        var array: [String] = []
        guard let data = self.favList.data(using: .utf8) else {
            return []
        }
        do {
            array = try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("Error decoding array:", error)
        }
        return array
    }
}
