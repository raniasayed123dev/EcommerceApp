
import SwiftUI

struct ProductDetailsView: View {

    let product: ProductModel

    @Environment(\.dismiss) private var dismiss

    @State private var quantity = 1
    @State private var selectedColor: ProductColor?
    @State private var selectedSize: ProductSize?

    var body: some View {

        GeometryReader { geometry in

            let imageHeight = geometry.size.height * 0.5
            let panelHeight = geometry.size.height * 0.54
            let topPadding = geometry.size.height * 0.04

            ZStack(alignment: .top) {

                Image(product.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: imageHeight
                    )
                    .clipped()

                HStack {

                    BackButton {
                        dismiss()
                    }
                    .padding(.leading, geometry.size.width * 0.05)
                    .padding(.top, topPadding)

                    Spacer()

                    Button {
                    } label: {

                        Image("cartIcon2")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: geometry.size.width * 0.06,
                                height: geometry.size.width * 0.06
                            )
                            .frame(
                                width: geometry.size.width * 0.14,
                                height: geometry.size.width * 0.12
                            )
                            .background(.white)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, geometry.size.width * 0.05)
                    .padding(.top, topPadding)
                }

                VStack {

                    Spacer()

                    HStack {

                        Spacer()

                        Button {
                        } label: {

                            Image("loveIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: geometry.size.width * 0.10,
                                    height: geometry.size.width * 0.10
                                )
                                .frame(
                                    width: geometry.size.width * 0.12,
                                    height: geometry.size.width * 0.12
                                )
                                .background(.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, geometry.size.width * 0.05)
                    }
                    .padding(.bottom, geometry.size.height * 0.05)
                }
                .frame(
                    width: geometry.size.width,
                    height: imageHeight
                )

                VStack {

                    Spacer()
                    
                    
                    
                    VStack(spacing: 0) {

                        ScrollView(showsIndicators: false) {

                            VStack(spacing: 0) {

                                HStack(alignment: .top) {

                                    VStack(
                                        alignment: .leading,
                                        spacing: 6
                                    ) {

                                        Text(product.productName)
                                            .font(.system(
                                                size: geometry.size.width * 0.055,
                                                weight: .semibold
                                            ))
                                            .foregroundStyle(.black)

                                        Text(product.description)
                                            .font(.system(
                                                size: geometry.size.width * 0.035
                                            ))
                                            .foregroundStyle(.gray)
                                    }

                                    Spacer()

                                    HStack(
                                        spacing: geometry.size.width * 0.03
                                    ) {

                                        Button {

                                            if quantity > 1 {
                                                quantity -= 1
                                            }

                                        } label: {

                                            Text("−")
                                                .font(.system(
                                                    size: geometry.size.width * 0.045,
                                                    weight: .medium
                                                ))
                                                .frame(
                                                    width: geometry.size.width * 0.06,
                                                    height: geometry.size.width * 0.08
                                                )
                                        }

                                        Text("\(quantity)")
                                            .font(.system(
                                                size: geometry.size.width * 0.04,
                                                weight: .medium
                                            ))
                                            .frame(
                                                width: geometry.size.width * 0.06,
                                                height: geometry.size.width * 0.08
                                            )

                                        Button {

                                            quantity += 1

                                        } label: {

                                            Text("+")
                                                .font(.system(
                                                    size: geometry.size.width * 0.045,
                                                    weight: .medium
                                                ))
                                                .frame(
                                                    width: geometry.size.width * 0.06,
                                                    height: geometry.size.width * 0.08
                                                )
                                        }
                                    }
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, geometry.size.width * 0.035)
                                    .padding(.vertical, geometry.size.width * 0.015)
                                    .background(.white)
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: geometry.size.width * 0.07
                                        )
                                    )
                                    .shadow(
                                        color: .black.opacity(0.2),
                                        radius: 5,
                                        x: 0,
                                        y: 1
                                    )
                                }
                                .padding(.horizontal, geometry.size.width * 0.06)
                                .padding(.top, geometry.size.height * 0.035)

                                HStack(spacing: 6) {

                                    ForEach(0..<5, id: \.self) { _ in

                                        Image(systemName: "star.fill")
                                            .font(.system(
                                                size: geometry.size.width * 0.035
                                            ))
                                            .foregroundStyle(.orange)
                                    }

                                    Text("(\(product.reviewsCount) Reviews)")
                                        .font(.system(
                                            size: geometry.size.width * 0.032
                                        ))
                                        .foregroundStyle(.gray)
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .padding(.horizontal, geometry.size.width * 0.06)
                                .padding(.top, geometry.size.height * 0.02)

                                VStack(
                                    alignment: .leading,
                                    spacing: geometry.size.height * 0.02
                                ) {

                                    if !product.colors.isEmpty {

                                        HStack(
                                            spacing: geometry.size.width * 0.04
                                        ) {

                                            Text("Color")
                                                .font(.system(
                                                    size: geometry.size.width * 0.035,
                                                    weight: .medium
                                                ))
                                                .foregroundStyle(.black)

                                            HStack(
                                                spacing: geometry.size.width * 0.025
                                            ) {

                                                ForEach(
                                                    product.colors.indices,
                                                    id: \.self
                                                ) { index in

                                                    if product.colors.count == 1 {

                                                        Circle()
                                                            .fill(
                                                                colorForProductColor(
                                                                    product.colors[index]
                                                                )
                                                            )
                                                            .frame(
                                                                width: geometry.size.width * 0.075,
                                                                height: geometry.size.width * 0.075
                                                            )
                                                            .overlay {

                                                                Circle()
                                                                    .stroke(
                                                                        product.colors[index] == .white
                                                                        ? .gray.opacity(0.6)
                                                                        : .clear,
                                                                        lineWidth: 1
                                                                    )
                                                            }

                                                    } else {

                                                        Button {

                                                            selectedColor =
                                                                product.colors[index]

                                                        } label: {

                                                            Circle()
                                                                .fill(
                                                                    colorForProductColor(
                                                                        product.colors[index]
                                                                    )
                                                                )
                                                                .frame(
                                                                    width: geometry.size.width * 0.075,
                                                                    height: geometry.size.width * 0.075
                                                                )
                                                                .overlay {

                                                                    Circle()
                                                                        .stroke(
                                                                            product.colors[index] == .white
                                                                            ? .gray.opacity(0.6)
                                                                            : .clear,
                                                                            lineWidth: 1
                                                                        )
                                                                }
                                                                .overlay {

                                                                    Circle()
                                                                        .stroke(
                                                                            selectedColor == product.colors[index]
                                                                            ? .black
                                                                            : .clear,
                                                                            lineWidth: 2
                                                                        )
                                                                }
                                                                .scaleEffect(
                                                                    selectedColor == product.colors[index]
                                                                    ? 1.2
                                                                    : 1
                                                                )
                                                                .shadow(
                                                                    color:
                                                                        selectedColor == product.colors[index]
                                                                        ? .black.opacity(0.2)
                                                                        : .clear,
                                                                    radius: 3
                                                                )
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    if !product.sizes.isEmpty {

                                        HStack(
                                            spacing: geometry.size.width * 0.04
                                        ) {

                                            Text("Size")
                                                .font(.system(
                                                    size: geometry.size.width * 0.035,
                                                    weight: .medium
                                                ))
                                                .foregroundStyle(.black)

                                            HStack(
                                                spacing: geometry.size.width * 0.025
                                            ) {

                                                if product.sizes.count == 1 &&
                                                    product.sizes.first == .oneSize {

                                                    Text("One Size")
                                                        .font(.system(
                                                            size: geometry.size.width * 0.03,
                                                            weight: .medium
                                                        ))
                                                        .foregroundStyle(.black)
                                                        .padding(
                                                            .horizontal,
                                                            geometry.size.width * 0.04
                                                        )
                                                        .padding(
                                                            .vertical,
                                                            geometry.size.width * 0.02
                                                        )
                                                        .background(.white)
                                                        .overlay {

                                                            RoundedRectangle(
                                                                cornerRadius:
                                                                    geometry.size.width * 0.025
                                                            )
                                                            .stroke(
                                                                .gray.opacity(0.4),
                                                                lineWidth: 1
                                                            )
                                                        }
                                                        .clipShape(
                                                            RoundedRectangle(
                                                                cornerRadius:
                                                                    geometry.size.width * 0.025
                                                            )
                                                        )

                                                } else {

                                                    ForEach(
                                                        product.sizes.indices,
                                                        id: \.self
                                                    ) { index in

                                                        Button {

                                                            selectedSize =
                                                                product.sizes[index]

                                                        } label: {

                                                            Text(
                                                                sizeName(
                                                                    product.sizes[index]
                                                                )
                                                            )
                                                            .font(.system(
                                                                size: geometry.size.width * 0.032,
                                                                weight: .medium
                                                            ))
                                                            .foregroundStyle(
                                                                selectedSize ==
                                                                product.sizes[index]
                                                                ? .white
                                                                : .black
                                                            )
                                                            .frame(
                                                                width: geometry.size.width * 0.09,
                                                                height: geometry.size.width * 0.09
                                                            )
                                                            .background(
                                                                selectedSize ==
                                                                product.sizes[index]
                                                                ? Color.black
                                                                : Color.white
                                                            )
                                                            .overlay {

                                                                Circle()
                                                                    .stroke(
                                                                        .gray.opacity(0.4),
                                                                        lineWidth: 1
                                                                    )
                                                            }
                                                            .clipShape(Circle())
                                                            .scaleEffect(
                                                                selectedSize ==
                                                                product.sizes[index]
                                                                ? 1.15
                                                                : 1
                                                            )
                                                            .shadow(
                                                                color:
                                                                    selectedSize ==
                                                                    product.sizes[index]
                                                                    ? .black.opacity(0.2)
                                                                    : .clear,
                                                                radius: 3
                                                            )
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .padding(.horizontal, geometry.size.width * 0.06)
                                .padding(.top, geometry.size.height * 0.025)

                                VStack(
                                    alignment: .leading,
                                    spacing: 8
                                ) {

                                    Text("Description")
                                        .font(.system(
                                            size: geometry.size.width * 0.04,
                                            weight: .semibold
                                        ))
                                        .foregroundStyle(.black)

                                    Text(
                                        "This product is made with high quality materials and designed to provide a comfortable and stylish look for everyday use."
                                    )
                                    .font(.system(
                                        size: geometry.size.width * 0.032
                                    ))
                                    .foregroundStyle(.gray)
                                    .lineSpacing(3)
                                   
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .padding(.horizontal, geometry.size.width * 0.06)
                                .padding(.top, geometry.size.height * 0.025)
                                .padding(.bottom, geometry.size.height * 0.03)
                            }
                        }
                        

                        HStack(alignment: .center) {

                            VStack(
                                alignment: .leading,
                                spacing: 4
                            ) {

                                Text("Total Price")
                                    .font(.system(
                                        size: geometry.size.width * 0.03,
                                        weight: .medium
                                    ))
                                    .foregroundStyle(.gray)

                                Text(
                                    "\(product.price * Double(quantity), specifier: "%.0f $")"
                                )
                                .font(.system(
                                    size: geometry.size.width * 0.055,
                                    weight: .bold
                                ))
                                .foregroundStyle(.black)
                            }

                            Spacer()

                            Button {

                            } label: {

                                HStack(
                                    spacing: geometry.size.width * 0.05
                                ) {

                                    Image("cartIcon1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(
                                            width: geometry.size.width * 0.05,
                                            height: geometry.size.width * 0.05
                                        )

                                    Text("Add to Cart")
                                        .font(.system(
                                            size: geometry.size.width * 0.035,
                                            weight: .semibold
                                        ))
                                        .foregroundStyle(.white)
                                }
                                .padding(
                                    .horizontal,
                                    geometry.size.width * 0.10
                                )
                                .padding(
                                    .vertical,
                                    geometry.size.width * 0.035
                                )
                                .background(.black)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: geometry.size.width * 0.06
                                    )
                                )
                            }
                        }
                        .padding(.horizontal, geometry.size.width * 0.06)
                        .padding(.top, geometry.size.height * 0.02)
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 30)
                        .background(.white)
                    }
                   

                   
                    .frame(
                        width: geometry.size.width,
                        height: panelHeight
                    )
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: geometry.size.width * 0.09
                        )
                    )
                    .shadow(
                        color: .black.opacity(0.15),
                        radius: geometry.size.width * 0.03,
                        x: 0,
                        y: -geometry.size.height * 0.01
                    )
                    .offset(y: 0)
                }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
        .ignoresSafeArea()
       .navigationBarBackButtonHidden(true)
    }

    private func colorForProductColor(
        _ color: ProductColor
    ) -> Color {

        switch color {

        case .black:
            return .black

        case .white:
            return .white

        case .beige:
            return Color(
                red: 0.85,
                green: 0.78,
                blue: 0.65
            )

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

    private func sizeName(
        _ size: ProductSize
    ) -> String {

        switch size {

        case .small:
            return "S"

        case .medium:
            return "M"

        case .large:
            return "L"

        case .extraLarge:
            return "XL"

        case .size38:
            return "38"

        case .size39:
            return "39"

        case .size40:
            return "40"

        case .size41:
            return "41"

        case .size42:
            return "42"

        case .oneSize:
            return "One Size"
        }
    }
}

#Preview {
    
    ProductDetailsView(
        product: ProductData.products[3]
    )
}
