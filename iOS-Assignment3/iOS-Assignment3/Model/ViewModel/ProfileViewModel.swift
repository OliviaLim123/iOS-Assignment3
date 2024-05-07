//
//  ProfileViewModel.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    //Published properties for handling the profile information
    @Published var avatarImage: UIImage?
    
    static let shared = ProfileViewModel()
    
}
