//
//  AccountSuccessView.swift
//  EcommerceApp
//
//  Created by rania on 06/09/2026.
//

import SwiftUI

struct AccountSuccessView: View {
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(Color(.green))
                    .font(.system(size: 60, weight: .bold))
                    .padding(10)
                Text("Successfully")
                    .font(.title)
                    .bold()
                Text("You have successfully registered in our app and start working in it.")
                    .font(.title3)
                    .foregroundStyle(Color.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                Spacer()
                NavigationLink {
                    HomeView()
                } label: {
                    Text("Start Shopping")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.black)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30)
                        )
                }
            }
           .padding(.bottom , 100)
            .padding(.horizontal , 40)
        }
        
    }
}

#Preview {
    AccountSuccessView()
}
