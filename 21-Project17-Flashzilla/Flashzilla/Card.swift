//
//  Card.swift
//  Flashzilla
//
//  Created by Nazarii Zomko on 11.10.2022.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played 13 dr. Who?", answer: "Jodie Whittaker")
}
