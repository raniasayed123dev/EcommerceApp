import SwiftUI

struct HomeView: View {
    
    @State private var searchText = ""
    @State private var showFilter = false
    @State private var selectedCategory = "All"
    
    let categories = [
        "All",
        "Women",
        "Men",
        "Shoes",
        "Bags",
        "Accessories"
    ]
    
    let products = [
        ProductModel(
            imageName: "productImage1",
            productName: "Classic Jacket",
            description: "Irregular Rib Skirt",
            price: "$120"
        ),
        ProductModel(
            imageName: "productImage3",
            productName: "Elegant Dress",
            description: "Simple Summer Dress",
            price: "$95"
        ),
        ProductModel(
            imageName: "productImage2",
            productName: "Casual Shirt",
            description: "Soft Cotton Shirt",
            price: "$70"
        ),
        ProductModel(
            imageName: "productImage4",
            productName: "Classic Bag",
            description: "Leather Shoulder Bag",
            price: "$150"
        )
    ]
    
    var body: some View {
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
                        ProductCardView(
                            imageName: products[0].imageName,
                            productName: products[0].productName,
                            description: products[0].description,
                            price: products[0].price
                        )
                        
                        ProductCardView(
                            imageName: products[2].imageName,
                            productName: products[2].productName,
                            description: products[2].description,
                            price: products[2].price
                        )
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 20) {
                        ProductCardView(
                            imageName: products[1].imageName,
                            productName: products[1].productName,
                            description: products[1].description,
                            price: products[1].price
                        )
                        
                        ProductCardView(
                            imageName: products[3].imageName,
                            productName: products[3].productName,
                            description: products[3].description,
                            price: products[3].price
                        )
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
}

#Preview {
  MainTabView()
}
