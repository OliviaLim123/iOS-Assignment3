//
//  SecureTextField.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

struct SecureTextField: View {
    @State var isSecureField: Bool = true //true (not allowed to see the password)
    @Binding var text: String
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("new password", text: $text)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
            } else {
                TextField("new password", text: $text)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
            }
        }
        .overlay(alignment: .trailing){
            Image(systemName: isSecureField ? "eye.slash" : "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}
