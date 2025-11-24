//
//  CategoryAPI.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation

struct Category: Codable, Identifiable {
    let idCategory: String
    let strCategory: String
    var id: String { idCategory }
}

struct CategoryResponse: Codable {
    let categories: [Category]
}

class CategoryAPI {
    private let url = URL(string:
      "https://www.themealdb.com/api/json/v1/1/categories.php")!

    func fetchCategories() async throws -> [Category] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(CategoryResponse.self, from: data).categories
    }
}
