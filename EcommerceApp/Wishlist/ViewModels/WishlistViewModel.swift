//
//  WishlistViewModel.swift
//  EcommerceApp
//
//  Created by rania on 16/09/2026.
//


import SwiftUI

@MainActor
@Observable
final class WishlistViewModel {

    var products: [ProductModel] = []

    func addProduct(_ product: ProductModel) {
        guard !products.contains(where: { $0.id == product.id }) else {
            return
        }

        products.append(product)
    }

    
    
    func removeProduct(_ product: ProductModel) {
        products.removeAll {
            $0.id == product.id
        }
    }

    func removeAll() {
        products.removeAll()
    }
    
    func toggleProduct(_ product: ProductModel) {
        if isFavorite(product) {
            removeProduct(product)
        } else {
            addProduct(product)
        }
    }
    
    func isFavorite(_ product: ProductModel) -> Bool {
        products.contains {
            $0.id == product.id
        }
    }
    
    
    
}


