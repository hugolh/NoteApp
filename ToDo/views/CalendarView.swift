//
//  CalendarView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Date = Date()
    @State private var showingDetail: Bool = false
    let startDate: Date = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
    let endDate: Date = Date()
    let todos: [Todo]

    var body: some View {
        VStack {
            DatePicker("Select a Date", selection: $selectedDate, in: startDate...endDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .onChange(of: selectedDate) { newValue in
                    showingDetail = true
                }
                .padding()

            Spacer()
        }
        .sheet(isPresented: $showingDetail) {
            if let todoForDate = todos.first(where: { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }) {
                TodoDetailView(todo: todoForDate)
            } else {
                Text("No Todo for this date").padding()
            }
        }
        .navigationTitle("Calendar")
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTodos: [Todo] = [ ]
        
        NavigationView {
            CalendarView(todos: sampleTodos)
        }
    }
}
