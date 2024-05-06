//
//  SecureTextField.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

//A view of secure text field for the password
struct SecureTextField: View {
    
    //A state of isSecureField is set to true
    //Means that it is not allowed to see the password
    @State var isSecureField: Bool = true
    @Binding var text: String
    
    //The body of view:
    //Represent how the text field for the password looks like
    var body: some View {
        HStack {
            if isSecureField {
                securePassField
            } else {
                normalPassField
            }
        }
        .overlay(alignment: .trailing){
            eyeIcon
        }
    }
    
    //The appearance when the password is unseen by the user
    var securePassField: some View {
        SecureField("New password", text: $text)
            .foregroundColor(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
    
    //The appearance when the password can be seen by the user
    var normalPassField: some View {
        TextField("New password", text: $text)
            .foregroundColor(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
    
    //The appearance of eye icon to see the password
    var eyeIcon: some View {
        Image(systemName: isSecureField ? "eye.slash" : "eye")
            .foregroundStyle(.black)
            .onTapGesture {
                isSecureField.toggle()
            }
    }
}
