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
    @StateObject private var prefs = UserPreferences()
    @StateObject private var filterPrefs = FilterPreferences()

    var body: some Scene {
        WindowGroup {
            TabView {
                ExploreView()
                    .tabItem { Label("Explore", systemImage: "fork.knife") }

                GuessingGameView()
                    .tabItem { Label("Game", systemImage: "globe") }

                FavoritesView()
                    .tabItem { Label("Favorites", systemImage: "heart") }
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gear") }
            }
            .environmentObject(prefs)
            .environmentObject(filterPrefs)
        }
        .modelContainer(for: Meal.self)
    }
}
