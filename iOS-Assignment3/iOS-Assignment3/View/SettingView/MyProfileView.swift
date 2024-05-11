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
    
    @ObservedObject var profileVM = ProfileViewModel.shared
    @StateObject var userCredentialVM = UserCredentialViewModel()
    @State var isSecureField: Bool = true
    
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
        .offset(y: 35)
    }
    
    //The appearance of "Profile" Title
    var profileTitle: some View {
        Text("PROFILE")
            .font(.custom("MontserratAlternates-SemiBold", size: 50))
            .foregroundStyle(.darkPurple)
    }
    
    //The appearance of profile picture
    var profilePicture: some View {
        Image(uiImage: profileVM.avatarImage ?? UIImage(resource: .defaultAvatar))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150,height: 150)
            .clipShape(Circle())
            .padding(.bottom)
    }
    
    //The appearance of user ID
    var userID: some View {
        //linked with leonie's part
        Text("ID\(userCredentialVM.id)")
            .font(.custom("MontserratAlternates-SemiBold", size: 25))
            .foregroundStyle(.darkPurpleOp)
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
            HStack{
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                Text("\(userCredentialVM.username)")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.darkPurpleOp)
                    .tracking(3.0)
                    .padding()
                    .padding(.leading, -150)
                    .frame(maxWidth: .infinity)
            } //HStack E.
            //  INNER SHADOW (for TextField)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple)
                        .frame(height: 65)
                        .padding(.horizontal, -15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // The shape of the overlay should match the element
                                .stroke(Color.gray, lineWidth: 4) // Border color and width
                                .blur(radius: 3) // Blur the border to create a soft shadow effect
                                .offset(x: 0, y: 2) // Offset of the shadow
                                .mask(
                                    RoundedRectangle(cornerRadius: 10) // Mask using the same shape as the element
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
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                
                if isSecureField {
                    securePassField
                    //Restrict the user to modify this password
                        .disabled(true)
                } else {
                    normalPassField
                }
            }
            .overlay(alignment: .trailing){
                eyeIcon
                    .padding(.trailing, 10)
            }
            //  INNER SHADOW (for TextField)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple)
                        .frame(height: 65)
                        .padding(.horizontal, -15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // The shape of the overlay should match the element
                                .stroke(Color.gray, lineWidth: 4) // Border color and width
                                .blur(radius: 3) // Blur the border to create a soft shadow effect
                                .offset(x: 0, y: 2) // Offset of the shadow
                                .mask(
                                    RoundedRectangle(cornerRadius: 10) // Mask using the same shape as the element
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
    
    //The appearance and navigation behaviour of the edit button
    var editButton: some View {
        NavigationLink(destination: EditProfileView()){
            editLabel
        }
    }
    
    //The appearance of edit button label
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
    
    //The appearance when the password is unseen by the user
    var securePassField: some View {
        SecureField("Old password", text: $userCredentialVM.password)
            .foregroundColor(.darkPurple)
            .padding(.leading, 15)
            .frame(maxWidth: .infinity)
    }
    
    //The appearance when the password can be seen by the user
    var normalPassField: some View {
        TextField("Old password", text: $userCredentialVM.password)
            .foregroundStyle(.darkPurple)
            .padding(.leading, 15)
            .frame(maxWidth: .infinity)
    }
    
    //The appearance of eye icon to see the password
    var eyeIcon: some View {
        Image(systemName: isSecureField ? "eye.slash" : "eye")
            .foregroundStyle(.darkPurpleOp)
            .onTapGesture {
                isSecureField.toggle()
            }
    }
}

#Preview {
    MyProfileView()
}
