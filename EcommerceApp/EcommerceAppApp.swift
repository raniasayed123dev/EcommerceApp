//
//  EcommerceAppApp.swift
//  EcommerceApp
//
//  Created by rania on 01/09/2026.
//

import SwiftUI
import FirebaseCore

@main
struct EcommerceAppApp: App {
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
