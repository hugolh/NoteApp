//
//  AddNoteView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 05/04/2024.
//


import Foundation
import SwiftUI
import CryptoKit

struct AddNote: View {
    @State private var notes: [Note] = []
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
                let newNote = Note(id: UUID(), title: title, date: Date(), content: content)
                notes.append(newNote)
                saveNoteAsJson(note: newNote)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func saveNoteAsJson(note: Note) {
        guard let content = note.content else {
            print("La note est vide, rien à hacher.")
            return
        }
        
        guard let contentData = content.data(using: .utf8) else {
            print("Erreur lors de la conversion du contenu en Data.")
            return
        }
        
        let newNote = Note(id: note.id, title: note.title, date: note.date, content:  note.content ??  "")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let dateString = dateFormatter.string(from: note.date)
        let fileName = "\(dateString)_\("".prefix(8)).json"
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            do {
                let data = try JSONEncoder().encode(newNote)
                try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
                print("Note sauvegardée : \(fileURL)")
            } catch {
                print("Erreur lors de la sauvegarde de la note : \(error)")
            }
        }
    }

}