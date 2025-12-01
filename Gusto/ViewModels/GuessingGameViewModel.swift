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
    @Published var isGuessed: Bool = false
    @Published var lives: Int = 4
    @Published var isGameOver: Bool = false
    
    // Track the current score
    @Published var currentScore: Int = 0

    var filterPrefs: FilterPreferences?
    // Property to hold injected user preferences 
    var userPrefs: UserPreferences?

    private let api = MealAPI()

    let areas = [
        "Italian","American","Mexican","Greek","Indian","British",
        "Japanese","Canadian","French","Chinese"
    ]

    func newRound() async {
        guard !isGameOver else { return }
        
        // MODIFIED: Reset current score for a new round
        if isGameOver { currentScore = 0 }
        
        feedback = ""
        isGuessed = false
        meal = try? await api.fetchRandomMeal()
        guard let correct = meal?.strArea else { return }

        // pick ONE wrong area
        let wrong = areas.filter { $0 != correct }.randomElement() ?? "Unknown"

        // 2 options: correct + wrong
        options = [correct, wrong].shuffled()
    }


    func guess(_ area: String) {
        guard let correct = meal?.strArea, !isGuessed else { return }
        
        isGuessed = true

        if area == correct {
            feedback = .correctStyle("Correct! 🎉")
            // NEW: Increase score on correct guess
            currentScore += 1
        } else {
            // Decrease lives on wrong answer
            lives -= 1
            if lives <= 0 {
                isGameOver = true
                feedback = .wrongStyle("Game Over! It was \(correct).")
                // NEW: Check and update best score
                if currentScore > (userPrefs?.bestScore ?? 0) {
                    userPrefs?.bestScore = currentScore
                }
            } else {
                feedback = .wrongStyle("Wrong — it was \(correct).")
            }
        }
    }
    
    // Function to restart the game
    func restartGame() async {
        // MODIFIED: Check and update best score before restarting
        if currentScore > (userPrefs?.bestScore ?? 0) {
            userPrefs?.bestScore = currentScore
        }
        lives = 4
        isGameOver = false
        currentScore = 0 // Ensure score is reset
        await newRound()
    }
}
