//
//  ExploreView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var vm = ExploreViewModel()
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                if let meal = vm.meal {

                    AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                        img.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    // Removed the fixed frame(height: 220) to allow the image to scale to the width.
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
                            favorites.add(meal)
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
