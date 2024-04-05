//
//  DayView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 21/03/2024.
//

import SwiftUI



struct DayView: View {
    var day: Int
    var hasNote: Bool

    var body: some View {
        Text("\(day)")
            .padding(8)
            .background(hasNote ? Color.blue : Color.clear)
            .clipShape(Circle())
            .foregroundColor(hasNote ? Color.white : Color.black)
    }
}

