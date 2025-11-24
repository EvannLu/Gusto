//
//  FavoritesStore.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation
import Combine

class FavoritesStore: ObservableObject {

    // Auto-save whenever favorites change
    @Published var saved: [Meal] = [] {
        didSet { save() }
    }

    private let fileURL: URL

    init() {
        // Where the JSON file will live
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = docs.appendingPathComponent("favorites.json")

        load()
    }

    func add(_ meal: Meal) {
        if !saved.contains(meal) {
            saved.append(meal)
        }
    }


    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Meal].self, from: data) {
            self.saved = decoded
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(saved) {
            try? data.write(to: fileURL)
        }
    }
}
