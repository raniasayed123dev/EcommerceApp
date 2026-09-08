//
//  SplashView.swift
//  EcommerceApp
//
//  Created by rania on 01/09/2026.
//

import SwiftUI

struct SplashView: View {
    @State private var showOnBoarding : Bool = false
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
            
            if showOnBoarding {
                           OnBoardingView()
                               .transition(.move(edge: .trailing))
                       }

        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            withAnimation(.easeInOut(duration: 0.5)) {
                           showOnBoarding = true
                       }
        }
        
    }
}

#Preview {
    SplashView()
}
