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
     var body: some View {
         NavigationView {
             List {
                    ForEach(secretNotes, id: \.self) { secret in
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
                     NavigationLink(destination: AddSecretNote()){
                             Image(systemName: "plus.app")
                         }
                 }
             }
         }
     }
    
    
    func loadAllSecretNotes() -> [SecretNoteModel] {
        var secretNotes: [SecretNoteModel] = []
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
           let jsonFiles = fileURLs.filter { $0.pathExtension == "json" }
            
            for fileURL in jsonFiles {
                let data = try Data(contentsOf: fileURL)
                
                let decoder = JSONDecoder()
                
               
                if let note = try? decoder.decode(SecretNoteModel.self, from: data) {
                    secretNotes.append(note)
                }
            }
        } catch {
            print("Erreur lors du chargement des notes secrètes: \(error)")
        }
        print("Répertoire Documents : \(documentsDirectory.path)")
        print(secretNotes)
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
                    print("Note supprimée : \(fileURL)")
                } catch {
                    print("Erreur lors de la suppression de la note : \(error)")
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
