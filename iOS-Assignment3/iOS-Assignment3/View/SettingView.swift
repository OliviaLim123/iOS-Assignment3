//
//  SettingView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI
import PhotosUI

struct SettingView: View {
    @ObservedObject var viewModel = ProfileViewModel.shared
    @State private var darkMode: Bool = false
    @State private var currentMode: ColorScheme = .light
    var body: some View {
        VStack{
            Text("SETTING")
                .font(.custom("MontserratAlternates-SemiBold", size: 50))
                .foregroundStyle(.purple1)

            Image(uiImage: viewModel.avatarImage ?? UIImage(resource: .defaultAvatar))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150,height: 150)
                .clipShape(Circle())
                .padding(.bottom)
            HStack{
                //will be linked with leonie's part
                Text("ID001")
                    .font(.custom("MontserratAlternates-SemiBold", size: 25))
                    .foregroundStyle(.purpleOpacity1)
                    .padding(.horizontal, 25)
                //will be linked with leonie's part
                Text("Username")
                    .font(.custom("MontserratAlternates-SemiBold", size: 25))
                    .foregroundStyle(.purpleOpacity1)
            }
            Spacer()
            NavigationLink {
                MyProfileView()
            } label: {
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .foregroundStyle(.yellowOpacity1)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                    HStack{
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.black)
                            .font(.title2)
                            
                        Text("My Profile")
                            .font(.custom("MontserratAlternates-SemiBold", size: 18))
                            .foregroundStyle(.black)
                        
                    }
                    .padding(.leading, 40)
                }
            }
            .padding(.bottom)
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .foregroundStyle(.yellowOpacity1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "moon.fill")
                        .foregroundStyle(.black)
                        .font(.title2)
                    Text("Dark Mode")
                        .font(.custom("MontserratAlternates-SemiBold", size: 18))
                        .foregroundStyle(.black)
                    Toggle("", isOn: $darkMode)
                        .onChange(of: darkMode){ newValue, _ in
                            currentMode = newValue ? .light : .dark
                        }
                        .preferredColorScheme(currentMode)
                        .toggleStyle(SwitchToggleStyle(tint: Color.purple))
                    Spacer(minLength: 30)
                }
                .padding(.leading, 40)
            }
            .padding(.bottom)
            NavigationLink {
                FavouriteCountryView()
            } label: {
                ZStack (alignment: .leading){
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .foregroundStyle(.yellowOpacity1)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                    HStack{
                        Image(systemName: "heart")
                            .foregroundStyle(.black)
                            .font(.title2)
                        Text("Favourite country")
                            .font(.custom("MontserratAlternates-SemiBold", size: 18))
                            .foregroundStyle(.black)
                        
                    }
                    .padding(.leading, 40)
                }
            }
            Spacer()
            NavigationLink {
                //logout function - linked with leonie's part
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundStyle(.purple2)
                        .padding(.horizontal)
                    Text("LOG OUT")
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .foregroundStyle(.black)
                }
            }
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}
