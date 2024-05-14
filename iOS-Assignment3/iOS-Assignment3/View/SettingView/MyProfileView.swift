//
//  MyProfileView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI
import PhotosUI

//MY PROFILE VIEW Struct
struct MyProfileView: View {
    
    //OBSERVED OBJECT of profile and app view models
    @ObservedObject var profileVM = ProfileViewModel.shared
    @ObservedObject var appVM: AppViewModel
    
    //STATE OBJECT of user credential view model
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //STATE Property to track if the text field is secure
    @State var isSecureField: Bool = true
    
    //MY PROFILE VIEW
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
        .offset(y: 35)
    }
    
    //PROFILE TITLE Appearance
    var profileTitle: some View {
        Text("PROFILE")
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
    
    //USER ID Appearance
    var userID: some View {
        Text("ID\(userCredentialVM.id)")
            .font(.custom("MontserratAlternates-SemiBold", size: 25))
            .foregroundStyle(.darkPurpleOp)
            .padding(.horizontal, 25)
            .padding(.bottom)
    }
    
    //USERNAME TEXT Appearance
    var oldUsername: some View {
        Text("Username")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //OLD USERNAME FIELD Appearance (before changing to the new one)
    var oldUsernameField: some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                Text("\(userCredentialVM.storedUsername)")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.darkPurpleOp)
                    .tracking(3.0)
                    .padding()
                    .padding(.leading, -150)
                    .frame(maxWidth: .infinity)
            }
            //INNER SHADOW (for TextField)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple)
                        .frame(height: 65)
                        .padding(.horizontal, -15)
                        .overlay(
                            //The shape of the overlay should match the element
                            RoundedRectangle(cornerRadius: 10)
                                //Border color and width
                                .stroke(Color.gray, lineWidth: 4)
                                //Blur the border to create a soft shadow effect
                                .blur(radius: 3)
                                //Offset of the shadow
                                .offset(x: 0, y: 2)
                                .mask(
                                    //Mask using the same shape as the element
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)
                                        )
                                )
                                .padding(.horizontal, -15)
                        )
                }
            }
            .padding()
            .padding(.horizontal)
        }
    }
    
    //PASSWORD TEXT Appearance
    var oldPassword: some View {
        Text("Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //OLD PASSWORD FIELD Appearance (before changing to the new one)
    var oldPasswordField: some View {
        ZStack(alignment: .leading){
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                
                if isSecureField {
                    securePassField
                        //RESTRICT the user to modify this password
                        .disabled(true)
                } else {
                    normalPassField
                }
            }
            .overlay(alignment: .trailing) {
                eyeIcon
                    .padding(.trailing, 10)
            }
            //INNER SHADOW (for TextField)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple)
                        .frame(height: 65)
                        .padding(.horizontal, -15)
                        .overlay(
                            //The shape of the overlay should match the element
                            RoundedRectangle(cornerRadius: 10)
                                //Border color and width
                                .stroke(Color.gray, lineWidth: 4)
                                //Blur the border to create a soft shadow effect
                                .blur(radius: 3)
                                //Offset of the shadow
                                .offset(x: 0, y: 2)
                                .mask(
                                    //Mask using the same shape as the element
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)
                                        )
                                )
                                .padding(.horizontal, -15)
                        )
                }
            }
            .padding()
            .padding(.horizontal)
        }
    }
    
    //EDIT BUTTON - navigates to the EDIT PROFILE VIEW
    var editButton: some View {
        NavigationLink(destination: EditProfileView(appVM: self.appVM)){
            editLabel
        }
    }
    
    //EDIT BUTTON Appearance
    var editLabel: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.lightPurpleCustom)
                .padding(.horizontal)
                .padding()
                .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)
            Text("EDIT")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .tracking(4.0)
                .foregroundStyle(.royalPurple)
        }
    }
    
    //SECURE PASSWORD FIELD of unseen password
    var securePassField: some View {
        SecureField("Old password", text: $userCredentialVM.storedPassword)
            .foregroundColor(.darkPurple)
            .padding(.leading, 15)
            .frame(maxWidth: .infinity)
    }
    
    //NORMAL PASSWORD FIELD of seen password
    var normalPassField: some View {
        TextField("Old password", text: $userCredentialVM.storedPassword)
            .foregroundStyle(.darkPurple)
            .padding(.leading, 15)
            .frame(maxWidth: .infinity)
    }
    
    //EYE ICON Appearance to see the password
    var eyeIcon: some View {
        Image(systemName: isSecureField ? "eye.slash" : "eye")
            .foregroundStyle(.darkPurpleOp)
            .onTapGesture {
                isSecureField.toggle()
            }
    }
}

#Preview {
    MyProfileView(appVM: AppViewModel())
}
