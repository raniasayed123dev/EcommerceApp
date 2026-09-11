//
//  AuthViewModel.swift
//  EcommerceApp
//
//  Created by rania on 08/09/2026.
//

import Foundation
import Observation

@MainActor
@Observable

class AuthViewModel {
    
    var errorMessage = ""
    private let authService = AuthService()
        
    func validateSignUp(
        name: String,
        email: String,
        password: String,
        confirmPassword: String,
        isAgreed: Bool
    ) -> Bool {
        
        if let error = AuthValidator.validateName(name) {
            errorMessage = error
            return false
        }
        
        if let error = AuthValidator.validateEmail(email) {
            errorMessage = error
            return false
        }
        
        if let error = AuthValidator.validatePassword(password) {
            errorMessage = error
            return false
        }
        
        if let error = AuthValidator.validateConfirmPassword(
            confirmPassword,
            password: password
        ) {
            errorMessage = error
            return false
        }
        
        if let error = AuthValidator.validateTerms(isAgreed) {
            errorMessage = error
            return false
        }
        
        errorMessage = ""
        return true
    }
    
    func validateLogin(
        email: String,
        password: String
    ) -> Bool {
        
        if let error = AuthValidator.validateEmail(email) {
            errorMessage = error
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Please enter your password"
            return false
        }
        
        errorMessage = ""
        return true
    }
    
    
    
    
    func signUp(
        name: String,
        email: String,
        password: String
    ) async -> Bool {
        
        do {
            try await authService.signUp(
                name: name,
                email: email,
                password: password
            )
            
            return true
            
        } catch {
            print("🔥 SIGN UP ERROR:", error)
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func login(
        email: String,
        password: String
    ) async -> Bool {
        
        do {
            try await authService.login(
                email: email,
                password: password
            )
            
            return true
            
        } catch {
            print("🔥 LOGIN ERROR:", error)
            errorMessage = "Incorrect email or password."
            return false
        }
    }
}
