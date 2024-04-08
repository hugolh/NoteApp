//
//  todo.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI
import Foundation



struct NoteModel: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    let date: Date
    var content: String?
    var isStar: Bool?
}
