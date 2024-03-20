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
         NavigationView {
             List {
                 Toggle(isOn: $hideEmpty) {
                     Text("Hide Empty Todos")
                 }
                 .padding()

                 ForEach(filteredTodos, id: \.self) { todo in
                     NavigationLink(destination: TodoDetailView(todo: todo)) {
                         HStack(alignment: .center) {
                             VStack(alignment: .leading) {
                                 Text(formatDate(todo.date))
                                     .font(.title2)
                             }
                             Spacer()
                         }
                     }
                 }
             }
             .listStyle(.inset)
             .padding(.top)
             .navigationTitle("Todo List")
             .searchable(text: $searchText)
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button(action: { showCalendar = true }) {
                         Image(systemName: "calendar")
                     }
                 }
             }
             .background(
                 NavigationLink(destination: CalendarView(todos: todos), isActive: $showCalendar) { EmptyView() }
             )
         }
     }


    private var filteredTodos: [Todo] {
        todos.filter { todo in
            (!hideEmpty || (todo.content != nil && !todo.content!.isEmpty)) &&
            (searchText.isEmpty || todo.content!.contains(searchText) || (todo.content?.contains(searchText) ?? false))
        }
    }

   
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
