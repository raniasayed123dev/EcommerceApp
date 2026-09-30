import SwiftUI

struct WishlistView: View {

    let goBack: () -> Void
    var onCartTapped: (() -> Void)? = nil

    @Environment(WishlistViewModel.self) private var viewModel
    @Environment(CartViewModel.self) private var cartViewModel

    @State private var showDeleteAllAlert = false
    @State private var showAddedToCartAlert = false
    @State private var selectedProduct: ProductModel?
    @State private var searchText = ""

    var filteredProducts: [ProductModel] {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if search.isEmpty {
            return viewModel.products
        }

        return viewModel.products.filter { product in
            product.productName.localizedCaseInsensitiveContains(search) ||
            product.description.localizedCaseInsensitiveContains(search) ||
            product.category.rawValue.localizedCaseInsensitiveContains(search)
        }
    }

    var body: some View {

        VStack(spacing: 15) {

            HStack {

                BackButton {
                    goBack()
                }

                Spacer()

                Button {
                    if !viewModel.products.isEmpty {
                        showDeleteAllAlert = true
                    }
                } label: {
                    Image(systemName: "trash.fill")
                        .foregroundStyle(
                            viewModel.products.isEmpty
                            ? .gray
                            : .black
                        )
                        .font(.title3)
                }
            }
            .padding(.horizontal, 20)

            HStack {

                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)

                TextField("Search", text: $searchText)
                    .foregroundStyle(.black)

                Spacer()

                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 50)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray.opacity(0.3))
            }
            .padding(.horizontal, 20)

            HStack {
                Text("Wishlist")
                    .font(.title)
                    .fontWeight(.semibold)

                Spacer()
            }
            .padding(.horizontal, 20)

            VStack(spacing: 20) {

                if viewModel.products.isEmpty {

                    Image("heartEmptyImage2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 200)

                    Text("Your Wishlist is Empty")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)

                    Text("Save your favorite items and find them here later.")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Button {
                        goBack()
                    } label: {
                        Text("Continue Shopping")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.black)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 30)
                            )
                    }
                    .padding(.horizontal, 40)

                    Spacer()

                } else if filteredProducts.isEmpty {

                    VStack(spacing: 12) {
                        
                        Text("No products found")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)

                        Text("Try searching for another product.")
                            .font(.subheadline)
                            .foregroundStyle(.gray)

                        Spacer()
                    }
                    
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 100)
                    
                } else {

                    List {

                        ForEach(filteredProducts) { product in

                            WishlistProductRow(
                                product: product,
                                onImageTapped: {
                                    selectedProduct = product
                                },
                                onCartTapped: {
                                    selectedProduct = product
                                }
                            )
                            .swipeActions(
                                edge: .trailing,
                                allowsFullSwipe: true
                            ) {
                                Button(role: .destructive) {
                                    viewModel.removeProduct(product)
                                } label: {
                                    Label(
                                        "Delete",
                                        systemImage: "trash"
                                    )
                                    .foregroundStyle(.white)
                                }
                                .tint(.black)
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.white)
                            .padding(.horizontal, 20)
                            .padding(
                                .top,
                                product.id == filteredProducts.first?.id
                                ? 8
                                : 0
                            )
                            .padding(.bottom, 15)
                        }

                        Spacer()
                            .frame(height: 120)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(.white)
                }
            }
            .padding(.top, 10)
        }
        .padding(.top, 20)
        .background(.white)
        .alert(
            "Delete All Wishlist Items?",
            isPresented: $showDeleteAllAlert
        ) {
            Button("Cancel", role: .cancel) {
            }

            Button("Delete", role: .destructive) {
                viewModel.removeAll()
            }
        } message: {
            Text("Are you sure you want to remove all items from your wishlist?")
        }
        .fullScreenCover(item: $selectedProduct) { product in
            ProductDetailsView(
                product: product,
                onCartTapped: {
                    onCartTapped?()
                }
            )
        }
        .alert(
            "Added to Cart",
            isPresented: $showAddedToCartAlert
        ) {
            Button("OK", role: .cancel) {
            }
        } message: {
            Text("The product has been added to your cart.")
        }
    }
}

#Preview {
    WishlistView {
    }
    .environment(WishlistViewModel())
    .environment(CartViewModel())
}
