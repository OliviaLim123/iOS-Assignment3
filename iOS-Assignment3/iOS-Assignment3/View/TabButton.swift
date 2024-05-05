//
//  TabButton.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 5/5/2024.
//

import SwiftUI

struct TabButton: View {
    var title: String
    var image: String
    @Binding var selected: String
    var body: some View {
        Button(action: {
            withAnimation(.spring()){selected = title}
        }){
            HStack(spacing: 10){
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
            .background(Color.purpleOpacity2.opacity(selected == title ? 1.0 : 0))
            .clipShape(Capsule())
        }
    }
}
