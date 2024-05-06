//
//  LoginView.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 6/5/2024.
//

import SwiftUI

struct LoginView: View {
    
    //  LOGIN CREDENTIALS
    @State var username: String = ""
    @State var password: String = ""
    @State var isPwdVisible: Bool = false
    
    //  CHECK VALID INPUT
    @State var isFormValid = false // True >> Go to HomeView()
    @State var showIncompleteFormError: Bool = false // True >> Show Alert of unfilled form
    
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
                
                Spacer()
                loginButton
                signUpLink
                Spacer()
            }
            .padding([.leading, .trailing], 10)
        }
        .navigationDestination(isPresented: $isFormValid) {
            HomeView()
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
            //            RoundedRectangle(cornerRadius: 10.0)
            //                .frame(maxWidth: .infinity)
            //                .foregroundStyle(.lightPurple.opacity(0.5))
            //                .frame(height: 65)
            //                .padding(.horizontal)
            
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 28))
                    .foregroundStyle(.purpleOpacity1.opacity(0.7))
                
                TextField("Username", text: $username)
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
                if isLoginFormValid() {
                    isFormValid = true //Navigate to "HomeView"
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
    
    //  The View of Register Link to navigate to "SignUp" Page
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
    
    //  DISPLAY/CHECK when the form is incompleted
    var incompleteFormError: some View {
        VStack() {
            if showIncompleteFormError {
                Text("Please fill in all fields to create an account.")
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
            }
        }
    }
    
    //  FUNCTION
    //  FUNCTION TO VALIDATE THE FORM COMPLETENESS
    func isLoginFormValid() -> Bool {
        if username.isEmpty || password.isEmpty {
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
