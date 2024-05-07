//
//  SettingView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI
import PhotosUI

//A view of setting
struct SettingView: View {
    
    @ObservedObject var viewModel = ProfileViewModel.shared
    @StateObject var loginVM = LoginViewModel()
    //State variables to handle the display mode function
    @State private var darkMode: Bool = false
    @State private var currentMode: ColorScheme = .light
    
    //The body of view:
    //Represent how the setting View looks like
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
    }
    
    //The appearance of "Setting" title
    var settingTitle: some View {
        Text("SETTING")
            .font(.custom("MontserratAlternates-SemiBold", size: 50))
            .foregroundStyle(.purple1)
    }
    
    //The appearance of profile picture
    var profilePicture: some View {
        Image(uiImage: viewModel.avatarImage ?? UIImage(resource: .defaultAvatar))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150,height: 150)
            .clipShape(Circle())
            .padding(.bottom)
    }
    
    //The appearance of ID and username of the user
    var profileInfo: some View {
        HStack{
            //will be linked with leonie's part
            Text("ID\(Int.random(in: 0...100))")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.purpleOpacity1)
                .padding(.horizontal, 25)
            //will be linked with leonie's part
            Text("\(loginVM.username)")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.purpleOpacity1)
        }
    }
    
    //The appearance and navigation behavior of the edit profile button
    var editProfileButton: some View {
        NavigationLink {
            MyProfileView()
        } label: {
            editProfileLabel
        }
        .padding(.bottom)
    }
   
    //The appearance of edit profile label for the button
    var editProfileLabel: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundStyle(.yellowOpacity1)
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
    
    //The appearance of dark mode button
    var darkModeButton: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundStyle(.yellowOpacity1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            HStack{
                Image(systemName: "moon.fill")
                    .foregroundStyle(.black)
                    .font(.title2)
                Text("Dark Mode")
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundStyle(.black)
                darkModeToggle
                Spacer(minLength: 30)
            }
            .padding(.leading, 40)
        }
        .padding(.bottom)
    }
    
    //The appearance of dark mode toggle
    var darkModeToggle: some View {
        Toggle("", isOn: $darkMode)
            .onChange(of: darkMode){ newValue, _ in
                currentMode = newValue ? .light : .dark
            }
            .preferredColorScheme(currentMode)
            .toggleStyle(SwitchToggleStyle(tint: Color.purple))
    }
    
    //The appearance and navigation behaviour of the favorite country button
    var myFavCountryButton: some View {
        NavigationLink {
            FavCountryView()
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
                .foregroundStyle(.yellowOpacity1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
    
    //The appearance and navigation behaviour of log out button
    var logOutButton: some View {
        NavigationLink {
            //logout function - linked with leonie's part
        } label: {
            logOutLabel
        }
    }
    
    //The appearance of log out label for the button
    var logOutLabel: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.purple2)
                .padding(.horizontal)
            Text("LOG OUT")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}
