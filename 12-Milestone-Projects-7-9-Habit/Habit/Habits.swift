//
//  Habits.swift
//  Habit
//
//  Created by Nazarii Zomko on 07.09.2022.
//

import SwiftUI

class Habits: ObservableObject {
    @Published var items = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItemsData = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItemsData) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func update(habit: Habit) {
        guard let habitIndex = items.firstIndex(where: {$0.id == habit.id}) else { return }
        items[habitIndex] = habit
    }
    
    func add(habit: Habit) {
        items.insert(habit, at: 0)
    }
    
    func delete(habit: Habit) {
        items.removeAll(where: {$0.id == habit.id})
    }
}
