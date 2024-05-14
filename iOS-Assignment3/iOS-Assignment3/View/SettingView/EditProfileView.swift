//
//  EditProfileView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI
import PhotosUI

//EDIT PROFILE VIEW Struct
struct EditProfileView: View {
    
    //OBSERVED OBJECT of profile and app view models
    @ObservedObject var profileVM = ProfileViewModel.shared
    @ObservedObject var appVM: AppViewModel
    
    //STATE OBJECT of user credential view model
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //STATE property of confirm password
    @State var confirmPwd: String = ""
    
    //ENVIRONMENT property - navigates to the previous screen
    @Environment(\.presentationMode) var presentationMode
    
    
    //STATE for form validation - CHECK VALID INPUT
    @State var isAccountUpdated: Bool = false
    //STATE to track password mismatch
    @State var showPasswordMismatchError: Bool = false
    //STATE to track username error
    @State var showUsernameError: Bool = false
    //STATE to track if User not fill all the form
    @State var showIncompleteFormError: Bool = false
    //STATE to enable photo picker functionality
    @State private var photoPickerItem: PhotosPickerItem?
    
    //EDIT PROFILE VIEW
    var body: some View {
        ZStack {
            VStack {
                editProfileTitle
                Spacer()
                profilePicture
                userID
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    changePicButton
                }
                .padding(.bottom)
                username
                newUsernameField
                password
                newPassField
                confirmPass
                confirmPassField
                //DISPLAY form incompleted ERROR
                incompleteFormError
                //DISPLAY password mismatch ERROR
                newPasswordError
                //DISPLAY username ERROR
                newUsernameError
                Spacer()
                Spacer()
                saveButton
                Spacer()
                Spacer()
                Spacer()
            }
            .padding(.bottom, -50)
            //CHANGING the picture method using the photo picker
            .onChange(of: photoPickerItem) { _, _ in
                Task {
                    if let photoPickerItem,
                       let data = try? await photoPickerItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            profileVM.avatarImage = image
                        }
                    }
                    photoPickerItem = nil
                }
            }
        }
        //NAVIGATES to the SETTING VIEW
        .navigationDestination(isPresented: $isAccountUpdated) {
            SettingView(viewModel: AppViewModel())
                .navigationBarBackButtonHidden(true)
        }
    }
    
    //EDIT PROFILE TITLE Appearance
    var editProfileTitle: some View {
        Text("EDIT PROFILE")
            .font(.custom("MontserratAlternates-SemiBold", size: 40))
            .foregroundStyle(.darkPurple)
    }
    
    //PROFILE PICTURE Appearance
    var profilePicture: some View {
        Image(uiImage: profileVM.avatarImage ?? UIImage(resource: .defaultAvatar))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 130,height: 130)
            .clipShape(Circle())
    }
    
    //USER ID Appearance
    var userID: some View {
        Text("ID \(userCredentialVM.id)")
            .font(.custom("MontserratAlternates-SemiBold", size: 25))
            .foregroundStyle(.darkPurpleOp)
            .padding(.horizontal, 25)
            .padding(.bottom)
    }
    
    //CHANGE PICTURE BUTTON Appearance
    var changePicButton: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .foregroundStyle(.yellowCustom)
                .cornerRadius(20)
                .padding(.horizontal, 100)
            HStack {
                Image(systemName: "photo.fill")
                    .foregroundColor(.royalPurple)
                Text("Change Avatar")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundStyle(.royalPurple)
            }
        }
    }
    
    //USERNAME TEXT Appearance
    var username: some View {
        Text("Username")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //NEW USERNAME FIELD Appearance
    var newUsernameField: some View {
        ZStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                TextField("New username", text: $userCredentialVM.newUsername)
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .foregroundStyle(.darkPurple)
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
    var password: some View {
        Text("Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //NEW PASSWORD TEXT FIELD Appearance
    var newPassField: some View {
        ZStack {
            HStack{
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                SecureTextField(text: $userCredentialVM.newPassword)
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .frame(height: 40)
                    .foregroundStyle(.darkPurple)
                    .padding(.trailing, 10)
            }
            //INNER SHADOW (for TextField)
            .background{
                ZStack{
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
    
    //CONFRIM PASSWORD Appearance
    var confirmPass: some View {
        Text("Confirm Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //CONFIRM PASSWORD FIELD Appearance
    var confirmPassField: some View {
        ZStack {
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                SecureTextField(text: $confirmPwd)
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundColor(.darkPurple)
                    .frame(height: 40)
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
    
    //SAVE BUTTON - saving the new username and password
    var saveButton: some View {
        VStack {
            Button {
                if isFormValid() {
                    if isValidNewUsername() {
                        if isCheckedNewPassword() {
                            isAccountUpdated = true
                            showPasswordMismatchError = false
                            showUsernameError = false
                            //SAVE the new username and password
                            userCredentialVM.saveNewDetails()
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showPasswordMismatchError = true
                        }
                    } else {
                        showUsernameError = true
                    }
                }
            } label: {
                saveLabel
            }
        }
    }
    
    //SAVE BUTTON Appearance
    var saveLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30.0)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.yellowCustom)
                .padding(.horizontal)
                .padding()
                .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)
            Text("SAVE")
                .font(.custom("MontserratAlternates-SemiBold", size: 23))
                .foregroundStyle(.royalPurple)
                .tracking(3.0)
        }
    }
    
    //CHECK matched new password & DISPLAY error for mismatch password
    var newPasswordError: some View {
        VStack {
            //CONDITIONAL view for displaying password mismatch error
            if showPasswordMismatchError {
                Text("Password is not matching!")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundColor(.red)
                    .padding(.top, 2)
            }
        }
    }
    
    //CHECK invalid new username
    var newUsernameError: some View {
        VStack {
            if showUsernameError {
                Text("Username must be more than 3 characters")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundColor(.red)
            }
        }
    }
    
    //DISPLAY/CHECK error for incompleted form
    var incompleteFormError: some View {
        VStack {
            if showIncompleteFormError {
                Text("The form is incomplete!")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, -15)
            }
        }
    }
    
    //METHOD to VALIDATE if the NEW PASSWORD & CONFIRM PWD fields match
    func isCheckedNewPassword() -> Bool {
        return userCredentialVM.newPassword == confirmPwd
    }
    
    //METHOD to CHECK if the NEW USERNAME is at least 3 characters long
    func isValidNewUsername() -> Bool {
        return userCredentialVM.newUsername.count >= 3
    }
    
    //METHOD to CHECK if any filled form IS EMPTY
    func isFormValid() -> Bool {
        //CHECK if any fill is empty
        if userCredentialVM.newUsername.isEmpty || userCredentialVM.newPassword.isEmpty || confirmPwd.isEmpty {
            showIncompleteFormError = true
            showPasswordMismatchError = false
            showUsernameError = false
            return false
        } else {
            showIncompleteFormError = false
            return true
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView(appVM: AppViewModel())
    }
}
