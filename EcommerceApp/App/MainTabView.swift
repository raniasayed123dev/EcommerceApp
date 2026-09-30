
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
                    VStack(spacing: 16) {

                        Spacer()

                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.black)

                        if let user = SessionManager.shared.currentUser {

                            if let displayName = user.displayName,
                               !displayName.isEmpty {
                                Text(displayName)
                                    .font(.title2)
                                    .bold()
                            }

                            if let email = user.email {
                                Text(email)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }

                        Button(role: .destructive) {
                            SessionManager.shared.signOut()
                        } label: {

                            HStack {
                                Image(
                                    systemName:
                                        "rectangle.portrait.and.arrow.right"
                                )

                                Text("Sign Out")
                            }
                            .font(.headline)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 14)
                            .background(Color(.systemGray6))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                            )
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                    .padding()
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
