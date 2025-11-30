//
//  MealAPI.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation

class MealAPI {
    private let base = "https://www.themealdb.com/api/json/v1/1"

    func fetchRandomMeal() async throws -> Meal {
        let url = URL(string: "\(base)/random.php")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // ⭐️ MODIFIED: Decode DecodableMeal and convert to Meal ⭐️
        let decodedResponse = try JSONDecoder().decode(MealResponse.self, from: data).meals?.first
        
        guard let decodableMeal = decodedResponse else {
            throw URLError(.badServerResponse) // Or another appropriate error
        }
        
        return Meal(from: decodableMeal)
    }

    func searchMeals(name: String) async throws -> [Meal] {
        let query = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(base)/search.php?s=\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode DecodableMeal array and map to Meal array 
        let decodedMeals = try JSONDecoder().decode(MealResponse.self, from: data).meals ?? []
        
        return decodedMeals.map { Meal(from: $0) }
    }
}
