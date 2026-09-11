//
//  SearchAndFilterView.swift
//  EcommerceApp
//
//  Created by rania on 09/09/2026.
//

import SwiftUI

struct SearchAndFilterView: View {
    @Binding var searchText: String
        @Binding var showFilter: Bool
    
    var body: some View {
       HStack(spacing: 12) {
            
           HStack(spacing: 18) {
               
             Image(systemName: "magnifyingglass")
                   .font(.title2)
               TextField("Search...", text: $searchText)
                   .font(.title2)
                                   .textInputAutocapitalization(.never)
                                   .autocorrectionDisabled()
            
           }
           .padding(.horizontal, 20)
                       .frame(height: 56)
                       .background(Color.gray.opacity(0.1))
                       .clipShape(RoundedRectangle(cornerRadius: 30))
           
           Button {
                          showFilter = true
                      } label: {
                          Image("filtterImage")
                              .frame(width: 48, height: 48)
                      }
        }
       .padding(.horizontal,20)
    }
}

#Preview {
    SearchAndFilterView(
        searchText: .constant(""),
        showFilter: .constant(false)
    )
}
