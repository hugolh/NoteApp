//
//  NotesView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import Foundation
import SwiftUI
import LocalAuthentication

struct NotesView: View {
    @State private var notes = [Note]()
    @State private var searchText = ""

    private var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter { $0.content?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }

    private var starredNotes: [Note] {
        filteredNotes.filter { $0.isStar ?? false }
    }
    
    private var nonStarredNotes: [Note] {
        filteredNotes.filter { !($0.isStar ?? false) }
    }

    var body: some View {
        TabView {
            notesListView(notes: nonStarredNotes, title: "Note List")
                .tabItem {
                    Label("Notes", systemImage: "list.bullet")
                }
            
            notesListView(notes: starredNotes, title: "Starred Notes")
                .tabItem {
                    Label("Starred", systemImage: "star.fill")
                }
        }
        .searchable(text: $searchText)
        .onAppear {
            notes = loadAllNotes()
        }
    }

    private func notesListView(notes: [Note], title: String) -> some View {
        NavigationView {
            List {
                ForEach(notes, id: \.self) { note in
                    NavigationLink(destination: TodoDetailView(note: note)) {
                        NoteRow(note: note)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNote()) {
                        Image(systemName: "plus.app")
                    }
                }
            }
        }
    }

    
    func loadAllNotes() -> [Note] {
        var notes: [Note] = []

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)

            let jsonFiles = fileURLs.filter { $0.pathExtension == "json" && !$0.lastPathComponent.contains("secret") }

            for fileURL in jsonFiles {
                let data = try Data(contentsOf: fileURL)

                let decoder = JSONDecoder()

                if let note = try? decoder.decode(Note.self, from: data) {
                    notes.append(note)
                }
            }
        } catch {
            print("Erreur lors du chargement des notes: \(error)")
        }

        notes.sort { $0.date > $1.date }

        return notes
    }


    
    func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
            let dateString = dateFormatter.string(from: note.date)
            let fileName = "\(dateString).json"
            
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                
                do {
                    try FileManager.default.removeItem(at: fileURL)
                    print("Note supprimée : \(fileURL)")
                } catch {
                    print("Erreur lors de la suppression de la note : \(error)")
                }
            }
        }
        notes.remove(atOffsets: offsets)
    }


}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}


struct NoteRow: View {
    let note: Note
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(note.title)
                Text(formatDate(note.date))
                    .font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
        }
    }
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
