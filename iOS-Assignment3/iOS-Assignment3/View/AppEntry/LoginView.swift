//
//  LoginView.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 6/5/2024.
//

import SwiftUI

//LOGIN VIEW Struct
struct LoginView: View {
    
    //STATE OBJECT for user credential view
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //STATE to check the password's visibility
    @State var isPwdVisible: Bool = false
    //STATE for navigate to HomeView() if the form is valid
    //If it is TRUE, goes to the HOME VIEW
    @State var isFormValid = false
    
    //STATE for FORM VALIDATION - check valid input
    //If it is TRUE, it will show alert of unfilled form
    @State var showIncompleteFormError: Bool = false
    //If it is TRUE, it will show alert of incorrect credentials
    @State var showInvalidCredentialsError: Bool = false
    
    //LOGIN VIEW
    var body: some View {
        ZStack {
            VStack() {
                Spacer()
                welcomeTitle
                Spacer()
                userNameField
                passwordField
                // Display form incompleted ERROR
                incompleteFormError
                // Display form invalid credentials ERRORS
                invalidCredentialsError
                Spacer()
                loginButton
                signUpLink
                Spacer()
            }
            .padding([.leading, .trailing], 10)
        }
        .navigationDestination(isPresented: $isFormValid) {
            LoadingIndicatorView()
                .navigationBarBackButtonHidden(true)
        }
    }
    
    //WELCOME TITLE Appearance
    var welcomeTitle: some View {
        Text("Welcome!")
            .font(.custom("MontserratAlternates-SemiBold", size: 50))
    }

    //INPUT USERNAME Appearance
    var userNameField: some View {
        ZStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.darkPurpleOp.opacity(0.7))
                
                TextField("Username", text: $userCredentialVM.usernameInput)
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.darkPurpleOp)
                    .padding()
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
//            RoundedRectangle(cornerRadius: 10.0)
//                .frame(maxWidth: .infinity)
//                .foregroundStyle(.lightPurple.opacity(0.5))
//                .frame(height: 65)
//                .padding(.horizontal)
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
                    //isPwdVisible.toggle() - USE this one when dont want to "press to hold"
                } label: {
                    Image(systemName: isPwdVisible ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.darkPurpleOp.opacity(0.7))
                }
                .padding(.trailing)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in self.isPwdVisible = pressing}, perform: {}) //This one Press to hold
                
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
    
    //LOGIN BUTTON Appearance
    var loginButton: some View {
        VStack {
            Button {
                //CHECK unfilled form
                if isLoginFormValid() {
                    //CHECK is input matched with database of user credentials
                    if (userCredentialVM.validateCredentials()) {
                        //Navigate to "LoadingIndicatorView" -> then "HomeView"
                        isFormValid = true
                        showInvalidCredentialsError = false
                    } else {
                        showInvalidCredentialsError = true
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30.0)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundStyle(.lightPurpleCustom)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                        .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)
                    Text("LOGIN")
                        .font(.custom("MontserratAlternates-SemiBold", size: 25))
                        .foregroundStyle(.royalPurple)
                        .tracking(4.0)
                }
            }
        }
    }
    
    //SIGN UP LINK - NAVIGATE to "SignUp" Page
    var signUpLink: some View {
        NavigationLink {
            SignUpView()
        } label : {
            VStack {
                RegisterLink
            }
        }
    }
    
    //DISPLAY the View of "SignUpLink" to navigate to "SignUp" Page
    var RegisterLink: some View {
        HStack {
            Text("Don't have account ?")
                .foregroundStyle(.blackOpacity)
            
            HStack {
                Text("Register HERE")
                Image(systemName: "arrow.turn.right.up")
            }
            .foregroundStyle(.amethyst)
        }
        .font(.custom("MontserratAlternates-SemiBold", size: 14))
        .padding()
    }
    
    //DISPLAY the Error message when checked the form is incompleted
    var incompleteFormError: some View {
        VStack() {
            if showIncompleteFormError {
                Text("Please fill in all fields to login.")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
            }
        }
    }
    
    //DISPLAY the Error message for invalid credentials
    var invalidCredentialsError: some View {
        VStack {
            if showInvalidCredentialsError {
                Text("Invalid username or password.")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
            }
        }
    }
    
    //METHOD to check if the form is INCOMPLETED
    func isLoginFormValid() -> Bool {
        if userCredentialVM.usernameInput.isEmpty || userCredentialVM.passwordInput.isEmpty {
            showIncompleteFormError = true
            return false
        } else {
            showIncompleteFormError = false
            return true
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
