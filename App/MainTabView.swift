//
//  MainTabView.swift
//  EcommerceApp
//
//  Created by rania on 10/09/2026.
//


import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()

                case .wishlist:
                    Text("Wishlist")

                case .cart:
                    Text("Cart")

                case .profile:
                    VStack(spacing: 16) {
                        Spacer()

                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.black)

                        if let user = SessionManager.shared.currentUser {
                            if let displayName = user.displayName, !displayName.isEmpty {
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
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Sign Out")
                            }
                            .font(.headline)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 14)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MainTabView()
}


