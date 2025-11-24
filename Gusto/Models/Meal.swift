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

    var id: String { idMeal }
}
