//
//  HomeHeader.swift
//  EcommerceApp
//
//  Created by rania on 09/09/2026.
//

import SwiftUI

struct HomeHeader: View {
    var body: some View {
        HStack{
            
            
            Button{
                
            } label: {
                Image( "menuImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
            }
            Spacer()
            Button{
                
            } label: {
                Image( "profileImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height:60)
                    .background(.gray.opacity(0.3))
                    .clipShape(.circle)
            }
        
        }
        .padding(.horizontal ,20)
    }
}

#Preview {
    HomeHeader()
}
