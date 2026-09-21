//
//  CartItem.swift
//  EcommerceApp
//
//  Created by rania on 17/09/2026.
//

import Foundation

struct CartItem: Identifiable {
    
    let id = UUID()
    let product: ProductModel
    let selectedColor: ProductColor?
    let selectedSize: ProductSize?
    var quantity: Int
}
