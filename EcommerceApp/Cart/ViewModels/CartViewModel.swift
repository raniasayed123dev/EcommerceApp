//
//  CartViewModel.swift
//  EcommerceApp
//
//  Created by rania on 17/09/2026.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class CartViewModel {

    var items: [CartItem] = []

    func addItem(
        product: ProductModel,
        color: ProductColor?,
        size: ProductSize?,
        quantity: Int = 1
    ) {
        if let index = items.firstIndex(where: {
            $0.product.id == product.id &&
            $0.selectedColor == color &&
            $0.selectedSize == size
        }) {
            items[index].quantity += quantity
        } else {
            let item = CartItem(
                product: product,
                selectedColor: color,
                selectedSize: size,
                quantity: quantity
            )

            items.append(item)
        }
    }

    func increaseQuantity(for item: CartItem) {
        guard let index = items.firstIndex(where: {
            $0.id == item.id
        }) else {
            return
        }

        items[index].quantity += 1
    }

    func decreaseQuantity(for item: CartItem) {
        guard let index = items.firstIndex(where: {
            $0.id == item.id
        }) else {
            return
        }

        if items[index].quantity > 1 {
            items[index].quantity -= 1
        }
    }

    func removeItem(_ item: CartItem) {
        items.removeAll {
            $0.id == item.id
        }
    }

    func removeAll() {
        items.removeAll()
    }

    var totalPrice: Double {
        items.reduce(0) { total, item in
            total + (item.product.price * Double(item.quantity))
        }
    }
}
