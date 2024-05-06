//
//  UserModel.swift
//  iOS-Assignment3
//
//  Created by Huynh Phuong Thao Nhi on 06/05/2024.
//

import Foundation

class User{
    private var userName: String;
    private var password: String;
    private var favCountries: [String] = [];
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    func getUserName() -> String{
        return self.userName;
    }
    
    func getPassword() -> String{
        return self.password;
    }
    
    func setUserName(with newUserName: String){
        self.userName = newUserName;
    }
    
    func setPassword(with newPassword: String){
        self.password = newPassword;
    }
    
    func getFavCountries() -> [String]{
        return self.favCountries;
    }
    
    func addFavCountry(with newCountry: String){
        //  CONTROL favorite Countries List at most 10 Countries
        if(self.favCountries.count >= 10){
            return;
        }
        
        self.favCountries.append(newCountry);
        self.favCountries.sort();
    }
    
    func removeFavCountry(country: String){
        self.favCountries.removeAll(where: {
            country == $0;
        })
    }
    
}
