//
//  CalendarSelectorView.swift
//  ToDo
//
//  Created by Le Hen Hugo on 21/03/2024.
//

import SwiftUI

struct CalendarSelectorView: View {
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    let notes: [Note]

    let years: [Int] = Array(2020...2024)
    let months: [Int] = Array(1...12)

    var body: some View {
        HStack {
          
            Picker("Select Year", selection: $selectedYear) {
                ForEach(years, id: \.self) {
                    Text("\($0)").tag($0)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)

           
            Picker("Select Month", selection: $selectedMonth) {
                ForEach(months, id: \.self) { month in
                    Text(Calendar.current.monthSymbols[month - 1]).tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)

            CalendarView(notes: notes, year: selectedYear, month: selectedMonth)
        }
        .padding()
    }
}

struct CalendarSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleNote: [Note] = []
        
        NavigationView {
            CalendarSelectorView(notes: sampleNote)
        }
    }
}
