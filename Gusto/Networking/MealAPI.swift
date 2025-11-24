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
        return try JSONDecoder().decode(MealResponse.self, from: data).meals?.first
            ?? Meal(
                idMeal: "0",
                strMeal: "Unknown",
                strArea: "Unknown",
                strInstructions: "No instructions available.",
                strMealThumb: nil,
                strCategory: "Unknown",
                
                // 20 ingredient fields
                strIngredient1: nil, strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil,
                strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil,
                strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil,
                strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil,

                // 20 measure fields
                strMeasure1: nil, strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil,
                strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil,
                strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil,
                strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil
            )
    }

    func searchMeals(name: String) async throws -> [Meal] {
        let query = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(base)/search.php?s=\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MealResponse.self, from: data).meals ?? []
    }
}
