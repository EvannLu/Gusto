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
    
    // Property to hold injected filter preferences
    var filterPrefs: FilterPreferences?
    
    private let api = MealAPI()

    func loadRandom() async {
        isLoading = true
        defer { isLoading = false }
        
        // Loop up to 10 times to find a compliant meal
        for _ in 0..<10 {
            meal = try? await api.fetchRandomMeal()
            
            // Check if filtering is active and if the meal is compliant
            if let currentMeal = meal, !(filterPrefs?.containsExcludedIngredient(meal: currentMeal) ?? false) {
                return // Found a good meal!
            } else if meal == nil {
                break // Stop if API call failed
            }
            // If the meal contains an excluded ingredient, the loop continues to fetch the next one.
        }
        
        if filterPrefs?.excludedIngredients.count ?? 0 > 0 {
             print("Could not find a compliant meal after 10 tries.")
        }
    }
}
