//
//  AuthView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import Foundation
import SwiftUI
import LocalAuthentication

struct AuthView: View {
    @State private var isAuthenticated = false

    var body: some View {
        NavigationView {
            VStack {
                if isAuthenticated {
                    // L'utilisateur est authentifié, afficher le contenu protégé
                    SecretView()
                } else {
                    // L'utilisateur n'est pas authentifié, afficher un bouton pour lancer l'authentification
                    Button("S'authentifier avec Face ID") {
                        authenticate()
                    }
                }
            }
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // Vérifier si Face ID est disponible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identifiez-vous pour accéder à vos notes secrètes."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // Exécuter sur le thread principal
                DispatchQueue.main.async {
                    if success {
                        // L'authentification a réussi, mettre à jour l'état
                        self.isAuthenticated = true
                    } else {
                        // L'authentification a échoué
                        // Gérer l'erreur, par exemple en affichant un message à l'utilisateur
                    }
                }
            }
        } else {
            // Face ID n'est pas disponible
            // Gérer cette situation, par exemple en informant l'utilisateur
        }
    }
}
