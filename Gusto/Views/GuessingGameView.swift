//
//  GuessingGameView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

struct GuessingGameView: View {
    @StateObject private var vm = GuessingGameViewModel()
    
    @EnvironmentObject var filterPrefs: FilterPreferences
    @EnvironmentObject var userPrefs: UserPreferences

    var body: some View {
        NavigationStack {
            // Ensure VStack uses all vertical space
            VStack(spacing: 20) {
                
                // Combined Score and Lives HUD 
                HStack {
                    // Current Score
                    Text("Score: \(vm.currentScore)")
                        .font(.title3).bold()
                    
                    Spacer()
                    
                    // Lives Display (Relocated from toolbar)
                    Text("Lives: \(vm.lives)")
                        .font(.title3).bold()
                        .foregroundColor(vm.lives <= 1 ? .red : .primary)
                }
                .padding(.horizontal) // Add horizontal padding for a clean look

                if let meal = vm.meal {
                    
                    // NEW: Food image for hint
                    AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                        img.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxHeight: .infinity) // Maximize height in the Vstack
                    .cornerRadius(12)

                    // Hide food name — leave only question
                    Text("Where is this meal from?")
                        .font(.title2)
                        .bold()

                    // 2 buttons only
                    ForEach(vm.options, id: \.self) { option in
                        Button(option) {
                            withAnimation(.spring()) {
                                vm.guess(option)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(vm.isGuessed)
                    }

                    if !vm.feedback.characters.isEmpty {
                        Text(vm.feedback)
                            .multilineTextAlignment(.center)
                    }
                }

                // NEW: Conditional Button and Disabled state
                if vm.isGameOver {
                    Button("Restart Game") {
                        Task { await vm.restartGame() }
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Button("Next Meal") {
                        Task { await vm.newRound() }
                    }
                    .buttonStyle(.bordered)
                    .disabled(!vm.isGuessed) // Disable if the user hasn't guessed yet
                }

            }
            .padding()
            // Ensure VStack itself is maximized within the screen
            .frame(maxHeight: .infinity)
            .navigationTitle("Guessing Game")
            // REMOVED: The entire .toolbar section
            .onAppear {
                vm.filterPrefs = filterPrefs
                vm.userPrefs = userPrefs
                Task { await vm.newRound() }
            }
        }
    }
}
