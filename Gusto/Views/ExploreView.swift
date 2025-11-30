//
//  ExploreView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI
import SwiftData

struct ExploreView: View {
    @StateObject private var vm = ExploreViewModel()
    @EnvironmentObject var favorites: FavoritesStore // Kept as placeholder
    
    // NEW: SwiftData Context
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                if let meal = vm.meal {

                    AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                        img.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(12)

                    // NEW: More info under image
                    Text(meal.strMeal)
                        .font(.title2).bold()

                    Text("Category: \(meal.strCategory ?? "Unknown")")
                        .foregroundColor(.secondary)

                    Text("Region: \(meal.strArea ?? "Unknown")")
                        .foregroundColor(.secondary)

                    Button("Save to Favorites") {
                        withAnimation {
                            // MODIFIED: Use modelContext to insert the new Meal
                            if let newMeal = vm.meal {
                                // Extract the ID into a local constant
                                let mealID = newMeal.idMeal
                                
                                // Check if a Meal with this ID already exists (step for preventing duplicates)
                                // Use the local constant mealID 
                                let predicate = #Predicate<Meal> { $0.idMeal == mealID }
                                
                                if (try? modelContext.fetchCount(FetchDescriptor(predicate: predicate))) == 0 {
                                     modelContext.insert(newMeal)
                                }
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                Button("Discover New Recipe") {
                    Task { await vm.loadRandom() }
                }
                .buttonStyle(.bordered)

            }
            .padding()
            .navigationTitle("Explore")
            .task { await vm.loadRandom() }
        }
    }
}
