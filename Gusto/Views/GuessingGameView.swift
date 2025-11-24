//
//  GuessingGameView.swift
//  Gusto
//
//  Created by Evan Lu on 11/13/25.
//

import SwiftUI

struct GuessingGameView: View {
    @StateObject private var vm = GuessingGameViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                if let meal = vm.meal {
                    
                    //Image sizing using GeometryReader
                    GeometryReader { geo in
                        AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                            img.resizable().scaledToFill() // scaledToFill to fill the width
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: geo.size.width, height: 250) // Use full width, fixed height
                        .clipped() // Clip to the frame
                        .cornerRadius(12)
                    }
                    .frame(height: 250) // Set container height
                    
                    Text("Where is this meal from?")
                        .font(.title2)
                        .bold()

                    // Disable buttons once a guess is made
                    ForEach(vm.options, id: \.self) { option in
                        Button(option) {
                            withAnimation(.spring()) {
                                vm.guess(option)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(vm.isGuessed) // Disable button after guess
                    }

                    if !vm.feedback.characters.isEmpty {
                        Text(vm.feedback)
                            .multilineTextAlignment(.center)
                    }
                }

                // Conditional Button and Disabled state
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
            .navigationTitle("Guessing Game")
            // Display lives in the toolbar 
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Text("Lives: \(vm.lives)")
                        .font(.headline)
                        .foregroundColor(vm.lives <= 1 ? .red : .primary)
                }
            }
            .task { await vm.newRound() }
        }
    }
}
