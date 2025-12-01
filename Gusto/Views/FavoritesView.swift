//
//  FavoritesView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    // Replace @EnvironmentObject with @Query
    @Query(sort: \Meal.strMeal) private var favorites: [Meal]
    @Environment(\.modelContext) private var modelContext
    @State private var selectedMeal: Meal?

    init() {} 
    
    var body: some View {
        NavigationStack {
            List {
                // favorites is now the @Query result
                ForEach(favorites) { meal in
                    MealCardView(meal: meal)
                        .onTapGesture {
                            selectedMeal = meal
                        }
                }
                .onDelete(perform: deleteMeals) // Call a new delete function
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
    
    // Function to handle SwiftData deletion
    func deleteMeals(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let meal = favorites[index]
                modelContext.delete(meal)
            }
        }
    }
}
