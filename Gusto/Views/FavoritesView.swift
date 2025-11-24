//
//  FavoritesView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        NavigationStack {
            List(favorites.saved) { meal in
                MealCardView(meal: meal)
            }
            .navigationTitle("My Cookbook")
        }
    }
}
