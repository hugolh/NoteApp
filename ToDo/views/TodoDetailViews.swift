//
//  TodoDetailViews.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

struct TodoDetailView: View {
    @Binding var note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Titre", text: $note.title)
                .font(.title)
            
            Text(formatDate(note.date))
                .font(.subheadline)
                .foregroundColor(.gray)
            
            TextEditor(text: Binding<String>(
                get: { self.note.content ?? "" },
                set: { self.note.content = $0 }
            ))
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
