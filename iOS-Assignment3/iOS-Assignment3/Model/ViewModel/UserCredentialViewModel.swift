//
//  LoginViewModel.swift - This one for handling User Credential model.
//                       - Can changed the named to userCredentialVM ?
//  iOS-Assignment3
//
//  Created by Hang Vu on 7/5/2024.
//

import SwiftUI

class UserCredentialViewModel: ObservableObject {
    
    //  'AppStorage' is securely storing the username and password of the user
    @AppStorage("username") var username: String = "" //storedUsername - CHANGED LATER FOR READABLE
    @AppStorage("password") var password: String = "" //storePassword
    @AppStorage("id") var id: Int = 0 //store userID
    @AppStorage("favList") var favList: String = "[]"; //   Store favorite countries
    
    //  Published variables
    //  - for USER INPUT fileds
    //  - that "binding" to the login/sign-up view
    //  so when refreshed the app, the user credential not show again in the "login", blank
    @Published var usernameTextField = "" //usernameInput - CHANGED LATER FOR READABLE
    @Published var passwordTextField = ""
    
    @Published var newUsername = ""
    @Published var newPassword = ""
    
    //  FUNCTION to STORE NEW USER credentials after sign-up
    //  Saved the user input to the Appstorage
    func signUp() {
        //  Store input credentials
        username = usernameTextField;
        password = passwordTextField;
        
        //  Reset FAV List data
        self.favList = "[]";
    }
    
    //  FUNCTION to VERIFY CREDENTIAL from storage (to check if the userInput is matched with the information in the Database)
    func validateCredentials() -> Bool {
        return usernameTextField == username && passwordTextField == password
    }
    
    //  Generating the ID automatically from the system
    func getID() -> Int {
        return Int.random(in: 0...100)
    }
    
    // Save the generated ID into the APP storage
    // Makes the ID permanent throughout the App
    func saveID(){
        id = getID()
    }
    
    // Saving the new username - for EditProfileView
    func saveNewDetails() {
        username = newUsername
        password = newPassword
    }
    
    func saveFavCountriesArray(favList: [String]) {
        do {
            let data = try JSONEncoder().encode(favList)
            self.favList = String(data: data, encoding: .utf8)!
        } catch {
            print("Error encoding array:", error)
        }
    }
    
    func loadFavCountriesArray() -> [String]{
        var array: [String] = [];
        
        guard let data = self.favList.data(using: .utf8) else {
            return [];
        }
        
        do {
            array = try JSONDecoder().decode([String].self, from: data);
        } catch {
            print("Error decoding array:", error)
        }
        
        return array;
    }

}
