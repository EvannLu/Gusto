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
    
    private let api = MealAPI()

    let areas = [
        "Italian","American","Mexican","Greek","Indian","British",
        "Japanese","Canadian","French","Chinese"
    ]

    func newRound() async {
        feedback = ""
        meal = try? await api.fetchRandomMeal()
        guard let area = meal?.strArea else { return }

        var wrong = Array(areas.shuffled().prefix(3))
        wrong.append(area)
        options = wrong.shuffled()
    }

    func guess(_ area: String) {
        guard let correct = meal?.strArea else { return }

        if area == correct {
            feedback = .correctStyle("Correct! 🎉")
        } else {
            feedback = .wrongStyle("Wrong — it was \(correct).")
        }
    }
}
