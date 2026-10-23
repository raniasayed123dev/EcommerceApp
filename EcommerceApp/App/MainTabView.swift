
import SwiftUI
import FirebaseAuth

struct MainTabView: View {

    @State private var selectedTab: AppTab = .home
    @State private var wishlistViewModel = WishlistViewModel()
    @State private var cartViewModel = CartViewModel()
    @State private var showTabBar = true

    var body: some View {

        ZStack(alignment: .bottom) {

            Group {
                switch selectedTab {

                case .home:
                    HomeView(showTabBar: $showTabBar) {
                        selectedTab = .cart
                    }

                case .wishlist:
                    WishlistView(
                        goBack: {
                            selectedTab = .home
                        },
                        onCartTapped: {
                            selectedTab = .cart
                        }
                    )

                case .cart:
                    CartView {
                        selectedTab = .home
                    }

                case .profile:
                    ProfileView {
                        selectedTab = .home
                    }
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )

            if showTabBar {
                CustomTabBar(selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .environment(wishlistViewModel)
        .environment(cartViewModel)
    }
}

#Preview {
    MainTabView()
}
