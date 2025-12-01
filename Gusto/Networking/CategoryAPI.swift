//
//  CategoryAPI.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation

// Existing structs for category fetching
struct Category: Codable, Identifiable {
    let idCategory: String
    let strCategory: String
    var id: String { idCategory }
}

struct CategoryResponse: Codable {
    let categories: [Category]
}

// Structs for ingredient list fetching 
struct Ingredient: Decodable, Identifiable {
    // Note: The API uses "strIngredient" as the key, but we want the property to be strIngredient1
    let strIngredient1: String
    var id: String { strIngredient1 }
    
    // Use CodingKeys to map the API key "strIngredient" to the property strIngredient1
    enum CodingKeys: String, CodingKey {
        case strIngredient1 = "strIngredient"
    }
}

struct IngredientResponse: Decodable {
    let meals: [Ingredient]
}

class CategoryAPI {
    private let url = URL(string:
      "https://www.themealdb.com/api/json/v1/1/categories.php")!
    
    // URL for ingredient list
    private let listUrl = URL(string:
      "https://www.themealdb.com/api/json/v1/1/list.php?i=list")!

    func fetchCategories() async throws -> [Category] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(CategoryResponse.self, from: data).categories
    }
    
    // Function to fetch the full list of ingredients
    func fetchIngredients() async throws -> [Ingredient] {
        let (data, _) = try await URLSession.shared.data(from: listUrl)
        return try JSONDecoder().decode(IngredientResponse.self, from: data).meals
    }
}
