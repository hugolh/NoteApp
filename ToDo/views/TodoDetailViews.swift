//
//  TodoDetailViews.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

struct TodoDetailView: View {
    var todo: Todo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(todo.title)
                .font(.title)
            Text(formatDate(todo.date))
                .font(.subheadline)
                .foregroundColor(.gray)
            if(todo.content != nil){
                Text(todo.content!)
            }
          
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
