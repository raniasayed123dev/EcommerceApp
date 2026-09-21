
import SwiftUI

struct WishlistView: View {

    let goBack: () -> Void
    var onCartTapped: (() -> Void)? = nil

    @Environment(WishlistViewModel.self) private var viewModel
    @Environment(CartViewModel.self) private var cartViewModel
    
    @State private var showDeleteAllAlert = false
    @State private var showAddedToCartAlert = false
    
    @State private var selectedProduct: ProductModel?

    var body: some View {

        VStack(spacing: 20) {

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

            HStack(spacing: 12) {

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)

                    Text("Search")
                        .foregroundStyle(.gray)

                    Spacer()
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

                Button {
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .foregroundStyle(.black)
                        .frame(width: 50, height: 50)
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 15)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray.opacity(0.3))
                        }
                }
            }
            .padding(.horizontal, 20)

            HStack {
                Text("Wishlist")
                    .font(.title)
                    .fontWeight(.semibold)

                Spacer()

            }
            .padding(.horizontal, 20)
            VStack(spacing : 20){
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
                    
                } else {
                    
                    List {
                        ForEach(viewModel.products) { product in
                            WishlistProductRow(
                                product: product,
                                onImageTapped: {
                                    selectedProduct = product
                                } ,
                                onCartTapped: {
                                    selectedProduct = product
                                }
                            )
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.removeProduct(product)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .foregroundStyle(.white)
                                }
                                .tint(.black)
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.white)
                            .padding(.horizontal, 20)
                            .padding(.top, product.id == viewModel.products.first?.id ? 15 : 0)
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
            }.padding(.top , 20)
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


