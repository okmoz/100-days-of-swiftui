//
//  HistoryEntry.swift
//  DiceRoll
//
//  Created by Nazarii Zomko on 14.10.2022.
//

import Foundation

struct HistoryEntry: Identifiable, Codable {
    var id = UUID()
    let diceItems: [DiceItem]
    let date: Date
}
