//
//  SecretNoteDetailView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import Foundation
import SwiftUI
import CryptoKit


struct SecretNoteDetailView: View {
    var secret: SecretNoteModel
    @State private var displayedText: String
    
    init(secret: SecretNoteModel) {
        self.secret = secret
        _displayedText = State(initialValue: secret.content ?? "") 
    }

    var body: some View {
           VStack(alignment: .leading, spacing: 10) {
               Text(displayedText)
                   .padding()
           }
           .navigationTitle("\(secret.title)")
           .navigationBarItems(trailing: Button(action: {
               displayedText = decrypt(content: secret.content ?? "") ?? "Error on decrypt"
           }) {
               Image(systemName: "eye.slash")
                   .imageScale(.large)
           })
           .toolbar {
               ToolbarItem(placement: .principal) {
                   VStack {
                       Text(formatDate(secret.date))
                           .font(.subheadline)
                           .foregroundColor(.gray)
                   }
               }
           }
       }


    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    
}

