import SwiftUI

struct HomeView: View {

    @State private var selectedProduct: ProductModel?
    @State private var searchText = ""
    @State private var showFilter = false
    @State private var selectedCategory = "New Arrivals"

    let categories = [
        "New Arrivals",
        "Women",
        "Men",
        "Shoes",
        "Bags",
        "Accessories"
    ]

    var filteredProducts: [ProductModel] {
        if selectedCategory == "New Arrivals" {
            return ProductData.products.filter {
                $0.isNewArrival
            }
        }

        return ProductData.products.filter {
            $0.category.rawValue == selectedCategory
        }
    }

    var leftColumnProducts: [ProductModel] {
        filteredProducts.enumerated()
            .filter { $0.offset.isMultiple(of: 2) }
            .map { $0.element }
    }

    var rightColumnProducts: [ProductModel] {
        filteredProducts.enumerated()
            .filter { !$0.offset.isMultiple(of: 2) }
            .map { $0.element }
    }

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                HomeHeader()

                SearchAndFilterView(
                    searchText: $searchText,
                    showFilter: $showFilter
                )

                ScrollView(.horizontal, showsIndicators: false) {

                    HStack(spacing: 10) {

                        ForEach(categories, id: \.self) { category in

                            CategoryButton(
                                title: category,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }

               
                ScrollView(.vertical, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {

                        VStack(spacing: 10) {
                            ForEach(leftColumnProducts) { product in
                                Button {
                                    selectedProduct = product
                                } label: {
                                    ProductCardView(
                                        imageName: product.imageName,
                                        productName: product.productName,
                                        description: product.description,
                                        price: product.price
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .frame(maxWidth: .infinity)

                        VStack(spacing: 20) {
                            ForEach(rightColumnProducts) { product in
                                Button {
                                    selectedProduct = product
                                } label: {
                                    ProductCardView(
                                        imageName: product.imageName,
                                        productName: product.productName,
                                        description: product.description,
                                        price: product.price
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .offset(y: 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .frame(maxHeight: .infinity)
            }
            .padding(.top, 20)
        }
        .fullScreenCover(item: $selectedProduct) { product in
            ProductDetailsView(product: product)
        }
    }
}

#Preview {
    MainTabView()
}
