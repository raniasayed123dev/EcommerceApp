//
//  AuthButton.swift
//  EcommerceApp
//
//  Created by rania on 03/09/2026.
//

import SwiftUI

struct AuthButton: View {
    let  title : String
    let backgroundColor : Color
    let textColor : Color
    let hasBorder : Bool
    let action: () -> Void
    init(
        title: String,
        backgroundColor: Color = .black,
        textColor: Color = .white ,
        hasBorder: Bool = false ,action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.hasBorder = hasBorder
        self.action = action
    }

    var body: some View {
        Button {
         action()
        } label: {
            Text(title)
                .font(.headline)
            // .bold()
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                
                .padding()
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay {
                    if hasBorder{
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(
                                backgroundColor == .white ? .black: .white ,
                                lineWidth: 1
                            )
                        
                    }
                }
        }

    }
}

#Preview {
    AuthButton(title: "title")
}
