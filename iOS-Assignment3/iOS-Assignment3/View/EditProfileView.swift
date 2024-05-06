//
//  EditProfileView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel.shared
    @State private var photoPickerItem: PhotosPickerItem?
    var body: some View {
        VStack {
            Text("EDIT PROFILE")
                .font(.custom("MontserratAlternates-SemiBold", size: 45))
                .foregroundStyle(.purple1)
            Spacer()
            Image(uiImage: viewModel.avatarImage ?? UIImage(resource: .defaultAvatar))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150,height: 150)
                .clipShape(Circle())
            //linked to the leoni's part
            Text("ID001")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.purpleOpacity1)
                .padding(.horizontal, 25)
                .padding(.bottom)
            PhotosPicker(selection: $photoPickerItem, matching: .images){
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
            .padding(.bottom)
            //I haven't linked them with leonie's part
            Text("Username")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundStyle(.usernameColour)
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
                }
                .padding(.leading, 40)
            }
            Text("Password")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundStyle(.usernameColour)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "lock.circle.fill")
                        .foregroundStyle(.black)
                        .font(.title2)
                    SecureTextField(text: $viewModel.password)
                        .padding(.trailing, 40)
                }
                .padding(.leading, 40)
            }
            Text("Confirm Password")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundStyle(.usernameColour)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "lock.circle.fill")
                        .foregroundStyle(.black)
                        .font(.title2)
                    SecureTextField(text: $viewModel.confirmPassword)
                        .padding(.trailing, 40)
                }
                .padding(.leading, 40)
            }
            Spacer()
            NavigationLink {
                //save button function
            } label: {
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
            Spacer()
            Spacer()
            Spacer()
            
        }
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
}

#Preview {
    EditProfileView()
}
