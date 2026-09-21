import SwiftUI

struct CartView: View {

    let goBack: () -> Void

    @Environment(CartViewModel.self) private var viewModel
    
    @State private var selectedProduct: ProductModel?
    
    @State private var showDeleteAllAlert = false
    @State private var showPayment = false

    var body: some View {

        VStack(spacing: 20) {

            HStack {
                BackButton {
                    goBack()
                }

                Spacer()
                Button {
                    if !viewModel.items.isEmpty {
                        showDeleteAllAlert = true
                    }
                } label: {
                    Image(systemName: "trash.fill")
                        .foregroundStyle(
                            viewModel.items.isEmpty
                            ? .gray
                            : .black
                        )
                        .font(.title3)
                }
            }
            .padding(.horizontal, 20)

            HStack {
                Text("Cart")
                    .font(.title)
                    .fontWeight(.semibold)

                Spacer()
            }
            .padding(.horizontal, 20)

            VStack(spacing: 20) {
                if viewModel.items.isEmpty {

                    Image("cartEmptyImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 200)

                    Text("Your Cart is Empty")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)

                    Text("Add your favorite products and find them here.")
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
                    .padding(.top ,20)

                    Spacer()

                } else {

                    List {
                        ForEach(viewModel.items) { item in
                            CartProductRow(
                                item: item,
                                onImageTapped: {
                                    selectedProduct = item.product
                                },
                                onIncrease: {
                                    viewModel.increaseQuantity(for: item)
                                },
                                onDecrease: {
                                    viewModel.decreaseQuantity(for: item)
                                }
                            )
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.removeItem(item)
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
                            .padding(.top, item.id == viewModel.items.first?.id ? 15 : 0)
                            .padding(.bottom, 15)
                        }

                        VStack(spacing: 15) {
                            HStack {
                                Text("Total Price")
                                    .font(.headline)
                                    .foregroundStyle(.gray)

                                Spacer()

                                Text(
                                    "\(viewModel.totalPrice, specifier: "%.0f") $"
                                )
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            }

                            Button {
                                showPayment = true
                            } label: {
                                Text("Go to Payment")
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
                                    .padding(.top, 20)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.white)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 15)

                        Spacer()
                            .frame(height: 120)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .allowsHitTesting(false)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(.white)
                }
            }
            .padding(.top, 20)
        }
        .padding(.top, 20)
        .background(.white)
        .alert(
            "Delete All Cart Items?",
            isPresented: $showDeleteAllAlert
        ) {
            Button("Cancel", role: .cancel) {
            }

            Button("Delete", role: .destructive) {
                viewModel.removeAll()
            }
        } message: {
            Text("Are you sure you want to remove all items from your cart?")
        }
        .fullScreenCover(isPresented: $showPayment) {
            PaymentView()
        }
        .fullScreenCover(item: $selectedProduct) { product in
            ProductDetailsView(
                product: product,
                onCartTapped: {
                }
            )
        }
    }
}

#Preview {
    CartView {
    }
    .environment(CartViewModel())
}
