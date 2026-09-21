import SwiftUI

struct ProductCardView: View {

    let imageName: String
    let productName: String
    let description: String
    let price: Double
    let onHeartTapped: () -> Void
    let isFavorite: Bool
    
    var body: some View {

        VStack(alignment: .center) {

            ZStack(alignment: .topTrailing) {

                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 190)
                    .clipped()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 30))

                Button {
                    onHeartTapped()
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle( .white)
                        .frame(width: 25, height: 25)
                        .background( Color.black)
                        .clipShape(Circle())
                }
                .padding(15)
            }
            .frame(width: 160, height: 190)

            Text(productName)
                .font(.headline)
                .foregroundStyle(.black)
                .lineLimit(1)

            Text(description)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .lineLimit(1)

            Text("\(price, specifier: "%.0f") $")
                .font(.headline)
                .foregroundStyle(.black)
        }
        .frame(width: 160)
    }
}

#Preview {
    ProductCardView(
        imageName: "productImage1",
        productName: "Classic Jacket",
        description: "Irregular Rib Skirt",
        price: 120 ,
        onHeartTapped: {}, isFavorite: false
    )
    .padding()
}
