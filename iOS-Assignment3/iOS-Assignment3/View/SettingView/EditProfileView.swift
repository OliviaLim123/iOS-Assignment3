//
//  EditProfileView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI
import PhotosUI

//A view of edit profile screen
struct EditProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel.shared
    //State variable to enable photo picker functionality
    @State private var photoPickerItem: PhotosPickerItem?
    
    //The body of view:
    //Represent how the edit profile looks like
    var body: some View {
        VStack {
            editProfileTitle
            Spacer()
            profilePicture
            userID
            PhotosPicker(selection: $photoPickerItem, matching: .images){
                changePicButton
            }
            .padding(.bottom)
            username
            newUsernameField
            password
            newPassField
            confirmPass
            confirmPassField
            Spacer()
            Spacer()
            saveButton
            Spacer()
            Spacer()
            Spacer()
        }
        //Changing the picture method using the photo picker
        .onChange(of: photoPickerItem){ _, _ in
            Task {
                if let photoPickerItem,
                   let data = try? await photoPickerItem.loadTransferable(type: Data.self){
                    if let image = UIImage(data: data){
                        viewModel.avatarImage = image
                    }
                }
                photoPickerItem = nil
            }
        }
    }
    
    //The appearance of "Edit Profile" title
    var editProfileTitle: some View {
        Text("EDIT PROFILE")
            .font(.custom("MontserratAlternates-SemiBold", size: 45))
            .foregroundStyle(.purple1)
    }
    
    //The appearance of profile picture
    var profilePicture: some View {
        Image(uiImage: viewModel.avatarImage ?? UIImage(resource: .defaultAvatar))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150,height: 150)
            .clipShape(Circle())
    }
    
    //The appearance of user ID
    var userID: some View {
        //linked to the leoni's part
        Text("ID001")
            .font(.custom("MontserratAlternates-SemiBold", size: 25))
            .foregroundStyle(.purpleOpacity1)
            .padding(.horizontal, 25)
            .padding(.bottom)
    }
    
    //The appearance of change picture button
    var changePicButton: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .foregroundStyle(.yellow1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            HStack {
                Image(systemName: "photo.fill")
                    .foregroundColor(.black)
                Text("Change Profile Picture")
                    .foregroundStyle(.black)
            }
        }
    }
    
    //The appearance of username text
    var username: some View {
        Text("Username")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //The appearance of new username text field
    var newUsernameField: some View {
        //I haven't linked them with leonie's part
        ZStack {
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
                TextField("New username", text: $viewModel.username)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .foregroundStyle(.black)
            }
            .padding(.leading, 40)
        }
    }
    
    //The appearance of password text
    var password: some View {
        Text("Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //The appearance of new password text field
    var newPassField: some View {
        ZStack {
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
                SecureTextField(text: $viewModel.password)
                    .padding(.trailing, 40)
                    .foregroundColor(.black)
            }
            .padding(.leading, 40)
        }
    }
    
    //The appearance of confirm password
    var confirmPass: some View {
        Text("Confirm Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //The appreance of confirm password text field
    var confirmPassField: some View {
        ZStack {
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
                SecureTextField(text: $viewModel.confirmPassword)
                    .padding(.trailing, 40)
                    .foregroundColor(.black)
            }
            .padding(.leading, 40)
        }
    }
    
    //The appearance and naviagation behaviour of save button
    var saveButton: some View {
        NavigationLink {
            //save button function
        } label: {
            saveLabel
        }
    }
    
    //The appearance of save button label
    var saveLabel: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.yellow1)
                .padding(.horizontal)
            Text("SAVE")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    EditProfileView()
}
