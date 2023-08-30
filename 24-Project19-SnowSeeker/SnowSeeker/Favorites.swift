//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Nazarii Zomko on 15.10.2022.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String> = []
    private let saveKey = "Favorites"
    
    init() {
        load()
    }
    
    func load() {
        if let resortsData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedResorts = try? JSONDecoder().decode(Set<String>.self, from: resortsData) {
                resorts = decodedResorts
                return
            }
        }
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let encodedData = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
}
