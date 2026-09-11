//
//  SessionManager.swift
//  EcommerceApp
//
//  Created by rania on 11/09/2026.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Observation

@MainActor
@Observable
final class SessionManager {
    
    static let shared = SessionManager()
    
    var currentUser: FirebaseAuth.User?
    var isAuthenticated: Bool = false
    var isSigningUp: Bool = false
    
    var hasCompletedOnboarding: Bool {
        get {
            UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasCompletedOnboarding")
        }
    }
    
    private var authListenerHandle: AuthStateDidChangeListenerHandle? = nil
    private let authService = AuthService()
    
    private init() {
        self.currentUser = Auth.auth().currentUser
        self.isAuthenticated = Auth.auth().currentUser != nil
        
        self.authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                guard let self = self else { return }
                
                self.currentUser = user
                
                if !self.isSigningUp {
                    self.isAuthenticated = (user != nil)
                }
            }
        }
    }
    
   
    
    func markSigningUp() {
        isSigningUp = true
    }
    
    func completeRegistration() {
        isSigningUp = false
        hasCompletedOnboarding = true
        
        withAnimation(.easeInOut(duration: 0.35)) {
            self.isAuthenticated = (Auth.auth().currentUser != nil)
        }
    }
    
    func completeLogin() {
        isSigningUp = false
        hasCompletedOnboarding = true
        
        withAnimation(.easeInOut(duration: 0.35)) {
            self.isAuthenticated = true
        }
    }
    
    func signOut() {
        do {
            try authService.signOut()
            isSigningUp = false
            
            withAnimation(.easeInOut(duration: 0.35)) {
                self.isAuthenticated = false
                self.currentUser = nil
            }
        } catch {
            print("🔥 Sign out error:", error.localizedDescription)
        }
    }
}
