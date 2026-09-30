//
//  FilterView.swift
//  EcommerceApp
//
//  Created by rania on 24/09/2026.
//


import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedCategory: String
    @Bindable var viewModel: FilterViewModel
    
    private let itemsPerRow = 3
    
    let categories = [
        "New Arrivals",
        "Women",
        "Men",
        "Shoes",
        "Bags",
        "Accessories"
    ]
    
    var categoryRows: [[String]] {
        stride(
            from: 0,
            to: categories.count,
            by: itemsPerRow
        ).map { startIndex in
            Array(
                categories[
                    startIndex..<min(
                        startIndex + itemsPerRow,
                        categories.count
                    )
                ]
            )
        }
    }
    
    private var minimumPrice: Double {
        viewModel.minPrice(for: selectedCategory)
    }
    
    private var maximumPrice: Double {
        viewModel.maxPrice(for: selectedCategory)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    categorySection
                    priceSection
                    colorSection
                    
                    if !viewModel.availableSizes(for: selectedCategory).isEmpty {
                        sizeSection
                    }
                    
                    ratingSection
                    
                    applyButton
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.selectedMaxPrice = maximumPrice
        }
        .onChange(of: selectedCategory) { _, _ in
            viewModel.selectedMaxPrice = maximumPrice
            viewModel.selectedColors.removeAll()
            viewModel.selectedSizes.removeAll()
            viewModel.selectedRating = nil
        }
    }
    
    private var header: some View {
        HStack {
            BackButton {
                dismiss()
            }
            
            Spacer()
            
            Text("Filter")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Color.clear
                .frame(width: 45, height: 45)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Categories")
                .font(.title3)
                .foregroundStyle(.black)
                .fontWeight(.bold)
            
            ForEach(categoryRows, id: \.self) { row in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(row, id: \.self) { category in
                            categoryButton(category)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private func categoryButton(_ category: String) -> some View {
        Button {
            selectedCategory = category
        } label: {
            Text(category)
                .font(.headline)
                .foregroundStyle(
                    selectedCategory == category ? .white : .black
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    selectedCategory == category
                        ? Color.black
                        : Color.white
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 23)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(.gray.opacity(0.3))
                }
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 4,
                    x: 0,
                    y: 2
                )
        }
    }
    
    private var priceSection: some View {
        VStack(alignment: .leading) {
            Text("Price Range")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(spacing: 10) {
                Text("\(minimumPrice, specifier: "%.0f") $")
                    .font(.headline)
                
                Slider(
                    value: $viewModel.selectedMaxPrice,
                    in: minimumPrice...maximumPrice
                )
                .tint(.black)
                
                Text("\(viewModel.selectedMaxPrice, specifier: "%.0f") $")
                    .font(.headline)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var colorSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Color")
                .font(.title3)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(
                        viewModel.availableColors(for: selectedCategory),
                        id: \.self
                    ) { color in
                        colorButton(color)
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func colorButton(_ color: ProductColor) -> some View {
        let isSelected = viewModel.selectedColors.contains(color)
        
        return Button {
            if isSelected {
                viewModel.selectedColors.remove(color)
            } else {
                viewModel.selectedColors.insert(color)
            }
        } label: {
            Circle()
                .fill(colorForProductColor(color))
                .frame(
                    width: isSelected ? 40 : 32,
                    height: isSelected ? 40 : 32
                )
                .overlay {
                    Circle()
                        .stroke(
                            isSelected
                                ? Color.black
                                : Color.gray.opacity(0.7),
                            lineWidth: isSelected ? 2 : 1
                        )
                }
        }
        .buttonStyle(.plain)
    }
    
    private func colorForProductColor(_ color: ProductColor) -> Color {
        switch color {
        case .black:
            return .black
        case .white:
            return .white
        case .beige:
            return Color(red: 0.76, green: 0.68, blue: 0.56)
        case .brown:
            return .brown
        case .gold:
            return .yellow
        case .silver:
            return .gray
        case .blue:
            return .blue
        }
    }
    
    private var sizeSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Size")
                .font(.title3)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(
                        viewModel.availableSizes(for: selectedCategory),
                        id: \.self
                    ) { size in
                        sizeButton(size)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func sizeButton(_ size: ProductSize) -> some View {
        let isSelected = viewModel.selectedSizes.contains(size)
        
        return Button {
            if isSelected {
                viewModel.selectedSizes.remove(size)
            } else {
                viewModel.selectedSizes.insert(size)
            }
        } label: {
            Text(size.rawValue)
                .font(.headline)
                .foregroundStyle(isSelected ? .white : .black)
                .frame(minWidth: 50, minHeight: 40)
                .background(isSelected ? Color.black : Color.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray.opacity(0.3))
                }
        }
        .buttonStyle(.plain)
    }
    
    private var ratingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Rating")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(spacing: 8) {
                Spacer()
                
                ForEach(1...5, id: \.self) { rating in
                    ratingStar(rating)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func ratingStar(_ rating: Int) -> some View {
        let isSelected = Double(rating) <= (viewModel.selectedRating ?? 0)
        
        return Button {
            if viewModel.selectedRating == Double(rating) {
                viewModel.selectedRating = nil
            } else {
                viewModel.selectedRating = Double(rating)
            }
        } label: {
            Image(systemName: "star.fill")
                .font(.title2)
                .foregroundStyle(
                    isSelected
                        ? Color(red: 0.85, green: 0.65, blue: 0.2)
                        : Color(red: 0.85, green: 0.65, blue: 0.2).opacity(0.25)
                )
        }
        .buttonStyle(.plain)
    }
    
    private var applyButton: some View {
        HStack(spacing: 20) {
            Spacer()
            
            Button {
                viewModel.applyFilters()
                dismiss()
            } label: {
                Text("Apply Filters")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.gray.opacity(0.3))
                    }
                    .shadow(
                        color: .black.opacity(0.15),
                        radius: 4,
                        x: 0,
                        y: 2
                    )
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    FilterView(
        selectedCategory: .constant("New Arrivals"),
        viewModel: FilterViewModel()
    )
}
