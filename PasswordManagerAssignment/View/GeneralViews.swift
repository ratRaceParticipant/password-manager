//
//  GeneralViews.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import Foundation
import SwiftUI

class GeneralViews {
    @ViewBuilder
    static func displayText(text: String,labelText: String) -> some View {
        VStack(alignment: .leading) {
            if(!labelText.isEmpty){
                Text(labelText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(text)
                .fontWeight(.bold)
        }
    }
    static func getTextField(bindingText: Binding<String>, placeholderText: String) -> some View{
        TextField("Label", text: bindingText, prompt: Text(placeholderText))
            .textContentType(.username)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color.gray.opacity(0.1))
            )
            .padding(.horizontal)
    }
    static func getSecureField(bindingText: Binding<String>, placeholderText: String) -> some View{
        SecureField("Label", text: bindingText, prompt: Text(placeholderText))
            .textContentType(.newPassword)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color.gray.opacity(0.1))
            )
            .padding(.horizontal)
            
    }
}
