//
//  LoginViewModel.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 7/5/2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    //AppStorage is storing the username and password of the user
    @AppStorage("username") var username: String = ""
    @AppStorage("password") var password: String = ""
    //Published variables that binding to the login view
    @Published var usernameTextField = ""
    @Published var passwordTextField = ""
    
    //Saved the user input to the Appstorage
    func login() {
        username = usernameTextField
        password = passwordTextField
    }
    
    
    //  ID ?
    
}
