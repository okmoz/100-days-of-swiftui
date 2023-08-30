//
//  Habit.swift
//  Habit
//
//  Created by Nazarii Zomko on 07.09.2022.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var title: String
    var motivation: String
    var checkedDates: [Date]
    @CodableColor var color: UIColor
    
    var percentage: Int {
        checkedDates.count * 5
    }
    
    mutating func addDate(_ date: Date) {
        checkedDates.append(date)
    }
    
    mutating func removeDate(_ date: Date) {
        checkedDates.removeAll(where: { Calendar.current.isDate($0, inSameDayAs: date) } )
    }
}
