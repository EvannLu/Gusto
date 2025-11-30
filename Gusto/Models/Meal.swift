//
//  Meal.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation
import SwiftData

@Model
final class Meal: Identifiable {
    // Changed all stored properties from 'let' to 'var'
    var idMeal: String
    var strMeal: String
    var strArea: String?
    var strInstructions: String?
    var strMealThumb: String?
    var strCategory: String?
    
    // Ingredient fields exactly as returned by TheMealDB
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    
    // Measure fields exactly as returned by TheMealDB
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    
    // NEW: Required initializer for Codable data used by API
    init(idMeal: String, strMeal: String, strArea: String?, strInstructions: String?, strMealThumb: String?, strCategory: String?, strIngredient1: String?, strIngredient2: String?, strIngredient3: String?, strIngredient4: String?, strIngredient5: String?, strIngredient6: String?, strIngredient7: String?, strIngredient8: String?, strIngredient9: String?, strIngredient10: String?, strIngredient11: String?, strIngredient12: String?, strIngredient13: String?, strIngredient14: String?, strIngredient15: String?, strIngredient16: String?, strIngredient17: String?, strIngredient18: String?, strIngredient19: String?, strIngredient20: String?, strMeasure1: String?, strMeasure2: String?, strMeasure3: String?, strMeasure4: String?, strMeasure5: String?, strMeasure6: String?, strMeasure7: String?, strMeasure8: String?, strMeasure9: String?, strMeasure10: String?, strMeasure11: String?, strMeasure12: String?, strMeasure13: String?, strMeasure14: String?, strMeasure15: String?, strMeasure16: String?, strMeasure17: String?, strMeasure18: String?, strMeasure19: String?, strMeasure20: String?) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strCategory = strCategory
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strIngredient6 = strIngredient6
        self.strIngredient7 = strIngredient7
        self.strIngredient8 = strIngredient8
        self.strIngredient9 = strIngredient9
        self.strIngredient10 = strIngredient10
        self.strIngredient11 = strIngredient11
        self.strIngredient12 = strIngredient12
        self.strIngredient13 = strIngredient13
        self.strIngredient14 = strIngredient14
        self.strIngredient15 = strIngredient15
        self.strIngredient16 = strIngredient16
        self.strIngredient17 = strIngredient17
        self.strIngredient18 = strIngredient18
        self.strIngredient19 = strIngredient19
        self.strIngredient20 = strIngredient20
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.strMeasure6 = strMeasure6
        self.strMeasure7 = strMeasure7
        self.strMeasure8 = strMeasure8
        self.strMeasure9 = strMeasure9
        self.strMeasure10 = strMeasure10
        self.strMeasure11 = strMeasure11
        self.strMeasure12 = strMeasure12
        self.strMeasure13 = strMeasure13
        self.strMeasure14 = strMeasure14
        self.strMeasure15 = strMeasure15
        self.strMeasure16 = strMeasure16
        self.strMeasure17 = strMeasure17
        self.strMeasure18 = strMeasure18
        self.strMeasure19 = strMeasure19
        self.strMeasure20 = strMeasure20
    }
    
    // NEW: Convenience Initializer to convert DecodableMeal into SwiftData Meal
    convenience init(from decodableMeal: DecodableMeal) {
        self.init(
            idMeal: decodableMeal.idMeal,
            strMeal: decodableMeal.strMeal,
            strArea: decodableMeal.strArea,
            strInstructions: decodableMeal.strInstructions,
            strMealThumb: decodableMeal.strMealThumb,
            strCategory: decodableMeal.strCategory,
            strIngredient1: decodableMeal.strIngredient1,
            strIngredient2: decodableMeal.strIngredient2,
            strIngredient3: decodableMeal.strIngredient3,
            strIngredient4: decodableMeal.strIngredient4,
            strIngredient5: decodableMeal.strIngredient5,
            strIngredient6: decodableMeal.strIngredient6,
            strIngredient7: decodableMeal.strIngredient7,
            strIngredient8: decodableMeal.strIngredient8,
            strIngredient9: decodableMeal.strIngredient9,
            strIngredient10: decodableMeal.strIngredient10,
            strIngredient11: decodableMeal.strIngredient11,
            strIngredient12: decodableMeal.strIngredient12,
            strIngredient13: decodableMeal.strIngredient13,
            strIngredient14: decodableMeal.strIngredient14,
            strIngredient15: decodableMeal.strIngredient15,
            strIngredient16: decodableMeal.strIngredient16,
            strIngredient17: decodableMeal.strIngredient17,
            strIngredient18: decodableMeal.strIngredient18,
            strIngredient19: decodableMeal.strIngredient19,
            strIngredient20: decodableMeal.strIngredient20,
            strMeasure1: decodableMeal.strMeasure1,
            strMeasure2: decodableMeal.strMeasure2,
            strMeasure3: decodableMeal.strMeasure3,
            strMeasure4: decodableMeal.strMeasure4,
            strMeasure5: decodableMeal.strMeasure5,
            strMeasure6: decodableMeal.strMeasure6,
            strMeasure7: decodableMeal.strMeasure7,
            strMeasure8: decodableMeal.strMeasure8,
            strMeasure9: decodableMeal.strMeasure9,
            strMeasure10: decodableMeal.strMeasure10,
            strMeasure11: decodableMeal.strMeasure11,
            strMeasure12: decodableMeal.strMeasure12,
            strMeasure13: decodableMeal.strMeasure13,
            strMeasure14: decodableMeal.strMeasure14,
            strMeasure15: decodableMeal.strMeasure15,
            strMeasure16: decodableMeal.strMeasure16,
            strMeasure17: decodableMeal.strMeasure17,
            strMeasure18: decodableMeal.strMeasure18,
            strMeasure19: decodableMeal.strMeasure19,
            strMeasure20: decodableMeal.strMeasure20
        )
    }

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
