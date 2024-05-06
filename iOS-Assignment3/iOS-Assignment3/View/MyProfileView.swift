//
//  MyProfileView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI
import PhotosUI

struct MyProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel.shared
    var body: some View {
        VStack {
            Text("PROFILE")
                .font(.custom("MontserratAlternates-SemiBold", size: 50))
                .foregroundStyle(.purple1)
            Spacer()
            Image(uiImage: viewModel.avatarImage ?? UIImage(resource: .defaultAvatar))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150,height: 150)
                .clipShape(Circle())
                .padding(.bottom)
            //linked with leonie's part
            Text("ID001")
                .font(.custom("MontserratAlternates-SemiBold", size: 25))
                .foregroundStyle(.purpleOpacity1)
                .padding(.horizontal, 25)
                .padding(.bottom)
            Text("Username")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundStyle(.usernameColour)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "person.circle.fill")
                        .foregroundStyle(.black)
                        .font(.title2)
                    //should be linked with the leonie part
                    Text("Old Username")
                        .font(.custom("MontserratAlternates-SemiBold", size: 15))
                        .foregroundStyle(.black)
                }
                .padding(.leading, 40)
            }
            Text("Password")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundStyle(.usernameColour)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "lock.circle.fill")
                        .foregroundStyle(.black)
                        .font(.title2)
                    //should be linked with the leonie part
                    Text("Old Password")
                        .font(.custom("MontserratAlternates-SemiBold", size: 15))
                        .foregroundStyle(.black)
                }
                .padding(.leading, 40)
            }
            Spacer()
            NavigationLink {
                EditProfileView()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundStyle(.yellow1)
                        .padding(.horizontal)
                    Text("EDIT")
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
    MyProfileView()
}
