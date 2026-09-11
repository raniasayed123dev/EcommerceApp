//
//  RootView.swift
//  EcommerceApp
//
//  Created by rania on 11/09/2026.
//

import SwiftUI

struct RootView: View {
    @State private var session = SessionManager.shared
    
    var body: some View {
        Group {
            if session.isAuthenticated {
                MainTabView()
                    .transition(.opacity)
            } else {
                if session.hasCompletedOnboarding {
                    SplashScreen2View()
                        .transition(.opacity)
                } else {
                    SplashView()
                        .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut(duration: 0.35), value: session.isAuthenticated)
        .animation(.easeInOut(duration: 0.35), value: session.hasCompletedOnboarding)
    }
}

#Preview {
    RootView()
}
