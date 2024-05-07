//
//  LoginView.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 6/5/2024.
//

import SwiftUI

struct LoginView: View {
    
    //  LOGIN CREDENTIALS
    //    @State var username: String = ""
    //    @State var password: String = ""
    
    @StateObject var userCredentialVM = UserCredentialViewModel()
    
    //  STATE to check the password's visibility
    @State var isPwdVisible: Bool = false
    
    //  STATE for navigate to HomeView() if the form is valid
    @State var isFormValid = false // True >> Go to HomeView()
    
    //  STATE FOR FORM VALIDATION - CHECK VALID INPUT
    @State var showIncompleteFormError: Bool = false // True >> Show Alert of unfilled form
    @State var showInvalidCredentialsError: Bool = false // True >> Show Alert of incorrect credentials
    
    
    //  MainView
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
            HomeView()
                .navigationBarBackButtonHidden(true)
        }
    }
    
    //  WELCOME TITLE
    var welcomeTitle: some View {
        Text("Welcome!")
            .font(.custom("MontserratAlternates-SemiBold", size: 50))
    }
    
    //  INPUT USERNAME
    var userNameField: some View {
        ZStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                TextField("Username", text: $userCredentialVM.usernameTextField)
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.purpleOpacity1)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10.0)
                
            } //HStack
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
        }//ZStack S.
    }
    
    //  INPUT PASSWORD
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
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                if isPwdVisible {
                    TextField("Password", text: $userCredentialVM.passwordTextField)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.purple1)
                        .padding(.leading, 15)
                    
                } else {
                    SecureField("Password", text: $userCredentialVM.passwordTextField)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.purple1)
                        .padding(.leading, 15)
                }
                
                Button() {
                    //isPwdVisible.toggle() - USE this one when dont want to "press to hold"
                } label: {
                    Image(systemName: isPwdVisible ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.purpleOpacity1.opacity(0.7))
                }
                .padding(.trailing)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in self.isPwdVisible = pressing}, perform: {}) //this one Press to hold
                
            } //HStack
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
        }//ZStack S.
    }
    
    //  LOGIN BUTTON
    var loginButton: some View {
        VStack {
            Button {
                if isLoginFormValid() { //check unfilled form
                    
                    // check is input matched with database of user credentials
                    if (userCredentialVM.validateCredentials()) {
                        
                        isFormValid = true//Navigate to "HomeView"
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
                        .foregroundStyle(.purple2)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                        .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)
                    
                    Text("LOGIN")
                        .font(.custom("MontserratAlternates-SemiBold", size: 25))
                        .foregroundStyle(.royalPurple)
                        .tracking(4.0)
                }
            }
        }// VSTACK E.
    }
    
    //  NAVIGATE to "SignUp" Page
    var signUpLink: some View {
        NavigationLink {
            SignUpView()
        } label : {
            VStack {
                RegisterLink
            }
        }
    }
    
    //  DISPLAY the View of "SignUpLink" to navigate to "SignUp" Page
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
    
    //  DISPLAY the Error message when checked the form is incompleted
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
    
    // DISPLAY the Error message for invalid credentials
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
    
    //  FUNCTION
    //  FUNCTION TO CHECK if THE FORM is INCOMPLETED
    func isLoginFormValid() -> Bool {
        if userCredentialVM.usernameTextField.isEmpty || userCredentialVM.passwordTextField.isEmpty {
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
