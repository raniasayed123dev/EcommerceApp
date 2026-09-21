import SwiftUI

struct WishlistProductRow: View {

    let product: ProductModel
    let onImageTapped: () -> Void
    let onCartTapped: () -> Void
    var body: some View {

        HStack(spacing: 15) {

            Button {
                onImageTapped()
            } label: {
                Image(product.imageName)
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

                Text(product.productName)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .lineLimit(1)

                Text(product.description)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(1)

                Text("\(product.price, specifier: "%.0f") $")
                    .font(.headline)
                    .foregroundStyle(.black)
            }

            Spacer()

            Button {
               onCartTapped()
            } label: {
                Image(systemName: "cart.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .frame(width: 35, height: 35)
            }
            .buttonStyle(.borderless)
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
    WishlistProductRow(
        product: ProductData.products[0],
        onImageTapped: {
        }, onCartTapped: {
            
        }
    )
}
