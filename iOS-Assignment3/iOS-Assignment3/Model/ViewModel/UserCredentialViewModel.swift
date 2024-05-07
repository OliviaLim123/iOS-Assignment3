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
    //  Published variables
    //  - for USER INPUT fileds
    //  - that "binding" to the login/sign-up view
    //  so when refreshed the app, the user credential not show again in the "login", blank
    @Published var usernameTextField = "" //usernameInput - CHANGED LATER FOR READABLE
    @Published var passwordTextField = ""
    
    @Published var newUsername = ""
    @Published var newPassword = ""
    
    //
    //  Saved the user input to the Appstorage - DELETE LATER or can be changed name to UpdateCredential later to UPDATE THE credential if required
//    func login() {
//        username = usernameTextField
//        password = passwordTextField
//    }
    
    //  FUNCTION to STORE NEW USER credentials after sign-up
    //  Saved the user input to the Appstorage
    func signUp() {
        //  Store input credentials
        username = usernameTextField
        password = passwordTextField
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
}
