//
//  ProfileViewModel.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

//PROFILE VIEW MODEL - handling the user profile model
class ProfileViewModel: ObservableObject {
    
    //PUBLISHED PROPERTY for handling the profile information
    @Published var avatarImage: UIImage?
    
    //STATIC PROPERTY
    static let shared = ProfileViewModel()
    
}
