//
//  QuestionsManager.swift
//  Edutainment
//
//  Created by Nazarii Zomko on 27.08.2022.
//

import Foundation

struct QuestionsManager {
    
    static func generateQuestions(tableUpTo: Int, numberOfQuestions: Int) -> [Question] {
        var generatedQuestions = [Question]()
        for _ in 0..<numberOfQuestions {
            generatedQuestions.append(Question(
                numberOne: Int.random(in: 1...tableUpTo),
                numberTwo: Int.random(in: 1...tableUpTo))
            )
        }
        return generatedQuestions
    }
}


