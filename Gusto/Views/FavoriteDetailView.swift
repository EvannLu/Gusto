//
//  FavoriteDetailView.swift
//  Gusto
//
//  Created by Evan Lu on 11/24/25.
//

import SwiftUI

struct FavoriteDetailView: View {
    let meal: Meal

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {

                AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)

                Text("Category: \(meal.strCategory ?? "Unknown")")
                Text("Region: \(meal.strArea ?? "Unknown")")

                Text("Instructions")
                    .font(.headline)
                Text(meal.strInstructions ?? "No instructions available.")

                Text("Ingredients")
                    .font(.headline)

                ForEach(meal.ingredients, id: \.self) { ing in
                    Text("• \(ing)")
                }

            }
            .padding()
        }
        .presentationDetents([.medium, .large])
    }
}
