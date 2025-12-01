//
//  FilterPreferences.swift
//  Gusto
//
//  Created by Evan Lu on 12/1/25.
//

import Foundation
import SwiftUI
import Combine

class FilterPreferences: ObservableObject {
    // Store the excluded list directly as Data in AppStorage
    @AppStorage("excludedIngredients", store: .standard) var excludedData: Data = Data()

    // Computed property to easily access the list as an Array of Strings
    var excludedIngredients: [String] {
        get {
            // Attempt to decode the stored Data back into an array of Strings
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([String].self, from: excludedData) {
                return decoded
            }
            return []
        }
        set {
            // Attempt to encode the Array of Strings into Data for AppStorage
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue.sorted()) {
                excludedData = encoded
            }
        }
    }
    
    // Helper function to check if a meal should be filtered out
    func containsExcludedIngredient(meal: Meal) -> Bool {
        guard !excludedIngredients.isEmpty else { return false }
        
        let excludedSet = Set(excludedIngredients.map { $0.lowercased() })
        
        // Check against the new rawIngredientNames property 
        let mealIngredients = meal.rawIngredientNames.map { $0.lowercased() }
        
        for excludedWord in excludedSet {
            // Find an ingredient in the meal that CONTAINS the excluded word
            if mealIngredients.contains(where: { $0.contains(excludedWord) }) {
                return true
            }
        }
        return false
    }
}
