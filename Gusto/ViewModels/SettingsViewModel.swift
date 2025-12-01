//
//  SettingsViewModel.swift
//  Gusto
//
//  Created by Evan Lu on 12/1/25.
//

import Foundation
import Combine

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var availableIngredients: [Ingredient] = []
    @Published var isLoading = false
    // User's search text
    @Published var searchText: String = ""
    
    private let api = CategoryAPI()

    // Computed property to filter ingredients based on search text 
    var filteredIngredients: [String] {
        let allIngredients = availableIngredients.map { $0.strIngredient1 }
        
        if searchText.isEmpty {
            return allIngredients.sorted()
        } else {
            return allIngredients
                .filter { $0.localizedCaseInsensitiveContains(searchText) }
                .sorted()
        }
    }

    func loadIngredients() async {
        guard availableIngredients.isEmpty else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.availableIngredients = try await api.fetchIngredients()
        } catch {
            print("Failed to fetch ingredients: \(error)")
        }
    }
}
