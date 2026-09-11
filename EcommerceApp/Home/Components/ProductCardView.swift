//
//  ProductCardView.swift
//  EcommerceApp
//
//  Created by rania on 10/09/2026.
//

import SwiftUI

struct ProductCardView: View {
    
    let imageName: String
    let productName: String
    let description: String
    let price: String
    
    var body: some View {
        VStack(alignment: .center) {
            
            ZStack(alignment: .topTrailing) {
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150)
                    //.frame(maxHeight: .infinity)
                        .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 25)
                        .background(.black)
                        .clipShape(Circle())
                }
                .padding(20)
            }
            
            Text(productName)
                .font(.headline)
                .foregroundStyle(.black)
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .lineLimit(2)
            
            Text(price)
                .font(.headline)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ProductCardView(
        imageName: "productImage1",
        productName: "Classic Jacket",
        description: "Irregular Rib Skirt",
        price: "$120"
    )
    .padding()
}
