//
//  ProfileViewModel.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var avatarImage: UIImage?
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    static let shared = ProfileViewModel()
    
}
