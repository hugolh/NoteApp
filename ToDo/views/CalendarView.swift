//
//  CalendarView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

struct CalendarView: View {
    let notes: [Note]
    let year: Int
    let month: Int

    var body: some View {
        let daysInMonth = 30
        let days = 1...daysInMonth

        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(days, id: \.self) { day in
                let dayHasNote = notes.contains(where: { note in
                    let noteDay = Calendar.current.component(.day, from: note.date)
                    let noteMonth = Calendar.current.component(.month, from: note.date)
                    let noteYear = Calendar.current.component(.year, from: note.date)
                    return day == noteDay && month == noteMonth && year == noteYear
                })

                DayView(day: day, hasNote: dayHasNote)
            }
        }
    }
}





struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleNote: [Note] = [ ]
        
        NavigationView {
            CalendarView(notes: sampleNote, year: 2023,month:07 )
        }
    }
}

