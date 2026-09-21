//
//  ProductModel.swift
//  EcommerceApp
//
//  Created by rania on 10/09/2026.
//

import Foundation

enum ProductColor: String {
    case black = "Black"
    case white = "White"
    case beige = "Beige"
    case brown = "Brown"
    case gold = "Gold"
    case silver = "Silver"
    case blue = "Blue"
}

enum ProductSize: String {
    case small = "S"
    case medium = "M"
    case large = "L"
    case extraLarge = "XL"
    case size38 = "38"
    case size39 = "39"
    case size40 = "40"
    case size41 = "41"
    case size42 = "42"
    case oneSize = "One Size"
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
