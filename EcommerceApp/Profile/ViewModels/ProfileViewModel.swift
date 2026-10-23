//
//  ProfileViewModel.swift
//  EcommerceApp
//
//  Created by rania on 14/10/2026.
//

import Foundation
import FirebaseAuth
import Observation

@MainActor
@Observable
final class ProfileViewModel {

    var displayName = ""
    var email = ""
    var errorMessage = ""

    func loadUser() {
        let user = SessionManager.shared.currentUser

        displayName = user?.displayName ?? ""
        email = user?.email ?? ""
    }

    func saveName(_ name: String) {
        let newName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !newName.isEmpty else {
            errorMessage = "Please enter your name."
            return
        }

        guard let user = Auth.auth().currentUser else {
            errorMessage = "No user is currently signed in."
            return
        }

        let request = user.createProfileChangeRequest()
        request.displayName = newName

        request.commitChanges { [weak self] error in
            Task { @MainActor in
                guard let self else { return }

                if let error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                self.displayName = newName
                self.errorMessage = ""

                user.reload { reloadError in
                    Task { @MainActor in
                        if let reloadError {
                            self.errorMessage = reloadError.localizedDescription
                            return
                        }

                        if let updatedUser = Auth.auth().currentUser {
                            SessionManager.shared.currentUser = updatedUser
                            self.displayName = updatedUser.displayName ?? newName
                            self.email = updatedUser.email ?? self.email
                        }
                    }
                }
            }
        }
    }
}
