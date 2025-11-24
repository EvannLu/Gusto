//
//  GustoApp.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

@main
struct GustoApp: App {
    @StateObject private var favorites = FavoritesStore()
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
            .environmentObject(favorites)
            .environmentObject(prefs)
        }
    }
}

