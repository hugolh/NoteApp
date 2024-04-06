//
//  SecretNoteModel.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import SwiftUI
import Foundation



struct SecretNoteModel: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let date: Date
    let content: String?
}
