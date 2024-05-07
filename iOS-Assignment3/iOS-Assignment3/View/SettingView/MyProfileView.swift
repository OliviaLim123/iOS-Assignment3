//
//  MyProfileView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI
import PhotosUI

//A view of my profile screen
struct MyProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel.shared
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //The body of view:
    //Represent how the profile looks like
    var body: some View {
        VStack {
            profileTitle
            Spacer()
            profilePicture
            userID
            oldUsername
            oldUsernameField
            oldPassword
            oldPasswordField
            Spacer()
            editButton
            Spacer()
            Spacer()
        }
    }
    
    //The appearance of "Profile" Title
    var profileTitle: some View {
        Text("PROFILE")
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
    
    //The appearance of user ID
    var userID: some View {
        //linked with leonie's part
        Text("ID001")
            .font(.custom("MontserratAlternates-SemiBold", size: 25))
            .foregroundStyle(.purpleOpacity1)
            .padding(.horizontal, 25)
            .padding(.bottom)
    }
    
    //The appearance of username text
    var oldUsername: some View {
        Text("Username")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //The appearance of old username (before changing to the new one)
    var oldUsernameField: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.purple2)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            HStack{
                Image(systemName: "person.circle.fill")
                    .foregroundStyle(.black)
                    .font(.title2)
                //should be linked with the leonie part
                Text("\(userCredentialVM.username)")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundStyle(.black)
            }
            .padding(.leading, 40)
        }
    }
    
    //The appearance of old password text
    var oldPassword: some View {
        Text("Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //The appearance of old password field (before changing to the new one)
    var oldPasswordField: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.purple2)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            HStack{
                Image(systemName: "lock.circle.fill")
                    .foregroundStyle(.black)
                    .font(.title2)
                //should be linked with the leonie part
                Text("\(userCredentialVM.password)")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundStyle(.black)
            }
            .padding(.leading, 40)
        }
    }
    
    //The appearance and navigation behaviour of the edit button
    var editButton: some View {
        NavigationLink {
            EditProfileView()
        } label: {
            editLabel
        }
    }
    
    //The appearance of edit button label 
    var editLabel: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.yellow1)
                .padding(.horizontal)
            Text("EDIT")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    MyProfileView()
}
