//
//  LoginViewModel.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 7/5/2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @AppStorage("username") var username: String = ""
    @AppStorage("password") var password: String = ""
    
    @Published var usernameTextField = ""
    @Published var passwordTextField = ""
    
    func login() {
        username = usernameTextField
        password = passwordTextField
    }
    
    
    //  ID ?
    
}
