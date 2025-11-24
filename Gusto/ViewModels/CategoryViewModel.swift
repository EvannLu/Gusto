//
//  CategoryViewModel.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import Foundation
import Combine

@MainActor
class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []

    private let api = CategoryAPI()

    func loadCategories() async {
        categories = (try? await api.fetchCategories()) ?? []
    }
}
