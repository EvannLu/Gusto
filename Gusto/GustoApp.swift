//
//  GustoApp.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI
import SwiftData

@main
struct GustoApp: App {
    // Removed the FavoritesStore StateObject
    @StateObject private var prefs = UserPreferences()

    var body: some Scene {
        WindowGroup {
            TabView {
                ExploreView()
                    .tabItem { Label("Explore", systemImage: "fork.knife") }

                GuessingGameView()
                    .tabItem { Label("Game", systemImage: "globe") }

                FavoritesView()
                    .tabItem { Label("Favorites", systemImage: "heart") }
            }
            // Removed environmentObject(favorites)
            .environmentObject(prefs)
        }
        // NEW: Add the modelContainer for the Meal model
        .modelContainer(for: Meal.self)
    }
}
