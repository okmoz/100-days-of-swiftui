//
//  DiceView.swift
//  DiceRoll
//
//  Created by Nazarii Zomko on 13.10.2022.
//

import SwiftUI

struct DiceView: View {
    let diceItem: DiceItem
    @State private var number = 3
    @State private var lastRandomNumber = 1
    
    var isFlicking: Bool
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.gray)
                .frame(width: 100, height: 100)
            Text("\(isFlicking ? number : diceItem.number)")
                .foregroundColor(.white)
                .font(.title)
                .onReceive(timer) { _ in
                    flick()
                }
                .onChange(of: isFlicking) { isFlicking in
                    manageFlickingChanged(to: isFlicking)
                }
        }
    }
    
    func manageFlickingChanged(to isOn: Bool) {
        if isOn {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    func flick() {
        if isFlicking {
            var newRandomNumber = lastRandomNumber
            while newRandomNumber == lastRandomNumber {
                newRandomNumber = DiceItem.getRandomDiceNumber(numberOfSides: diceItem.numberOfSides)
            }
            lastRandomNumber = newRandomNumber
            number = newRandomNumber
        }
    }
    
    func startTimer() {
        timer = timer.upstream.autoconnect()
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(diceItem: DiceItem.example, isFlicking: true)
    }
}
