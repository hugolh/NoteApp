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
                    SecretView()
                } else {
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

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identifiez-vous pour accéder à vos notes secrètes."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                         self.isAuthenticated = true
                    } else {
               
                    }
                }
            }
        } else {
        }
    }
}
