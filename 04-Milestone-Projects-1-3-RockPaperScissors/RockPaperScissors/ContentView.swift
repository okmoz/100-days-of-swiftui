//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nazarii Zomko on 22.08.2022.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✋", "✊", "✌️"]
    @State private var score = 0
    @State private var currentChoice = 0
    @State private var shouldWin = true
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.largeTitle)
            Spacer()
            VStack(spacing: 15) {
                Text(moves[currentChoice])
                .font(.system(size: 100))
                .padding()
                
                HStack(spacing: 0) {
                    Text("Pick a move to \(shouldWin ? "WIN": "LOSE")")
                }
                .padding()

                HStack(spacing: 20) {
                    ForEach(0..<3) { index in
                        Button(moves[index]) {
                            checkMove(index)
                        }
                    }
                }
                .font(.system(size: 69))
            }
            Spacer()
        }
    }
    
    func checkMove(_ move: Int) {
        var correctMove = currentChoice
        correctMove += shouldWin ? -1 : 1
        
        if correctMove > 2 {
            correctMove = 0
        } else if correctMove < 0 {
            correctMove = 2
        }
        
        if move == correctMove {
            score += 1
        } else {
            score -= 1
        }
        startNewGame()
    }
    
    func startNewGame() {
        shouldWin = Bool.random()
        currentChoice = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
