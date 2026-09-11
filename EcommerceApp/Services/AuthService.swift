//
//  AuthService.swift
//  EcommerceApp
//
//  Created by rania on 08/09/2026.
//

import FirebaseAuth
import FirebaseFirestore

class AuthService {
    private let auth = Auth.auth()
    
    var currentUser: FirebaseAuth.User? {
        auth.currentUser
    }
    
    func signUp(
        name: String,
        email: String,
        password: String
    ) async throws {
    
        let result = try await auth.createUser(
            withEmail: email,
            password: password
        )
      
        let user = result.user

        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name

        try await changeRequest.commitChanges()

        try await Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .setData([
                "name": name,
                "email": email
            ])

           }
    
    func login(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try auth.signOut()
    }
}
