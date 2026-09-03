//
//  SplashView.swift
//  EcommerceApp
//
//  Created by rania on 01/09/2026.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("splashImage1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Image("logoImage1")
                .resizable()
                .frame(width:  160 , height: 100)
                .scaledToFit()

        }

    }
}

#Preview {
    SplashView()
}
