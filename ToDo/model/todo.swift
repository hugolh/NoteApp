//
//  todo.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import SwiftUI
import Foundation



struct Note: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    let date: Date
    var content: String?
    var isStar: Bool?
}


func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.timeZone = TimeZone.current
    let calendar = Calendar.current
    return calendar.date(from: components)!
}


