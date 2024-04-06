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
    @State private var isStar: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
           NavigationView {
               Form {
                   Section(header: Text("Note Details")) {
                       TextField("Title", text: $title)
                       TextEditor(text: $content)
                           .frame(height: 200)
                   }
                   
                   Section {
                       Button(action: {
                           isStar.toggle()
                       }) {
                           HStack {
                               Text("Star Note")
                               Spacer()
                               Image(systemName: isStar ? "star.fill" : "star")
                                   .foregroundColor(isStar ? .yellow : .gray)
                           }
                       }
                   }
               }
               .navigationBarTitle("Add a Note", displayMode: .inline)
               .navigationBarItems(leading: Button("Cancel") {
                   presentationMode.wrappedValue.dismiss()
               }, trailing: Button("Save") {
                   saveNoteAsJson()
               })
           }
       }
       
    
    func saveNoteAsJson() {
        
        guard content.data(using: .utf8) != nil else {
            print("Erreur lors de la conversion du contenu en Data.")
            return
        }
        
        let newNote = Note(id: UUID(), title: title, date: Date(), content: content, isStar: isStar)
          
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let dateString = dateFormatter.string(from: Date())
        let fileName = "\(dateString).json"
        
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
        presentationMode.wrappedValue.dismiss()
          }

}
