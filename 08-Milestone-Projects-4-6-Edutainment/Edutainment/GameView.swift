//
//  GameView.swift
//  Edutainment
//
//  Created by Nazarii Zomko on 28.08.2022.
//

import SwiftUI

struct GameView: View {    
    @FocusState private var answerFieldFocused: Bool
    
    @State private var score = 0
    
    @State private var answerNumber = ""
    @State private var currentQuestion = 0
    
    @State private var questions = [Question]()
    
    @State private var gameEndedAlertShowing = false
    
    
    var questionText: String {
        questions.isEmpty ? "_ × _" : "\(questions[currentQuestion].numberOne) × \(questions[currentQuestion].numberTwo)"
    }
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text(questionText)
                    .font(.largeTitle)
                Text("=")
                    .font(.largeTitle)
                TextField("Answer", text: $answerNumber)
                    .font(.largeTitle)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .focused($answerFieldFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Dismiss") {
                                answerFieldFocused = false
                            }
                            Spacer()
                            Button("Submit") {
                                submitTapped()
                            }
                        }
                    }
            }
            .navigationTitle("Multiplication")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Question \(currentQuestion + 1)/\(questions.count), Score \(score)")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Game") {
                        startNewGame()
                    }
                }
            }
        }
        .onAppear(perform: startNewGame)
        .navigationViewStyle(.stack) // fixes Xcode complaints about constraints when using .navigationTitle() (likely an Xcode bug)
        .alert("Game Ended", isPresented: $gameEndedAlertShowing) {
            Button("New Game", action: startNewGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func startNewGame() {
        questions = QuestionsManager.generateQuestions(tableUpTo: 10, numberOfQuestions: 15)
        currentQuestion = 0
        score = 0
    }
    
    func submitTapped() {
        let correctAnswer = questions[currentQuestion].numberOne * questions[currentQuestion].numberTwo
        if Int(answerNumber) == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
            
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            gameEndedAlertShowing = true
        }
        
        answerNumber = ""
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
