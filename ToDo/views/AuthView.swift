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
                    Button("Identification with Face ID") {
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
            let reason = "Need identification for access to securised notes."

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
