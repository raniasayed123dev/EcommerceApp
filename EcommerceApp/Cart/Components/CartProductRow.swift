import SwiftUI

struct CartProductRow: View {

    let item: CartItem
    let onImageTapped: () -> Void
    let onIncrease: () -> Void
    let onDecrease: () -> Void

    var body: some View {

        HStack(spacing: 15) {

            Button {
                onImageTapped()
            } label: {
                Image(item.product.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 100)
                    .clipped()
                    .background(Color(.systemGray6))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
            }
            .buttonStyle(.borderless)

            VStack(alignment: .leading, spacing: 6) {

                Text(item.product.productName)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .lineLimit(1)

                if let color = item.selectedColor {
                    Text("Color : \(color.rawValue)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }

                if let size = item.selectedSize {
                    Text("Size : \(size.rawValue)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }

                HStack {

                    Text(
                        "\(item.product.price * Double(item.quantity), specifier: "%.0f") $"
                    )
                    .font(.headline)
                    .foregroundStyle(.black)

                    Spacer()

                    HStack(spacing: 18) {

                        Button {
                            onDecrease()
                        } label: {
                            Image(systemName: "minus")
                                .foregroundStyle(.black)
                                .frame(width: 24, height: 24)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.borderless)

                        Text("\(item.quantity)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .frame(width: 20)

                        Button {
                            onIncrease()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                                .frame(width: 24, height: 24)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                    .shadow(
                        color: .black.opacity(0.12),
                        radius: 6,
                        x: 0,
                        y: 3
                    )
                }
            }

            Spacer()
        }
        .padding(12)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
        .shadow(
            color: .black.opacity(0.2),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

#Preview {

    CartProductRow(
        item: CartItem(
            product: ProductData.products[0],
            selectedColor: .black,
            selectedSize: .medium,
            quantity: 2
        ),
        onImageTapped: {
        },
        onIncrease: {
        },
        onDecrease: {
        }
    )
    .padding()
    .background(Color(.systemGray6))
}
