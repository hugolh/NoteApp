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

     var body: some View {
         NavigationView {
             List {
                 ForEach(secretNote, id: \.self) { secret in
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


}

struct SecretView_Previews: PreviewProvider {
    static var previews: some View {
        SecretView()
    }
}
