//
//  ProductModel.swift
//  EcommerceApp
//
//  Created by rania on 10/09/2026.
//

import Foundation

enum ProductColor {
    case black
    case white
    case beige
    case brown
    case gold
    case silver
    case blue
}

enum ProductSize {
    case small
    case medium
    case large
    case extraLarge
    case size38
    case size39
    case size40
    case size41
    case size42
    case oneSize
}

struct ProductModel: Identifiable {
    let id = UUID()
    let imageName: String
    let productName: String
    let description: String
    let price: Double
    let category: ProductCategory
    let isNewArrival: Bool

    let images: [String]
    let colors: [ProductColor]
    let sizes: [ProductSize]

    let rating: Double
    let reviewsCount: Int
}
