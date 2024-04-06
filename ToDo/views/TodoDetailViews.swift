//
//  TodoDetailViews.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

struct TodoDetailView: View {
    var note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text( note.title)
                .font(.title)
            
            Text(formatDate(note.date))
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(note.content ?? "")
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
