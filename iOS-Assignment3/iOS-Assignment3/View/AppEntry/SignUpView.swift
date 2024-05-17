//
//  SignUpView.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 6/5/2024.
//

import SwiftUI

//SIGN UP VIEW Struct
struct SignUpView: View {
    
    //STATE OBJECT for user credential view
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //STATE PROPERTIES to CHECK visibility of the password
    @State var isPwdVisible: Bool = false
    @State var confirmPwd: String = ""
    
    //STATE for form validation - CHECK VALID INPUT
    @State var isCreatedAccount: Bool = false
    //STATE to track password mismatch
    @State var showPasswordMismatchError: Bool = false
    //STATE to track username error
    @State var showUsernameError: Bool = false
    //STATE to track if User not fill all the form
    @State var showIncompleteFormError: Bool = false
    
    //SIGN UP VIEW
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                welcomeTitle
                Spacer()
                usernameLabel
                userNameField
                passwordLabel
                passwordField
                confirmPwdLabel
                confirmPwdField
                VStack(spacing: 0){
                    // Display form incompleted ERROR
                    incompleteFormError
                    // Display password mismatch ERROR
                    passwordError
                    // Display username ERROR
                    usernameError
                }
                Spacer()
                createAccountButton
                Spacer()
            }
            .padding([.leading, .trailing], 10)
        }
        .navigationDestination(isPresented: $isCreatedAccount) {
            LoadingIndicatorView2(destination: AppEntry()) {}
                .navigationBarBackButtonHidden(true)
        }
    }
    
    //WELCOME TITLE Appearance
    var welcomeTitle: some View {
        VStack {
            Text("Register")
            Text(" your account !")
        }
        .font(.custom("MontserratAlternates-SemiBold", size: 40))
        .multilineTextAlignment(.center)
    }
    
    //INPUT USERNAME Appearance
    var userNameField: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 10.0)
//                .frame(maxWidth: .infinity)
//                .foregroundStyle(.lightPurple.opacity(0.5))
//                .frame(height: 65)
//                .padding(.horizontal)
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                //"usernameTextField" refresh field to blank after turn off the app
                //Otherwise, "username" make the field still keep the previous username, not refresh it.
                TextField("Username", text: $userCredentialVM.usernameInput)
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.darkPurpleOp)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10.0)
                
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
    
    //INPUT PASSWORD Appearance
    var passwordField: some View {
        ZStack() {
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                if isPwdVisible {
                    TextField("Password", text: $userCredentialVM.passwordInput)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.darkPurple)
                        .padding(.leading, 15)
                } else {
                    SecureField("Password", text: $userCredentialVM.passwordInput)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.darkPurple)
                        .padding(.leading, 15)
                }
                Button() {
                } label: {
                    Image(systemName: isPwdVisible ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.darkPurpleOp.opacity(0.7))
                }
                .padding(.trailing, 2)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in self.isPwdVisible = pressing}, perform: {})
                
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
    
    //CONFIRM PASSWORD FIELD Appearance
    var confirmPwdField: some View {
        ZStack() {
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                if isPwdVisible {
                    TextField("Confirm Password", text: $confirmPwd)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.darkPurple)
                        .padding(.leading, 15)
                } else {
                    SecureField("Confirm Password", text: $confirmPwd)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.darkPurple)
                        .padding(.leading, 15)
                }
                Button() {
                } label: {
                    Image(systemName: isPwdVisible ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.darkPurpleOp.opacity(0.7))
                }
                .padding(.trailing, 2)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in self.isPwdVisible = pressing}, perform: {})
                
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

    //CREATE ACCOUNT BUTTON Appearance
    var createAccountButton: some View {
        VStack {
            Button {
                if isFormValid() {
                    if isValidUsername() {
                        if isCheckedPassword() {
                            //STORE new credentials
                            userCredentialVM.signUp()
                            //Navigate to LOGIN VIEW
                            isCreatedAccount = true
                            showPasswordMismatchError = false
                            showUsernameError = false
                            //GENERATE the ID automatically
                            userCredentialVM.saveID()
                        } else {
                            showPasswordMismatchError = true
                        }
                    } else {
                        showUsernameError = true
                    }
                }
            } label: {
                createAccButton
            }
        }
    }
    
    //CREATE ACCOUNT BUTTON label
    var createAccButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30.0)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .foregroundStyle(.lightPurpleCustom)
                .padding(.horizontal, 25)
                .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)
            Text("CREATE ACCOUNT")
                .font(.custom("MontserratAlternates-SemiBold", size: 23))
                .foregroundStyle(.royalPurple)
                .tracking(2.0)
        }
        .offset(y: -30)
    }
    
    //USERNAME label appearance
    var usernameLabel: some View {
        Text("Username")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //PASSWORD label appearance
    var passwordLabel: some View {
        Text("Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //CONFIRM PASSWORD label appearance
    var confirmPwdLabel: some View {
        Text("Confirm Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //ERROR Messgae
    //CHECK matched password & DISPLAY error for password mismatched
    var passwordError: some View {
        VStack {
            //Conditional view for displaying password mismatch error
            if showPasswordMismatchError {
                Text("Password is not matching!!!")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
                    .padding(.top, 2)
            }
        }
    }

    //CHECK INVALID username
    var usernameError: some View {
        VStack {
            if showUsernameError {
                Text("Username must be more than 3 characters")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
            }
        }
    }
    
    //DISPLAY/CHECK ERROR for incompleted form
    var incompleteFormError: some View {
        HStack {
            if showIncompleteFormError {
                VStack {
                    Text("Please fill in all")
                    Text("fields to create an account.")
                }
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.top, 2)
            }
        }
    }
    
    //METHOD to validate if the PASSWORD & CONFIRM PWD fields match
    func isCheckedPassword() -> Bool {
        return userCredentialVM.passwordInput == confirmPwd
    }
    
    //METHOD to check if the Username is at least 3 characters long
    func isValidUsername() -> Bool {
        return userCredentialVM.usernameInput.count >= 3
    }
    
    //METHOD to check if filled form IS EMPTY
    func isFormValid() -> Bool {
        //CHECK if any fill is empty
        if userCredentialVM.usernameInput.isEmpty || userCredentialVM.passwordInput.isEmpty || confirmPwd.isEmpty {
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
        SignUpView()
    }
}
