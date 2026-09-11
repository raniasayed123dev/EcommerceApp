//
//  CustomTabBar.swift
//  EcommerceApp
//
//  Created by rania on 10/09/2026.
//

import SwiftUI

enum AppTab: CaseIterable {
    case home
    case wishlist
    case cart
    case profile
    
    var title: String {
        switch self {
        case .home:
            "Home"
        case .wishlist:
            "Wishlist"
        case .cart:
            "Cart"
        case .profile:
            "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            "house"
        case .wishlist:
            "heart"
        case .cart:
            "cart"
        case .profile:
            "person"
        }
    }
}


struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
    var body: some View {
        HStack (spacing : 20){
                   
            ForEach(AppTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    HStack(spacing: -30) {
                        Image(systemName: tab.icon)
                            .foregroundStyle(selectedTab == tab ? .white : .black)
                            .frame(width: 45, height: 45)
                            .background(selectedTab == tab ? .black : .clear)
                            .clipShape(Circle())

                        if selectedTab == tab {
                            Text(tab.title)
                                .foregroundStyle(.black)
                                .bold()
                                .padding(.leading, 40)
                                .padding(.trailing, 10)
                                .padding(.vertical, 10)
                                .background(Color.gray.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
            }
            }
               .frame(maxWidth: .infinity )
               .frame(height: 50)
              .padding()
               .background(.white)
          .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 30,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 30
            )
        )
        .shadow(radius: 5)
       
        
    }
    }


#Preview {
    CustomTabBar(selectedTab: .constant(.home))
        .padding()
}
