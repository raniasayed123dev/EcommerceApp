//
//  AuthTextField.swift
//  EcommerceApp
//
//  Created by rania on 03/09/2026.
//

import Foundation
import SwiftUI

struct AuthTextField: View {
    
    let title: String
    let placeholder: String
    let isSecure: Bool
    let isValid: Bool
    
    @Binding var text: String
    
    @State private var showPassword: Bool = false
    
    init(
        title: String,
        placeholder: String,
        isSecure: Bool,
        text: Binding<String>,
        isValid: Bool = false
    ) {
        self.title = title
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.isValid = isValid
        self._text = text
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            
            Text(title)
                .font(.title3)
                .bold()
            
            HStack {
                
                if isSecure {
                    
                    if showPassword {
                        TextField(
                            "",
                            text: $text,
                            prompt: Text(placeholder)
                                .foregroundStyle(.gray)
                        )
                        .foregroundStyle(.primary)
                    }
                    else {
                        SecureField(
                            "",
                            text: $text,
                            prompt: Text(placeholder)
                                .foregroundStyle(.gray)
                        )
                        .foregroundStyle(.primary)
                    }
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(
                            systemName: showPassword
                            ? "eye.slash"
                            : "eye"
                        )
                        .foregroundStyle(
                            showPassword
                            ? Color.gray
                            : Color.black
                        )
                    }
                    
                }
                else {
                    
                    TextField(
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .foregroundStyle(.gray)
                    )
                    .foregroundStyle(.primary)
                    
                    if isValid {
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

#Preview {
    AuthTextField(
        title: "email",
        placeholder: "enter",
        isSecure: false,
        text: .constant(""),
        isValid: false
    )
}
