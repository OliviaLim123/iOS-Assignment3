//
//  LoginView.swift
//  iOS-Assignment3
//
//  Created by Hang Vu on 6/5/2024.
//

import SwiftUI

//  MAIN VIEW STRUCTURE
struct AppEntry: View {
    
    var body: some View {
        ZStack {
            VStack() {
                AppTittle
                AppLogo
                AppEntry
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    //  APP TITTLE
    var AppTittle: some View {
        Text("Country Discovery")
            .font(.custom("MontserratAlternates-SemiBold", size: 45))
            .opacity(0.8) //Black Opacity 80%
            .tracking(8.0)
            .multilineTextAlignment(.center)
            .padding()
            .offset(y: 20)
    }
    
    //  APP LOGO
    var AppLogo: some View {
        Image("appLogo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .frame(height: 310)
    }
    
    //  AppEntry
    var AppEntry: some View {
        VStack(spacing: 30) {
            
            Text ("Sign in to your account!")
                .font(.custom("MontserratAlternates-SemiBold", size: 18))
                .opacity(0.8)
                .tracking(0.9)
            
            //  LOGIN LINK
            NavigationLink {
                LoginView()
            } label: {
                LoginButton
            }
            
            //  SIGN UP LINK
            NavigationLink {
                SignUpView()
            } label : {
                VStack {
                    signUpButton
                    RegisterLink
                }
            }
        } //VStack E.
        .padding()
    }
    
    //  LOGIN BUTTON
    var LoginButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30.0)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundStyle(.lightPurple)
                .padding(.horizontal)
                .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)

            
            Text("LOGIN")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.royalPurple)
                .tracking(4.0)
        }
    }
    
    // SIGN UP BUTTON
    var signUpButton: some View {
            Text ("SIGN UP")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.royalPurple)
                .tracking(4.0)
            
            
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.sweetCorn)
                .clipShape(RoundedRectangle(cornerRadius: 30.0))
                .padding(.horizontal)
                .shadow(color: .black.opacity(0.3), radius: 3, x: -2, y: -2)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: -4, y: -4)
    }
    
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
        .font    (.custom("MontserratAlternates-SemiBold", size: 14))
        .padding()
    }
    
}

#Preview {
    NavigationStack {
        AppEntry()
    }
}
