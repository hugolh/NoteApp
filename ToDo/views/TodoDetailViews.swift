//
//  TodoDetailViews.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

struct TodoDetailView: View {
    @Binding var note: Note // Modifier pour @Binding si la modification doit être reflétée à l'extérieur

    // Pour des tests locaux, on utilise @State
    // @State private var title: String = ""
    // @State private var content: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Titre", text: $note.title) // Liaison directe au titre du todo
                .font(.title)
            
            Text(formatDate(note.date))
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Utilisation de TextEditor pour le contenu pour permettre le texte multiligne
            TextEditor(text: Binding<String>(
                get: { self.note.content ?? "" }, // Fournit une chaîne vide si `todo.content` est nil
                set: { self.note.content = $0 }
            )) // Liaison directe au contenu du todo
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
        }
        .padding()
        .navigationTitle("Todo Details")
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
