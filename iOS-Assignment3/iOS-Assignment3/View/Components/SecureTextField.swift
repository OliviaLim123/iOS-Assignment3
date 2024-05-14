//
//  SecureTextField.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

//SECURE TEXT FIELD Struct for the password
struct SecureTextField: View {
    
    //STATE property to track the text field is secure or not
    //Means that it is not allowed to see the password
    @State var isSecureField: Bool = true
    
    //BINDING property of text
    @Binding var text: String
    
    //SECURE TEXT FIELD VIEW
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
    
    //APPEARANCE of unseen the password
    var securePassField: some View {
        SecureField("New password", text: $text)
            .foregroundStyle(.darkPurple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
    
    //APPEARANCE of seen password
    var normalPassField: some View {
        TextField("New password", text: $text)
            .foregroundStyle(.darkPurple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
    
    //APPEARANCE of eye icon to see the password
    var eyeIcon: some View {
        Image(systemName: isSecureField ? "eye.slash" : "eye")
            .foregroundStyle(.darkPurpleOp)
            .onTapGesture {
                isSecureField.toggle()
            }
    }
}

//SECURE TEXT FIELD PREVIEW Struct
struct SecureTextFieldPreview: View {
    
    //STATE property of text
    @State var text: String = ""
    
    //VIEW of secure text field 
    var body: some View {
        SecureTextField(text: $text)
            .padding()
            .cornerRadius(10.0)
            .background(.lightPurple.opacity(0.5))
            .cornerRadius(10.0)
            .padding()
    }
}

#Preview {
    SecureTextFieldPreview()
}
