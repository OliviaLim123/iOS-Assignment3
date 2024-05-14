//
//  SettingView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI
import PhotosUI

//SETTING VIEW Struct
struct SettingView: View {
    
    //OBSERVED OBEJCT of profile and app view models
    @ObservedObject var profileVM = ProfileViewModel.shared
    @ObservedObject var appVM: AppViewModel
    
    //STATE OBJECT of user credential view model
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //APP STORAGE for handling the display mode function
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    //INIT Method for initialise the appVM
    init(viewModel: AppViewModel){
        self.appVM = viewModel
    }
    
    //SETTING VIEW
    var body: some View {
        VStack{
            settingTitle
            profilePicture
            profileInfo
            Spacer()
            editProfileButton
            darkModeButton
            myFavCountryButton
            Spacer()
            logOutButton
            Spacer()
            Spacer()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    //SETTING TITLE Appearance
    var settingTitle: some View {
        Text("SETTING")
            .font(.custom("MontserratAlternates-SemiBold", size: 50))
            .foregroundStyle(.darkPurple)
    }
    
    //PROFILE PICTURE Appearance
    var profilePicture: some View {
        Image(uiImage: profileVM.avatarImage ?? UIImage(resource: .defaultAvatar))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150,height: 150)
            .clipShape(Circle())
            .padding(.bottom)
    }
    
    //ID and USERNAME Appearance
    var profileInfo: some View {
        HStack{
            Text("ID\(userCredentialVM.id)")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.darkPurpleOp)
                .padding(.horizontal, 25)
            Text("\(userCredentialVM.storedUsername)")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.darkPurpleOp)
        }
    }
    
    //EDIT PROFILE BUTTON - navigates to the MY PROFILE VIEW
    var editProfileButton: some View {
        NavigationLink {
            MyProfileView(appVM: self.appVM);
        } label: {
            editProfileLabel
        }
        .padding(.bottom)
    }
   
    //EDIT PROFILE BUTTON Appearance
    var editProfileLabel: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundStyle(.yellowOpacity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            HStack{
                Image(systemName: "square.and.pencil")
                    .foregroundStyle(.black)
                    .font(.title2)
                Text("My Profile")
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundStyle(.black)
                
            }
            .padding(.leading, 40)
        }
    }
    
    //DARK MODE BUTTON Appearance
    var darkModeButton: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundStyle(.yellowOpacity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            HStack{
                Image(systemName: "moon.fill")
                    .foregroundStyle(.black)
                    .font(.title2)
                Text("Dark Mode")
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundStyle(.black)
                Spacer()
                darkModeToggle
                    .padding(.trailing,20)
            }
            .padding(.leading, 40)
        }
        .padding(.bottom)
    }
    
    //DARK MODE TOGGLE Appearance
    var darkModeToggle: some View {
        Toggle("", isOn: $isDarkMode)
            .toggleStyle(SwitchToggleStyle(tint: .purple))
            .labelsHidden()
            .padding(.trailing, 10)
    }
    
    //The appearance and navigation behaviour of the favorite country button
    var myFavCountryButton: some View {
        NavigationLink {
            FavCountryView(appVM: self.appVM);
        } label: {
            myFavCountryLabel
        }
    }
    
    //The appearance of my favourite country label for the button
    var myFavCountryLabel: some View {
        ZStack (alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundStyle(.yellowOpacity)
                .cornerRadius(10)
                .padding(.horizontal)
            HStack{
                Image(systemName: "heart")
                    .foregroundStyle(.black)
                    .font(.title2)
                Text("Favourite country")
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundStyle(.black)
                
            }
            .padding(.leading, 40)
        }
    }
    
    //LOG OUT BUTTON - navigates to the APP ENTRY VIEW
    var logOutButton: some View {
        NavigationLink {
            AppEntry()
        } label: {
            logOutLabel
        }
    }
    
    //LOG OUT BUTTON Appearance
    var logOutLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.lightPurpleCustom)
                .padding()
                .padding(.horizontal)
                .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)
            Text("LOG OUT")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .foregroundStyle(.royalPurple)
                .tracking(3.0)
        }
    }
}

#Preview {
    NavigationStack {
        SettingView(viewModel: AppViewModel())
    }
}
