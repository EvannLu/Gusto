//
//  FavoritesStore.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation
import Combine

@MainActor
class FavoritesStore: ObservableObject {
    @Published var saved: [Meal] = []

    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask).first!
        .appendingPathComponent("favorites.json")
    }

    init() { load() }

    func add(_ meal: Meal) {
        guard !saved.contains(meal) else { return }
        saved.append(meal)
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(saved)
            try data.write(to: fileURL)
        } catch {
            print("Error saving:", error)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Meal].self, from: data)
        else { return }
        saved = decoded
    }
}
