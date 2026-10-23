//
//  AuthValidator.swift
//  EcommerceApp
//
//  Created by rania on 08/09/2026.
//

import Foundation


struct AuthValidator {
    
    static func validateName(_ name: String) -> String? {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return "Please enter your name"
        }
        if trimmed.count < 2 {
            return "Name must be at least 2 characters"
        }
        let lettersAndSpaces = CharacterSet.letters.union(.whitespaces)
        if trimmed.unicodeScalars.contains(where: { !lettersAndSpaces.contains($0) }) {
            return "Name can only contain letters"
        }
        return nil
    }
    
    static func validateEmail(_ email: String) -> String? {
        
        let email = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        // Empty email
        if email.isEmpty {
            return "Please enter your email"
        }
        
        // Spaces are not allowed
        if email.contains(" ") {
            return "Email cannot contain spaces"
        }
        
        // Email must contain exactly one @
        if email.filter({ $0 == "@" }).count != 1 {
            return "Email must contain exactly one @"
        }
        
        let parts = email.split(
            separator: "@",
            omittingEmptySubsequences: false
        )
        
        let username = parts[0]
        let domain = parts[1]
        
        // Username validation
        if username.isEmpty {
            return "Email must have a name before @"
        }
        
        if username.hasPrefix(".") || username.hasSuffix(".") {
            return "Email name cannot start or end with a dot"
        }
        
        // Domain validation
        if domain.isEmpty {
            return "Email must have a domain after @"
        }
        
        if !domain.contains(".") {
            return "Please enter a valid email domain"
        }
        
        if domain.hasPrefix(".") || domain.hasSuffix(".") {
            return "Email domain cannot start or end with a dot"
        }
        
        // Two dots together are not allowed
        if email.contains("..") {
            return "Email cannot contain consecutive dots"
        }
        
        // Allowed characters
        let allowedCharacters = CharacterSet.alphanumerics
            .union(CharacterSet(charactersIn: ".-_+"))
        
        if email.unicodeScalars.contains(where: {
            !allowedCharacters.contains($0) && $0 != "@"
        }) {
            return "Email contains invalid characters"
        }
        
        return nil
    }
    
    static func validatePassword(_ password: String) -> String? {
        if password.isEmpty {
            return "Please enter your password"
        }
        if password.contains(" ") {
            return "Password cannot contain spaces"
        }
        if password.count < 6 {
            return "Password must be at least 6 characters"
        }
        return nil
    }
    
    static func validateConfirmPassword(
        _ confirmPassword: String,
        password: String
    ) -> String? {
        
        if confirmPassword.isEmpty {
            return "Please confirm your password"
        }
        
        if confirmPassword != password {
            return "Passwords do not match"
        }
        
        return nil
    }
    
    static func validateTerms(_ isAgreed: Bool) -> String? {
        
        if !isAgreed {
            return "Please agree to the terms and conditions"
        }
        
        return nil
    }
    
}
