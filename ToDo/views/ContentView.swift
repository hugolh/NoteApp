//
//  ContentView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//
import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
     @State private var hideEmpty: Bool = false
     @State private var showCalendar: Bool = false

     var body: some View {
         TabView {
             // Premier onglet
             NotesView()
                 .tabItem {
                     Label("Notes", systemImage: "note.text")
                 }

             // Second onglet
             AuthView()
                 .tabItem {
                     Label("Notes Secrètes", systemImage: "lock.doc")
                 }
         }
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
