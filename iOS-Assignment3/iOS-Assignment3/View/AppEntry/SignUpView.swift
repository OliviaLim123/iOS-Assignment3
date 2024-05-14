//
//  SignUpView.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 6/5/2024.
//

import SwiftUI

struct SignUpView: View {
    
    //  LOGIN CREDENTIALS
    //    @State var username: String = ""
    //    @State var password: String = ""
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //  CHECK visibility of the password
    @State var isPwdVisible: Bool = false
    @State var confirmPwd: String = ""
    
    
    //  STATE FOR FORM VALIDATION - CHECK VALID INPUT
    @State var isCreatedAccount: Bool = false
    //  State to track password mismatch
    @State var showPasswordMismatchError: Bool = false
    //  State to track username error
    @State var showUsernameError: Bool = false
    //  State to track if User not fill all the form
    @State var showIncompleteFormError: Bool = false
    
    
    //  MainView
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
            //AppEntry()
            LoadingIndicatorView2(destination: AppEntry()) {}
                .navigationBarBackButtonHidden(true)
        }
    }
    
    //  WELCOME TITLE
    var welcomeTitle: some View {
        VStack {
            Text("Register")
            Text(" your account !")
        }
        .font(.custom("MontserratAlternates-SemiBold", size: 40))
        .multilineTextAlignment(.center)
    }
    
    //  INPUT USERNAME
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
                
                TextField("Username", text: $userCredentialVM.usernameTextField) // the "usernameTextField" refresh field to blank after turn off the app; otherwise; "username" make the field still keep the previous username, not refresh it.
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.darkPurpleOp)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10.0)
                
            } //HStack
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
        }//ZStack S.
    }
    
    //  INPUT PASSWORD
    var passwordField: some View {
        ZStack() {
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                
                if isPwdVisible {
                    TextField("Password", text: $userCredentialVM.passwordTextField)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.darkPurple)
                        .padding(.leading, 15)
                    
                    
                } else {
                    SecureField("Password", text: $userCredentialVM.passwordTextField)
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
                
            } //HStack
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
            
        }//ZStack S.
    }
    
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
                
            } //HStack
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
            
        }//ZStack S.
    }
    
    
    //  CREATE ACCOUNT BUTTON
    var createAccountButton: some View {
        VStack {
            Button {
                if isFormValid() {
                    if isValidUsername() {
                        if isCheckedPassword() {
                            //  STORE NEW CREDENTIAL
                            userCredentialVM.signUp()
                            isCreatedAccount = true // Navigate to LoginView
                            showPasswordMismatchError = false
                            showUsernameError = false
                            // Generate the ID automatically
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
        }// VSTACK E.
    }
    
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
    
    //  FIELD LABEL
    //The appearance of password text
    var usernameLabel: some View {
        Text("Username")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //The appearance of password text
    var passwordLabel: some View {
        Text("Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    //The appearance of confirm password text
    var confirmPwdLabel: some View {
        Text("Confirm Password")
            .font(.custom("MontserratAlternates-SemiBold", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    
    //  ERROR MESSAGE
    //  CHECK MATCHED PASSWORD
    //  & DISPLAY ERROR FOR PASSWORD MISMATCHED
    var passwordError: some View {
        VStack {
            // Conditional view for displaying password mismatch error
            if showPasswordMismatchError {
                Text("Password is not matching!!!")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
                    .padding(.top, 2)
            }
        }
    }
    
    
    //  CHECK INVALID USERNAME
    var usernameError: some View {
        VStack {
            if showUsernameError {
                Text("Username must be more than 3 characters")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
                //.padding(.top, 2)
            }
        }
    }
    
    //  DISPLAY/CHECK ERROR for incompleted form
    var incompleteFormError: some View {
        HStack {
            if showIncompleteFormError {
                Text("Please fill in all fields to create an account.")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
            }
        }
    }
    
    
    //
    //  FUNCTION
    //
    //  FUNCTION TO VALIDATE if the PASSWORD & CONFIRM PWD fields match
    func isCheckedPassword() -> Bool {
        return userCredentialVM.passwordTextField == confirmPwd
    }
    
    //  FUNCTION TO CHECKED if the Username is at least 3 characters long
    func isValidUsername() -> Bool {
        return userCredentialVM.usernameTextField.count >= 3
    }
    
    //  FUNCTION TO CHECKED IF ANY FILLED FORM IS EMPTY
    func isFormValid() -> Bool {
        //  Check if any fill is empty
        if userCredentialVM.usernameTextField.isEmpty || userCredentialVM.passwordTextField.isEmpty || confirmPwd.isEmpty {
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
