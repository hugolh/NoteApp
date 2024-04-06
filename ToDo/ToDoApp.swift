//
//  ToDoApp.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

@main
struct ToDoApp: App {
    init() {
        if UserDefaults.standard.data(forKey: "encryptionKey") == nil {
            generateAndStoreKey()
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
