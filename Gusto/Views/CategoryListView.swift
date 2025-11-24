//
//  CategoryListView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

struct CategoryListView: View {
    @StateObject private var vm = CategoryViewModel()

    var body: some View {
        NavigationStack {
            List(vm.categories) { cat in
                Text(cat.strCategory)
            }
            .navigationTitle("Categories")
            .task { await vm.loadCategories() }
        }
    }
}
