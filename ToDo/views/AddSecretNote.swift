//
//  AddSecretNote.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import Foundation
import SwiftUI

struct AddSecretNote: View {
    @State private var notes: [SecretNoteModel] = []
    @State private var title: String = ""
    @State private var content: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Titre", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("Ajouter une note")
            .navigationBarItems(leading: Button("Annuler") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Sauvegarder") {
                let newNote = SecretNoteModel(id: UUID(),title: title, date: Date(), content: content)
                notes.append(newNote)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
