//
//  GuessingGameViewModel.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI
import Combine

@MainActor
class GuessingGameViewModel: ObservableObject {
    @Published var meal: Meal?
    @Published var options: [String] = []
    @Published var feedback: AttributedString = ""
    @Published var isGuessed: Bool = false // New: Prevents skipping
    @Published var lives: Int = 4        // New: Game life counter
    @Published var isGameOver: Bool = false // New: Game end state

    private let api = MealAPI()

    let areas = [
        "Italian","American","Mexican","Greek","Indian","British",
        "Japanese","Canadian","French","Chinese"
    ]

    func newRound() async {
        guard !isGameOver else { return } // Stop loading if game is over
        
        feedback = ""
        isGuessed = false // Reset for a new round
        meal = try? await api.fetchRandomMeal()
        guard let correct = meal?.strArea else { return }

        // pick ONE wrong area
        let wrong = areas.filter { $0 != correct }.randomElement() ?? "Unknown"

        // 2 options: correct + wrong
        options = [correct, wrong].shuffled()
    }


    func guess(_ area: String) {
        guard let correct = meal?.strArea, !isGuessed else { return }
        
        isGuessed = true // Lock the guess

        if area == correct {
            feedback = .correctStyle("Correct! 🎉")
        } else {
            // New: Decrease lives on wrong answer
            lives -= 1
            if lives <= 0 {
                isGameOver = true
                feedback = .wrongStyle("Game Over! It was \(correct).")
            } else {
                feedback = .wrongStyle("Wrong — it was \(correct).")
            }
        }
    }
    
    // New: Function to restart the game
    func restartGame() async {
        lives = 4
        isGameOver = false
        await newRound()
    }
}
