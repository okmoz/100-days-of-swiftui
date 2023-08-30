//
//  ContentView-ViewModel.swift
//  DiceRoll
//
//  Created by Nazarii Zomko on 14.10.2022.
//

import CoreHaptics
import SwiftUI

extension ContentView {
    @MainActor class ContentViewVM: ObservableObject {
        @Published private(set) var diceItems = [DiceItem(number: 3, numberOfSides: 6)]
        @Published var numberOfSides = 6.0
        @Published var numberOfDices = 1 {
            didSet {
                updateDiceItemsArray()
            }
        }
        @Published var total = 0
        @Published var isDicesFlicking = false
        @Published var isRollButtonDisabled = false
        
        @Published var hapticEngine: CHHapticEngine?
        
        let historyVM = HistoryViewVM()
        
        init() {
            updateTotal()
            prepareHaptics()
        }
        
        func prepareHaptics() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            do {
                hapticEngine = try CHHapticEngine()
                try hapticEngine?.start()
            } catch {
                print("Error creating haptics: \(error.localizedDescription)")
            }
        }
        
        func generateHapticComplexSuccess() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            var events = [CHHapticEvent]()
            
            for i in stride(from: 0, to: 1, by: 0.1) {
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
                let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
                events.append(event)
            }
            
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try hapticEngine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription)")
            }
        }
        
        func generateHapticSimpleSuccess() {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
        // we need this as a function because total should only be updated when dices stop flicking.
        func updateTotal() {
            total = diceItems.reduce(0) { $0 + $1.number }
        }
        
        func updateDiceItemsArray() {
            let numberOfDices = Int(numberOfDices)
            if numberOfDices > diceItems.count {
                let newDiceItem = DiceItem.getDiceItemWithRandomNumber(numberOfSides: numberOfSides)
                diceItems.append(newDiceItem)
            }
            else {
                diceItems = Array(diceItems[0..<numberOfDices])
            }
            updateTotal()
        }
        
        func rollDices() {
            generateHapticComplexSuccess()
            isDicesFlicking = true
            isRollButtonDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.79) {
                for index in 0..<self.diceItems.count {
                    self.diceItems[index] = DiceItem.getDiceItemWithRandomNumber(numberOfSides: self.numberOfSides)
                }
                self.isDicesFlicking = false
                self.isRollButtonDisabled = false
                self.updateTotal()
                self.saveToHistory()
            }
        }
        
        func saveToHistory() {
            historyVM.addNewEntry(diceItems: diceItems)
        }
    }
}
