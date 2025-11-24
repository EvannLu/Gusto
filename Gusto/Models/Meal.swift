//
//  Meal.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation

struct Meal: Identifiable, Codable, Equatable {
    let idMeal: String
    let strMeal: String
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strCategory: String?
    
    // Ingredient fields exactly as returned by TheMealDB
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    // Measure fields exactly as returned by TheMealDB
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    var id: String { idMeal }
    
    // Computed property that returns non-empty "ingredient — measure" strings
    var ingredients: [String] {
        var results: [String] = []
        
        let ingredientList: [String?] = [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ]
        
        let measureList: [String?] = [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
            strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        ]
        
        for i in 0..<20 {
            let ing = ingredientList[i]?.trimmingCharacters(in: .whitespacesAndNewlines)
            let meas = measureList[i]?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let ing = ing, !ing.isEmpty {
                if let meas = meas, !meas.isEmpty {
                    results.append("\(ing) — \(meas)")
                } else {
                    results.append(ing)
                }
            }
        }
        
        return results
    }
}
