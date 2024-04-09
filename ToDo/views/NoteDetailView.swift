//
//  TodoDetailViews.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

struct NoteDetailView: View {
    var note: NoteModel
    @State private var title: String
    @State private var content: String?
    @State private var isStar: Bool

    init(note: NoteModel) {
        self.note = note
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.content)
        _isStar = State(initialValue: note.isStar ?? false)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Title", text: $title)
                .font(.title)
                .textFieldStyle(.roundedBorder)
            
            TextEditor(text: Binding<String>(get: { content ?? "" }, set: { content = $0 }))
                    .frame(minHeight: 200)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 20)
                
            Spacer()
            
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
            Spacer()
        }
        .padding()
        .navigationTitle("Note Details")
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(formatDate(note.date))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .onDisappear {
            saveNote()
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func saveNote() {
        let updatedNote = NoteModel(id: note.id, title: title, date: note.date, content: content, isStar: isStar)
          
           saveNoteToFile(newNote: updatedNote)
       }
       
       private func saveNoteToFile(newNote: NoteModel) {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
           let dateString = dateFormatter.string(from: note.date)
           let fileName = "\(dateString).json"
           
           guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
               print("Unable to locate the documents directory.")
               return
           }
           
           let fileURL = documentsDirectory.appendingPathComponent(fileName)
           
           do {
               let data = try JSONEncoder().encode(newNote)
               try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
               print("Note updated: \(fileURL)")
           } catch {
               print("Error updating the note: \(error)")
           }
       }
   }
