//
//  MealCardView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

struct MealCardView: View {
    let meal: Meal

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 150).clipped()

            Text(meal.strMeal)
                .font(.headline)
                .padding(.top, 5)
        }
        .cardStyle()
    }
}
