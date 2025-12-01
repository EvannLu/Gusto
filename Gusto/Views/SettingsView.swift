//
//  SettingsView.swift
//  Gusto
//
//  Created by Evan Lu on 12/1/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    @EnvironmentObject var filterPrefs: FilterPreferences
    // Inject UserPreferences to read best score
    @EnvironmentObject var userPrefs: UserPreferences
    
    @State private var excludedSet: Set<String> = []

    init() {}

    var body: some View {
        NavigationStack {
            List {
                
                // Best Score Section 
                Section("Game Statistics") {
                    HStack {
                        Text("Highest Score Achieved")
                        Spacer()
                        Text("\(userPrefs.bestScore)")
                            .font(.title2).bold()
                    }
                }
                
                // Combined Section for Filters (Tags, Search Input, and Compact Results)
                Section("Ingredient Filters (\(excludedSet.count) Selected)") {
                    
                    // --- 1. Current Selections (Tags) ---
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Array(excludedSet).sorted(), id: \.self) { ingredient in
                                Button {
                                    toggleSelection(ingredient) // Removes ingredient
                                } label: {
                                    HStack {
                                        Text(ingredient)
                                        Image(systemName: "xmark.circle.fill")
                                    }
                                }
                                .buttonStyle(.bordered)
                                .padding(.trailing, 2)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    
                    // Fix for vertical spacing
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // --- 2. Smart Search Input ---
                        TextField("Search ingredients...", text: $vm.searchText)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)
                        
                        // Custom separator for tight spacing
                        Rectangle()
                            .fill(Color(uiColor: .separator)) // Use system separator color
                            .frame(height: 1)
                            .padding(.top, 4)
                            .padding(.bottom, 4)
                        
                        // --- 3. Compact, Scrollable Results ---
                        if vm.isLoading {
                            ProgressView("Loading Ingredients...")
                                .frame(maxWidth: .infinity)
                        }
                        else if !vm.searchText.isEmpty {
                            if vm.filteredIngredients.isEmpty {
                                Text("No results for \"\(vm.searchText)\"")
                                    .foregroundColor(.secondary)
                            } else {
                                
                                // Fixed-height ScrollView for compactness
                                ScrollView {
                                    VStack(spacing: 0) {
                                        // Limit the displayed results to a reasonable number (e.g., 30)
                                        ForEach(vm.filteredIngredients.prefix(30), id: \.self) { ingredient in
                                            MultipleSelectionRow(
                                                title: ingredient,
                                                isSelected: excludedSet.contains(ingredient)
                                            ) {
                                                toggleSelection(ingredient)
                                            }
                                            .padding(.vertical, 4) // Compact vertical padding
                                            Divider() // Separate rows cleanly
                                        }
                                    }
                                }
                                // Set a fixed height (up to 250pts)
                                .frame(height: min(CGFloat(vm.filteredIngredients.prefix(30).count) * 44, 250))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Ingredient Filters")
            // Cleanup and Persistence Logic
            .task { await vm.loadIngredients() }
            .onAppear {
                // Initialize the Set from the persistent storage Array when view appears
                excludedSet = Set(filterPrefs.excludedIngredients)
            }
            .onDisappear {
                // Save the Set back to the persistent storage Array when view disappears
                filterPrefs.excludedIngredients = Array(excludedSet)
            }
        }
    }
    
    func toggleSelection(_ ingredient: String) {
        if excludedSet.contains(ingredient) {
            excludedSet.remove(ingredient)
        } else {
            excludedSet.insert(ingredient)
        }
        vm.searchText = ""
    }
}

// Helper View for Checkmarks (Must be available in the project)
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }
            .contentShape(Rectangle())
        }
        .foregroundColor(.primary)
    }
}
