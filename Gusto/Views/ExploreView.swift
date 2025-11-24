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
            VStack {
                if vm.isLoading {
                    Spinner()
                } else if let meal = vm.meal {
                    MealCardView(meal: meal)

                    Button("Save to Favorites") {
                        withAnimation { favorites.add(meal) }
                    }
                    .buttonStyle(.borderedProminent)
                }

                Button("Discover New Recipe") {
                    Task { await vm.loadRandom() }
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle("Explore")
            .task { await vm.loadRandom() }
        }
    }
}
