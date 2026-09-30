//
//  FilterViewModel.swift
//  EcommerceApp
//
//  Created by rania on 25/09/2026.
//

import Observation

@MainActor
@Observable
final class FilterViewModel {

    var selectedColors: Set<ProductColor> = []
    var selectedSizes: Set<ProductSize> = []
    var selectedRating: Double?
    var selectedMaxPrice: Double = 0

    var appliedColors: Set<ProductColor> = []
    var appliedSizes: Set<ProductSize> = []
    var appliedRating: Double?
    var appliedMaxPrice: Double = 0

    var hasAppliedFilters: Bool {
        !appliedColors.isEmpty ||
        !appliedSizes.isEmpty ||
        appliedRating != nil ||
        appliedMaxPrice > 0
    }

    func products(for category: String) -> [ProductModel] {
        if category == "New Arrivals" {
            return ProductData.products.filter {
                $0.isNewArrival
            }
        }

        return ProductData.products.filter {
            $0.category.rawValue == category
        }
    }

    func minPrice(for category: String) -> Double {
        products(for: category)
            .map(\.price)
            .min() ?? 0
    }

    func maxPrice(for category: String) -> Double {
        products(for: category)
            .map(\.price)
            .max() ?? 0
    }

    func availableColors(for category: String) -> [ProductColor] {
        let products = products(for: category)
        var colors: [ProductColor] = []

        for product in products {
            for color in product.colors {
                if !colors.contains(color) {
                    colors.append(color)
                }
            }
        }

        return colors
    }

    func availableSizes(for category: String) -> [ProductSize] {
        let products = products(for: category)
        var sizes: [ProductSize] = []

        for product in products {
            for size in product.sizes {
                if !sizes.contains(size) {
                    sizes.append(size)
                }
            }
        }

        return sizes
    }

    func applyFilters() {
        appliedColors = selectedColors
        appliedSizes = selectedSizes
        appliedRating = selectedRating
        appliedMaxPrice = selectedMaxPrice
    }

    func resetFilters(for category: String) {
        selectedColors.removeAll()
        selectedSizes.removeAll()
        selectedRating = nil

        appliedColors.removeAll()
        appliedSizes.removeAll()
        appliedRating = nil

        selectedMaxPrice = maxPrice(for: category)
        appliedMaxPrice = 0
    }

    func filteredProducts(from products: [ProductModel]) -> [ProductModel] {
        guard hasAppliedFilters else {
            return products
        }

        return products.filter { product in

            let matchesColor =
                appliedColors.isEmpty ||
                !Set(product.colors).isDisjoint(with: appliedColors)

            let matchesSize =
                appliedSizes.isEmpty ||
                !Set(product.sizes).isDisjoint(with: appliedSizes)

            let matchesRating =
                appliedRating == nil ||
                product.rating >= appliedRating!

            let matchesPrice =
                appliedMaxPrice == 0 ||
                product.price <= appliedMaxPrice

            return matchesColor &&
                   matchesSize &&
                   matchesRating &&
                   matchesPrice
        }
    }
}
