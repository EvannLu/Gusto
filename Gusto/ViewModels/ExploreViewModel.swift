//
//  ExploreViewModel.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation
import Combine

@MainActor
class ExploreViewModel: ObservableObject {
    @Published var meal: Meal?
    @Published var isLoading = false
    
    private let api = MealAPI()

    func loadRandom() async {
        isLoading = true
        defer { isLoading = false }
        meal = try? await api.fetchRandomMeal()
    }
}
