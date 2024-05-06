//
//  SignUpView.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 6/5/2024.
//

import SwiftUI

struct SignUpView: View {
    
    //  LOGIN CREDENTIALS
    @State var username: String = ""
    @State var password: String = ""
    
    @State var isPwdVisible: Bool = false
    @State var confirmPwd: String = ""
    
    
    @State var isCreatedAccount: Bool = false
    // State to track password mismatch
    @State var showPasswordMismatchError: Bool = false


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
                
                passwordError // Display the error here
                
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
        Text("Register your account !")
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
                
                TextField("Username", text: $username)
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
                    TextField("Password", text: $password)
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.purple1)
                        .padding(.leading, 15)
            
                    
                } else {
                    SecureField("Password", text: $password)
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
                if isCheckedPassword() {
                    isCreatedAccount = true //Set the isCreatedaccount to true is passwords matched
                    showPasswordMismatchError = false
                } else {
                    showPasswordMismatchError = true
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
    
    //  FUNCTION TO CHECKED PASSWORD
    func isCheckedPassword() -> Bool {
        return password == confirmPwd
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
}
