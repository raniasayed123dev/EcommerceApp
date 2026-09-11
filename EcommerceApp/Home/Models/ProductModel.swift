//
//  ProductModel.swift
//  EcommerceApp
//
//  Created by rania on 10/09/2026.
//

import Foundation


struct ProductModel: Identifiable {
    
    let id = UUID()
    let imageName: String
    let productName: String
    let description: String
    let price: String
}
