import SwiftUI

struct HomeView: View {

    @Binding var showTabBar: Bool

    var onCartTapped: (() -> Void)? = nil

    @State private var selectedProduct: ProductModel?
    @State private var searchText = ""
    @State private var showFilter = false
    @State private var selectedCategory = "New Arrivals"
    @State private var filterViewModel = FilterViewModel()

    @Environment(WishlistViewModel.self) private var wishlistViewModel

    init(
        showTabBar: Binding<Bool> = .constant(true),
        onCartTapped: (() -> Void)? = nil
    ) {
        self._showTabBar = showTabBar
        self.onCartTapped = onCartTapped
    }

    let categories = [
        "New Arrivals",
        "Women",
        "Men",
        "Shoes",
        "Bags",
        "Accessories"
    ]

    var filteredProducts: [ProductModel] {

        let search = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if !search.isEmpty {
            let searchResults = ProductData.products.filter { product in
                product.productName.localizedCaseInsensitiveContains(search) ||
                product.description.localizedCaseInsensitiveContains(search) ||
                product.category.rawValue.localizedCaseInsensitiveContains(search)
            }

            return filterViewModel.filteredProducts(from: searchResults)
        }

        let categoryProducts = filterViewModel.products(
            for: selectedCategory
        )

        return filterViewModel.filteredProducts(
            from: categoryProducts
        )
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
                                filterViewModel.resetFilters(
                                    for: category
                                )
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
                                        price: product.price,
                                        onHeartTapped: {
                                            wishlistViewModel.toggleProduct(product)
                                        },
                                        isFavorite: wishlistViewModel.isFavorite(product)
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
                                        price: product.price,
                                        onHeartTapped: {
                                            wishlistViewModel.toggleProduct(product)
                                        },
                                        isFavorite: wishlistViewModel.isFavorite(product)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .offset(y: 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
                .frame(maxHeight: .infinity)
            }
            .padding(.top, 20)
            .navigationDestination(isPresented: $showFilter) {
                FilterView(
                    selectedCategory: $selectedCategory,
                    viewModel: filterViewModel
                )
            }
            .onChange(of: showFilter) { _, isPresented in
                showTabBar = !isPresented
            }
        }
        .fullScreenCover(item: $selectedProduct) { product in
            ProductDetailsView(
                product: product,
                onCartTapped: {
                    onCartTapped?()
                }
            )
        }
    }
}

#Preview {
    MainTabView()
}
