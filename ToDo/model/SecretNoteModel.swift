//
//  SecretNoteModel.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import SwiftUI
import Foundation



struct SecretNoteModel: Identifiable, Hashable {
    let id: UUID
    let title: String
    let date: Date
    let content: String?
}


let secretNote: [SecretNoteModel] = [
    SecretNoteModel(id: UUID(), title: "Buy groceries", date: createDate(year: 2023, month: 7, day: 20, hour: 9, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Finish homework", date: createDate(year: 2023, month: 7, day: 21, hour: 15, minute: 30), content: nil),
    SecretNoteModel(id: UUID(), title: "Call mom", date: createDate(year: 2023, month: 7, day: 22, hour: 12, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Go for a run", date: createDate(year: 2023, month: 7, day: 23, hour: 7, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Read a book", date: createDate(year: 2023, month: 7, day: 19, hour: 18, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Write a blog post", date: createDate(year: 2023, month: 7, day: 18, hour: 20, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Attend a meeting", date: createDate(year: 2023, month: 7, day: 25, hour: 10, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Clean the house", date: createDate(year: 2023, month: 7, day: 17, hour: 14, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Practice playing guitar", date: createDate(year: 2023, month: 7, day: 26, hour: 16, minute: 0), content: nil),
    SecretNoteModel(id: UUID(), title: "Plan a trip", date: createDate(year: 2023, month: 7, day: 27, hour: 11, minute: 30), content: "J'ai une grosse bite")
]
