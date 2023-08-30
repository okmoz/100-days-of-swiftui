//
//  DiceItem.swift
//  DiceRoll
//
//  Created by Nazarii Zomko on 13.10.2022.
//

import Foundation

struct DiceItem: Identifiable, Equatable, Codable {
    var id = UUID()
    let number: Int
    let numberOfSides: Double
    
    static func ==(lhs: DiceItem, rhs: DiceItem) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = DiceItem(number: 5, numberOfSides: 6)
    
    static func getRandomDiceNumber(numberOfSides: Double) -> Int {
        Int.random(in: 1...Int(numberOfSides))
    }
    
    static func getDiceItemWithRandomNumber(numberOfSides: Double) -> DiceItem {
        return DiceItem(number: getRandomDiceNumber(numberOfSides: numberOfSides), numberOfSides: numberOfSides)
    }
}
