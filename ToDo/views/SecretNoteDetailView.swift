//
//  SecretNoteDetailView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import Foundation
import SwiftUI

struct SecretNoteDetailView: View {
    var secret: SecretNoteModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(secret.title)
                .font(.title)
            Text(formatDate(secret.date))
                .font(.subheadline)
                .foregroundColor(.gray)
            if(secret.content != nil){
                Text(secret.content!)
            }
          
        }
        .padding()
        .navigationTitle("Secret Note Details")
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
