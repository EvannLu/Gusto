//
//  FavoritesView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesStore
    @State private var selectedMeal: Meal?

    var body: some View {
        NavigationStack {
            List {
                ForEach(favorites.saved) { meal in
                    MealCardView(meal: meal)
                        .onTapGesture {
                            selectedMeal = meal
                        }
                }
                .onDelete { indexSet in
                    favorites.saved.remove(atOffsets: indexSet)
                    // REMOVED: favorites.save()  ← Do NOT call this for Option B
                }
            }
            .navigationTitle("My Cookbook")
            .toolbar {
                EditButton()
            }
            .sheet(item: $selectedMeal) { meal in
                FavoriteDetailView(meal: meal)
            }
        }
    }
}
