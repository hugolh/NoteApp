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
    @State private var notes = [NoteModel]()
    @State private var searchText = ""
    @State private var selectedTab: Int = 0
    @State private var isShowingDetailView = false
    @State private var showingAddNoteView = false

    private var filteredNotes: [NoteModel] {
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter { $0.content?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }

    private var starredNotes: [NoteModel] {
        filteredNotes.filter { $0.isStar ?? false }
    }
    
    private var nonStarredNotes: [NoteModel] {
        filteredNotes.filter { !($0.isStar ?? false) }
    }

    var body: some View {
        VStack {
            if !isShowingDetailView {
                
                Picker("Tabs", selection: $selectedTab) {
                    Text("Notes").tag(0)
                    Text("Starred").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            // Conditionally display content based on the selected tab
            if selectedTab == 0 {
                notesListView(notes: nonStarredNotes, title: "Note List")
            } else {
                notesListView(notes: starredNotes, title: "Starred Notes")
            }
        }
        .searchable(text: $searchText)
        .onAppear {
            notes = loadAllNotes()
        }
    }

    private func notesListView(notes: [NoteModel], title: String) -> some View {
        NavigationView {
            List {
                ForEach(notes, id: \.self) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        NoteRow(note: note)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Note") {
                        showingAddNoteView = true
                    }
                    .sheet(isPresented: $showingAddNoteView) {
                        AddNoteView()
                    }
                }
            }
        }
    }

    
    func loadAllNotes() -> [NoteModel] {
        var notes: [NoteModel] = []

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)

            let jsonFiles = fileURLs.filter { $0.pathExtension == "json" && !$0.lastPathComponent.contains("secret") }

            for fileURL in jsonFiles {
                let data = try Data(contentsOf: fileURL)

                let decoder = JSONDecoder()

                if let note = try? decoder.decode(NoteModel.self, from: data) {
                    notes.append(note)
                }
            }
        } catch {
            print("Error loading notes : \(error)")
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
                    print("Note deleted : \(fileURL)")
                } catch {
                    print("Error deleting note : \(error)")
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
    let note: NoteModel
    
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
