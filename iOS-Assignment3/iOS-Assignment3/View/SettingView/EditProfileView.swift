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
    
    @ObservedObject var profileVM = ProfileViewModel.shared
    @StateObject var userCredentialVM = UserCredentialViewModel()
    @State var confirmPwd: String = ""
    //Environment object for navigates to the previous screen
    @Environment(\.presentationMode) var presentationMode
    
    
    //  STATE FOR FORM VALIDATION - CHECK VALID INPUT
    @State var isAccountUpdated: Bool = false
    //  State to track password mismatch
    @State var showPasswordMismatchError: Bool = false
    //  State to track username error
    @State var showUsernameError: Bool = false
    //  State to track if User not fill all the form
    @State var showIncompleteFormError: Bool = false
    //State variable to enable photo picker functionality
    @State private var photoPickerItem: PhotosPickerItem?
    
    //The body of view:
    //Represent how the edit profile looks like
    var body: some View {
        ZStack {
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
                // Display form incompleted ERROR
                incompleteFormError
                // Display password mismatch ERROR
                newPasswordError
                // Display username ERROR
                newUsernameError
                Spacer()
                Spacer()
                saveButton
                Spacer()
                Spacer()
                Spacer()
            }
            .padding(.bottom, -50)
            //Changing the picture method using the photo picker
            .onChange(of: photoPickerItem){ _, _ in
                Task {
                    if let photoPickerItem,
                       let data = try? await photoPickerItem.loadTransferable(type: Data.self){
                        if let image = UIImage(data: data){
                            profileVM.avatarImage = image
                        }
                    }
                    photoPickerItem = nil
                }
            }
        }
        .navigationDestination(isPresented: $isAccountUpdated) {
            SettingView()
                .navigationBarBackButtonHidden(true)
        }
    }
    
    //The appearance of "Edit Profile" title
    var editProfileTitle: some View {
        Text("EDIT PROFILE")
            .font(.custom("MontserratAlternates-SemiBold", size: 40))
            .foregroundStyle(.purple1)
    }
    
    //The appearance of profile picture
    var profilePicture: some View {
        Image(uiImage: profileVM.avatarImage ?? UIImage(resource: .defaultAvatar))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 130,height: 130)
            .clipShape(Circle())
    }
    
    //The appearance of user ID
    var userID: some View {
        Text("ID \(userCredentialVM.id)")
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
                .foregroundStyle(.yellowOpacity1)
                .cornerRadius(20)
                .padding(.horizontal, 100)
            
            HStack {
                Image(systemName: "photo.fill")
                    .foregroundColor(.purple1)
                Text("Change Avatar")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundStyle(.purple1)
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
        ZStack {
            HStack{
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                TextField("New username", text: $userCredentialVM.newUsername)
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .foregroundStyle(.royalPurple)
            }
            //  INNER SHADOW (for TextField)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple.opacity(0.5))
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
            HStack{
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                SecureTextField(text: $userCredentialVM.newPassword)
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .frame(height: 40)
                    .foregroundStyle(.purple1)
                    .padding(.trailing, 10)
            }
            //  INNER SHADOW (for TextField)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple.opacity(0.5))
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
            HStack{
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                SecureTextField(text: $confirmPwd)
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundColor(.purple1)
                    .frame(height: 40)
                    .padding(.trailing, 10)
            }
            //  INNER SHADOW (for TextField)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.lightPurple.opacity(0.5))
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
    
    var saveButton: some View {
        VStack {
            Button {
                if isFormValid() {
                    if isValidNewUsername() {
                        if isCheckedNewPassword() {
                            isAccountUpdated = true
                            showPasswordMismatchError = false
                            showUsernameError = false
                            // Save the new username and password
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
    
    //The appearance of save button label
    var saveLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30.0)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.yellow1)
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
    //  CHECK MATCHED PASSWORD
    //  & DISPLAY ERROR FOR PASSWORD MISMATCHED
    var newPasswordError: some View {
        VStack {
            // Conditional view for displaying password mismatch error
            if showPasswordMismatchError {
                Text("Password is not matching!")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundColor(.red)
                    .padding(.top, 2)
            }
        }
    }
    
    
    //  CHECK INVALID USERNAME
    var newUsernameError: some View {
        VStack {
            if showUsernameError {
                Text("Username must be more than 3 characters")
                    .font(.custom("MontserratAlternates-SemiBold", size: 15))
                    .foregroundColor(.red)
                //.padding(.top, 2)
            }
        }
    }
    
    //  DISPLAY/CHECK ERROR for incompleted form
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
    
    //  FUNCTION TO VALIDATE if the PASSWORD & CONFIRM PWD fields match
    func isCheckedNewPassword() -> Bool {
        return userCredentialVM.newPassword == confirmPwd
    }
    
    //  FUNCTION TO CHECKED if the Username is at least 3 characters long
    func isValidNewUsername() -> Bool {
        return userCredentialVM.newUsername.count >= 3
    }
    
    //  FUNCTION TO CHECKED IF ANY FILLED FORM IS EMPTY
    func isFormValid() -> Bool {
        //  Check if any fill is empty
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
        EditProfileView()
    }
}
