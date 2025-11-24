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
            ?? Meal(idMeal: "0", strMeal: "Unknown", strArea: nil, strInstructions: nil,
                    strMealThumb: nil, strCategory: nil)
    }

    func searchMeals(name: String) async throws -> [Meal] {
        let query = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(base)/search.php?s=\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MealResponse.self, from: data).meals ?? []
    }
}
