//
//  SecretView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 25/03/2024.
//

import Foundation
import SwiftUI
import LocalAuthentication

struct SecretView: View {
    @State private var secretNotes = [SecretNoteModel]()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSecretNotes, id: \.self) { secret in
                    NavigationLink(destination: SecretNoteDetailView(secret: secret)) {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text(secret.title)
                                    .font(.title2)
                            }
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: deleteSecretNote)
            }
            .onAppear {
                secretNotes = loadAllSecretNotes()
            }
            .padding(.top)
            .navigationTitle("Secret Note List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddSecretNoteView()){
                        Image(systemName: "plus.app")
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }

    var filteredSecretNotes: [SecretNoteModel] {
        if searchText.isEmpty {
            return secretNotes
        } else {
            return secretNotes.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    
    
    func loadAllSecretNotes() -> [SecretNoteModel] {
        var secretNotes: [SecretNoteModel] = []
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
            let jsonFiles = fileURLs.filter { $0.pathExtension == "json" && $0.lastPathComponent.contains("secret") }
            
            for fileURL in jsonFiles {
                let data = try Data(contentsOf: fileURL)
                
                let decoder = JSONDecoder()
                
               
                if let note = try? decoder.decode(SecretNoteModel.self, from: data) {
                    secretNotes.append(note)
                }
            }
        } catch {
            print("Error on loading: \(error)")
        }
       
        return secretNotes
    }
    
    func deleteSecretNote(at offsets: IndexSet) {
        for index in offsets {
            let note = secretNotes[index]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
            let dateString = dateFormatter.string(from: note.date)
            let fileName = "\(dateString)_secret.json"
            
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                
                do {
                    try FileManager.default.removeItem(at: fileURL)
                    print("Note deleted : \(fileURL)")
                } catch {
                    print("Error on deleting on note : \(error)")
                }
            }
        }
        secretNotes.remove(atOffsets: offsets)
    }


}

struct SecretView_Previews: PreviewProvider {
    static var previews: some View {
        SecretView()
    }
}
