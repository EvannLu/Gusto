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
                    Text("Where is this meal from?")
                        .font(.title2)

                    Text(meal.strMeal)
                        .font(.title3)
                        .bold()

                    ForEach(vm.options, id: \.self) { option in
                        Button(option) {
                            withAnimation(.spring()) {
                                vm.guess(option)
                            }
                        }
                        .buttonStyle(.bordered)
                    }

                    if !vm.feedback.characters.isEmpty {
                        Text(vm.feedback)
                            .multilineTextAlignment(.center)
                    }
                }

                Button("Next Meal") {
                    Task { await vm.newRound() }
                }
                .buttonStyle(.borderedProminent)

            }
            .padding()
            .navigationTitle("Guessing Game")
            .task { await vm.newRound() }
        }
    }
}
