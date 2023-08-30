//
//  HistoryView-ViewModel.swift
//  DiceRoll
//
//  Created by Nazarii Zomko on 14.10.2022.
//

import Foundation


@MainActor class HistoryViewVM: ObservableObject {
    @Published private(set) var historyEntries = [HistoryEntry]()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedHistory")
    
    init() {
        loadEntries()
    }

    private func loadEntries(){
        do {
            let data = try Data(contentsOf: savePath)
            historyEntries = try JSONDecoder().decode([HistoryEntry].self, from: data)
        } catch {
            historyEntries = [] // I think this might be potentially dangerous; what happens if we, for some reason, get an error while loading entries and thus assign an empty array to it, which we will save later to the same directory, overriding previous data?
        }
    }
    
    func remove(at offsets: IndexSet) {
        historyEntries.remove(atOffsets: offsets)
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(historyEntries)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func addNewEntry(diceItems: [DiceItem]) {
        let newEntry = HistoryEntry(diceItems: diceItems, date: Date())
        historyEntries.insert(newEntry, at: 0)
        save()
    }
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
