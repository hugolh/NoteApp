//
//  NotesView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import Foundation
import SwiftUI

struct NotesView: View { 
    @State private var newNote = Note(id: UUID(), title: "", date: Date(), content: "")
    @State private var searchText: String = ""
     @State private var hideEmpty: Bool = false
     @State private var showCalendar: Bool = false
    @State private var selectedNote: Note
    @State private var notes: [Note] = []

    
     var body: some View {
         NavigationView {
             List {
                 if(!isNotesTodays()){
                     NavigationLink(destination: TodoDetailView(note: $newNote)) {
                        
                         Text("Pas encore de note aujourd'hui")
                     }
                     
                     Divider()
                 } else{
                     
                     NavigationLink(destination: TodoDetailView(note: $selectedNote ?? $newNote)) {
                         
                         HStack(alignment: .center) {
                             VStack(alignment: .leading) {
                                 Text(formatDate(notesForToday().date))
                                     .font(.title2)
                             }
                            
                         }
                     }  .onAppear {
                         selectedNote = notesForToday()
                     }
                 }

                 ForEach(Array(notes.enumerated()), id: \.element.id) { index, note in
                     NavigationLink(destination: TodoDetailView(note: $notes[index])) {
                        HStack(alignment: .center) {
                             VStack(alignment: .leading) {
                                 Text(formatDate(note.date))
                                     .font(.title2)
                             }
                             Spacer()
                         }
                     }
                 }
             }
             .listStyle(.inset)
             .padding(.top)
             .navigationTitle("Notes List")
             .searchable(text: $searchText)
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button(action: { showCalendar = true }) {
                         Image(systemName: "calendar")
                     }
                 }
             }
             .background(
                NavigationLink(destination: CalendarSelectorView(notes: notes), isActive: $showCalendar) {
                    EmptyView()
                }

             )
         }
     }


    private func notesForToday() -> Note {
         let today = Date()
         return notes.first(where: { Calendar.current.isDate($0.date, inSameDayAs: today) })
                ?? Note(id: UUID(), title: "", date: today, content: nil)
     }
    
    private func isNotesTodays() -> Bool{
        let today = Date()
        if let note = notes.first(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
           return true
        } else {
            return false
        }
    }

   
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct Notes_preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
