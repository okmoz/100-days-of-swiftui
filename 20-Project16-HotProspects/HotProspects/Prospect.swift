//
//  Prospect.swift
//  HotProspects
//
//  Created by Nazarii Zomko on 04.10.2022.
//

import SwiftUI


class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    var date = Date()
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    
    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
        people = []
        let url = getDocumentsDirectory().appendingPathComponent(saveKey)
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
            let url = getDocumentsDirectory().appendingPathComponent(saveKey)
            
            do {
                try encoded.write(to: url, options: [.atomic, .completeFileProtection])
            } catch {
                print("Could not save prospects")
            }
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send() // call this before the value changes
        prospect.isContacted.toggle()
        save()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
