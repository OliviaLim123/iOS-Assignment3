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
    
    //  MainView
    var body: some View {
        ZStack {
            VStack() {
                Spacer()
                welcomeTitle
                Spacer()
                userNameField
                passwordField
                
                Spacer()
                loginButton
                Spacer()
            }
            .padding([.leading, .trailing], 10)
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
                    .padding()
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
                    //isPwdVisible.toggle() - USE this one when dont want to "press to hold"
                } label: {
                    Image(systemName: isPwdVisible ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.purpleOpacity1.opacity(0.7))
                }
                .padding(.trailing)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in self.isPwdVisible = pressing}, perform: {}) //this one Press to hold
                
            } //HStack
            .padding()
            .padding(.horizontal)
            
        }//ZStack S.
    }
    
    //  LOGIN BUTTON
    var loginButton: some View {
        VStack {
            NavigationLink {
                HomeView()
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
            
            //  SIGN UP LINK
            NavigationLink {
                SignUpView()
            } label : {
                VStack {
                    RegisterLink
                }
            }
            
        }// VSTACK E.
    }
    
    //  NAVITAGE TO SIGN UP PAGE
    var RegisterLink: some View {
        HStack {
            Text("Don't have account ?")
                .foregroundStyle(.blackOpacity)
            
            HStack {
                Text("Register here")
                Image(systemName: "arrow.turn.right.up")
            }
            .foregroundStyle(.amethyst)
        }
        .font(.custom("MontserratAlternates-SemiBold", size: 14))
        .padding()
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
