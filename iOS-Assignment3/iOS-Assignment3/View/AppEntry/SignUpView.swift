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
    @StateObject var loginVM = LoginViewModel()
    
    //  CHECK visibility of the password
    @State var isPwdVisible: Bool = false
    @State var confirmPwd: String = ""
    
    
    //  CHECK VALID INPUT
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
            VStack(spacing: 25) {
                Spacer()
                welcomeTitle
                Spacer()
                userNameField
                passwordField
                
                confirmPwdField
                
                // Display form incompleted ERROR
                incompleteFormError
                // Display password mismatch ERROR
                passwordError
                // Display username ERROR
                usernameError
                
                Spacer()
                createAccountButton
                Spacer()
            }
            .padding([.leading, .trailing], 10)
        }
        .navigationDestination(isPresented: $isCreatedAccount) {
            AppEntry()
        }
    }
    
    //  WELCOME TITLE
    var welcomeTitle: some View {
        Text("Register \nyour account !")
            .font(.custom("MontserratAlternates-SemiBold", size: 40))
            .multilineTextAlignment(.center)
    }
    
    //  INPUT USERNAME
    var userNameField: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.lightPurple.opacity(0.5))
                .frame(height: 65)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                TextField("Username", text: $loginVM.username)
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.purpleOpacity1)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10.0)
                
            } //HStack
            .padding()
            .padding(.horizontal)
        }//ZStack S.
    }
    
    //  INPUT PASSWORD
    var passwordField: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.lightPurple.opacity(0.5))
                .frame(height: 65)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                if isPwdVisible {
                    TextField("Password", text: $loginVM.password)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.purple1)
                        .padding(.leading, 15)
                    
                    
                } else {
                    SecureField("Password", text: $loginVM.password)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.purple1)
                        .padding(.leading, 15)
                }
                
                Button() {
                } label: {
                    Image(systemName: isPwdVisible ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.purpleOpacity1.opacity(0.7))
                }
                .padding(.trailing, 2)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in self.isPwdVisible = pressing}, perform: {})
                
            } //HStack
            .padding()
            .padding(.horizontal)
            
        }//ZStack S.
    }
    
    var confirmPwdField: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.lightPurple.opacity(0.5))
                .frame(height: 65)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                if isPwdVisible {
                    TextField("Confirm Password", text: $confirmPwd)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.purple1)
                        .padding(.leading, 15)
                    
                    
                } else {
                    SecureField("Confirm Password", text: $confirmPwd)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.purple1)
                        .padding(.leading, 15)
                }
                
                Button() {
                } label: {
                    Image(systemName: isPwdVisible ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.purpleOpacity1.opacity(0.7))
                }
                .padding(.trailing, 2)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in self.isPwdVisible = pressing}, perform: {})
                
            } //HStack
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
                            isCreatedAccount = true
                            showPasswordMismatchError = false
                            showUsernameError = false
                        } else {
                            showPasswordMismatchError = true
                        }
                    } else {
                        showUsernameError = true
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
                    
                    Text("CREATE ACCOUNT")
                        .font(.custom("MontserratAlternates-SemiBold", size: 23))
                        .foregroundStyle(.royalPurple)
                        .tracking(2.0)
                }
            }
            
        }// VSTACK E.
    }
    
    //  CHECK MATCHED PASSWORD
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
    
    
    //  CHECK Username Condition
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
    
    //  DISPLAY/CHECK when the Form is incompleted
    var incompleteFormError: some View {
        VStack {
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
    //  FUNCTION TO CHECKED PASSWORD
    func isCheckedPassword() -> Bool {
        return loginVM.password == confirmPwd
    }
    
    //  FUNCTION TO CHECKED Username
    func isValidUsername() -> Bool {
        return loginVM.username.count >= 3
    }
    
    //  FUNCTION TO CHECKED IF ANY FILLED FORM IS EMPTY
    func isFormValid() -> Bool {
        //  Check if any fill is empty
        if loginVM.username.isEmpty || loginVM.password.isEmpty || confirmPwd.isEmpty {
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
