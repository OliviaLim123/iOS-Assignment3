//
//  TabButton.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

//TAB BUTTON Struct
struct TabButton: View {
    
    //PROPERTIES
    var title: String
    var image: String
    
    //BINDING Property
    @Binding var selected: String
    
    //TAB BUTTON View 
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = title
            }
        }) {
            icons
        }
    }
    
    //ICONS View of tab button
    var icons: some View {
        HStack(spacing: 10) {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundStyle(.textColour)
            if selected == title {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundStyle(.textColour)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.lightPurpleOp.opacity(selected == title ? 1.0 : 0))
        .clipShape(Capsule())
    }
}
