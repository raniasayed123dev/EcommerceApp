//
//  CategoryButton.swift
//  EcommerceApp
//
//  Created by rania on 10/09/2026.
//

import SwiftUI

struct CategoryButton: View {
    let title : String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button {
           onTap()
        } label: {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(isSelected ? .white : .black)
                         .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(isSelected ? .black : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1)
                        }
                }
    }
}

#Preview {
    CategoryButton(title: "Wommen", isSelected : false ,  onTap: {})
}
