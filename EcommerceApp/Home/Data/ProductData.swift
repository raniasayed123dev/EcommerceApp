//
//  ProductData.swift
//  EcommerceApp
//
//  Created by rania on 12/09/2026.
//

import Foundation

enum ProductData {

    static let products: [ProductModel] = [

        ProductModel(
            imageName: "accessory1",
            productName: "Gold Necklace",
            description: "Elegant Layered Necklace",
            price: 45,
            category: .accessories,
            isNewArrival: true,
            images: ["accessory1", "accessory1", "accessory1"],
            colors: [.gold, .silver],
            sizes: [],
            rating: 4.8,
            reviewsCount: 124
        ),

        ProductModel(
            imageName: "accessory2",
            productName: "Classic Watch",
            description: "Minimal Leather Watch",
            price: 85,
            category: .accessories,
            isNewArrival: false,
            images: ["accessory2", "accessory2", "accessory2"],
            colors: [.black, .brown],
            sizes: [.oneSize],
            rating: 4.6,
            reviewsCount: 89
        ),

        ProductModel(
            imageName: "shoes2",
            productName: "Running Shoes",
            description: "Comfortable Sport Shoes",
            price: 140,
            category: .shoes,
            isNewArrival: true,
            images: ["shoes2", "shoes2", "shoes2"],
            colors: [.white, .black],
            sizes: [.size38, .size39, .size40, .size41, .size42],
            rating: 4.7,
            reviewsCount: 156
        ),

        ProductModel(
            imageName: "accessory3",
            productName: "Pearl Earrings",
            description: "Simple Pearl Earrings",
            price: 55,
            category: .accessories,
            isNewArrival: false,
            images: ["accessory3", "accessory3"],
            colors: [.gold, .silver],
            sizes: [],
            rating: 4.9,
            reviewsCount: 72
        ),

        ProductModel(
            imageName: "productImage1",
            productName: "Classic Jacket",
            description: "Oversized Casual Jacket",
            price: 120,
            category: .women,
            isNewArrival: true,
            images: ["productImage1", "productImage1", "productImage1"],
            colors: [.black, .white, .beige],
            sizes: [.small, .medium, .large, .extraLarge],
            rating: 4.7,
            reviewsCount: 138
        ),

        ProductModel(
            imageName: "shoes1",
            productName: "White Sneakers",
            description: "Everyday Casual Sneakers",
            price: 95,
            category: .shoes,
            isNewArrival: true,
            images: ["shoes1", "shoes1", "shoes1"],
            colors: [.white, .black],
            sizes: [.size38, .size39, .size40, .size41],
            rating: 4.5,
            reviewsCount: 97
        ),

        ProductModel(
            imageName: "shoes4",
            productName: "Leather Boots",
            description: "Classic Ankle Boots",
            price: 160,
            category: .shoes,
            isNewArrival: false,
            images: ["shoes4", "shoes4", "shoes4"],
            colors: [.black, .brown],
            sizes: [.size38, .size39, .size40, .size41, .size42],
            rating: 4.8,
            reviewsCount: 112
        ),

        ProductModel(
            imageName: "productImage2",
            productName: "Casual Shirt",
            description: "Soft Cotton Shirt",
            price: 70,
            category: .men,
            isNewArrival: true,
            images: ["productImage2", "productImage2", "productImage2"],
            colors: [.white, .black, .beige],
            sizes: [.small, .medium, .large, .extraLarge],
            rating: 4.4,
            reviewsCount: 84
        ),

        ProductModel(
            imageName: "accessory4",
            productName: "Silver Bracelet",
            description: "Delicate Silver Bracelet",
            price: 40,
            category: .accessories,
            isNewArrival: false,
            images: ["accessory4", "accessory4"],
            colors: [.silver, .gold],
            sizes: [],
            rating: 4.6,
            reviewsCount: 63
        ),

        ProductModel(
            imageName: "shoes5",
            productName: "Classic Loafers",
            description: "Smart Leather Loafers",
            price: 50,
            category: .shoes,
            isNewArrival: false,
            images: ["shoes5", "shoes5", "shoes5"],
            colors: [.black, .brown],
            sizes: [.size38, .size39, .size40, .size41, .size42],
            rating: 4.7,
            reviewsCount: 105
        ),

        ProductModel(
            imageName: "bag2",
            productName: "Shoulder Bag",
            description: "Elegant Everyday Bag",
            price: 110,
            category: .bags,
            isNewArrival: true,
            images: ["bag2", "bag2", "bag2"],
            colors: [.black, .brown, .beige],
            sizes: [],
            rating: 4.8,
            reviewsCount: 143
        ),

        ProductModel(
            imageName: "productImage3",
            productName: "Denim Shirt",
            description: "Relaxed Fit Denim Shirt",
            price: 75,
            category: .men,
            isNewArrival: false,
            images: ["productImage3", "productImage3", "productImage3"],
            colors: [.blue, .black],
            sizes: [.small, .medium, .large, .extraLarge],
            rating: 4.5,
            reviewsCount: 76
        ),

        ProductModel(
            imageName: "bag1",
            productName: "Leather Handbag",
            description: "Structured Leather Bag",
            price: 145,
            category: .bags,
            isNewArrival: true,
            images: ["bag1", "bag1", "bag1"],
            colors: [.black, .brown, .beige],
            sizes: [],
            rating: 4.9,
            reviewsCount: 167
        ),

        ProductModel(
            imageName: "productImage5",
            productName: "Summer Dress",
            description: "Lightweight Floral Dress",
            price: 95,
            category: .women,
            isNewArrival: true,
            images: ["productImage5", "productImage5", "productImage5"],
            colors: [.white, .beige],
            sizes: [.small, .medium, .large],
            rating: 4.6,
            reviewsCount: 118
        ),

        ProductModel(
            imageName: "bag6",
            productName: "Mini Crossbody",
            description: "Compact Daily Crossbody",
            price: 100,
            category: .bags,
            isNewArrival: false,
            images: ["bag6", "bag6", "bag6"],
            colors: [.black, .brown],
            sizes: [],
            rating: 4.5,
            reviewsCount: 91
        ),

        ProductModel(
            imageName: "shoes3",
            productName: "Platform Sneakers",
            description: "Trendy Casual Sneakers",
            price: 125,
            category: .shoes,
            isNewArrival: true,
            images: ["shoes3", "shoes3", "shoes3"],
            colors: [.white, .black, .beige],
            sizes: [.size38, .size39, .size40, .size41],
            rating: 4.7,
            reviewsCount: 134
        ),

        ProductModel(
            imageName: "productImage4",
            productName: "Pleated Skirt",
            description: "Elegant Midi Skirt",
            price: 75,
            category: .women,
            isNewArrival: false,
            images: ["productImage4", "productImage4", "productImage4"],
            colors: [.black, .beige, .white],
            sizes: [.small, .medium, .large],
            rating: 4.4,
            reviewsCount: 68
        ),

        ProductModel(
            imageName: "bag3",
            productName: "Tote Bag",
            description: "Spacious Everyday Tote",
            price: 90,
            category: .bags,
            isNewArrival: true,
            images: ["bag3", "bag3", "bag3"],
            colors: [.black, .brown, .beige],
            sizes: [],
            rating: 4.8,
            reviewsCount: 121
        ),

        ProductModel(
            imageName: "bag4",
            productName: "Small Handbag",
            description: "Chic Compact Handbag",
            price: 105,
            category: .bags,
            isNewArrival: false,
            images: ["bag4", "bag4"],
            colors: [.black, .brown],
            sizes: [],
            rating: 4.6,
            reviewsCount: 87
        ),

        ProductModel(
            imageName: "bag5",
            productName: "Casual Backpack",
            description: "Lightweight Daily Backpack",
            price: 70,
            category: .bags,
            isNewArrival: true,
            images: ["bag5", "bag5", "bag5"],
            colors: [.black, .brown],
            sizes: [],
            rating: 4.5,
            reviewsCount: 104
        )
    ]
}
